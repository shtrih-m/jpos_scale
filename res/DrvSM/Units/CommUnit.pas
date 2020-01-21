unit CommUnit;

interface

uses Windows, SysUtils,  Registry, syncobjs, Forms, MyCOM,
     Classes;

const
  STX = $02;
  STE = $03;
  ENQ = $05;
  ACK = $06;
  NAK = $15;
  BUSY= $0b;

type
  TCommSM = class
  private
    FCOM: TCommExchange;
    cs:TCriticalSection;
    FBaudRate: Cardinal;
    FTimeout: Cardinal;
    FComNumber: Cardinal;
    FInput: string;
    FOutput: string;
    isCorrectDevice: boolean;
    procedure Set_BaudRate(const Value: Cardinal);
    procedure Set_ComNumber(const Value: Cardinal);
    procedure Set_TimeOut(const Value: Cardinal);
    function ObmenCOM(var s: string): integer;
    procedure Set_CorrectDevice(const Value: boolean);
  public
    constructor Create;
    destructor Destroy; override;
    function OpenCom:integer;
    function CloseCom:integer;
    function Obmen(var s:string):integer;
    procedure AddCRC(var s:string);
  published
    // RS232C properties
    property ComNumber: Cardinal read FComNumber write Set_ComNumber default 1;
    property BaudRate: Cardinal read FBaudRate write Set_BaudRate default 1;
    property TimeOut: Cardinal read FTimeout write Set_TimeOut default 100;
    // общие
    property Input: string read FInput;
    property Output: string read FOutput;
    property CorrectDevice: boolean read isCorrectDevice write Set_CorrectDevice default true;
  end;

implementation

{ TCommM5 }

procedure TCommSM.AddCRC(var s: string);
var i:integer;
    crc:byte;
begin
  crc:=0;
  for i:=2 to length(s) do crc:=crc xor ord(s[i]);
  s:=s+chr(crc);
end;

function TCommSM.CloseCom: integer;
begin
  FCOM.CloseCom;
  Result:=0;
end;

function TCommSM.ObmenCOM(var s: string):integer;
var i,j: integer;
    s1, s2: string;
    b: boolean;
    delay: word;
    Time: longword;
    len,crc,temp:byte;
    f: TFileStream;
  procedure Write(s:string);
  begin
  {$IFNDEF NODEBUG}
    f.Write(s[1],length(s));
  {$ENDIF}
  end;
begin
{$IFNDEF NODEBUG}
f:=TFileStream.Create('file.log',fmCreate);
{$ENDIF}
  for i:=1 to length(s) do FInput:=FInput+IntToHex(ord(s[i]),2)+' ';
  Write('********************************************'#13#10);
  Write(FInput+#13#10);
//если работаем по RS232
  for i:=1 to 2 do begin
  if i>1 then Sleep(500);
    // посылаем ENQ
  Write('-------------------------'#13#10);
  Write('попытка: '+inttostr(i)+#13#10);
  Write('-------------------------'#13#10);
  Write('посылка ENQ '+#13#10);
    if not FCOM.OutCom(Chr(ENQ)) then continue;
    // ждем ответ на ENQ
    Write('прием ответа '+#13#10);
    if not FCOM.InCom(s1,1,0) then continue;
    j:=ord(s1[1]);
    case j of
      NAK: begin
        Write('ответ NAK'+#13#10);
        Write('посылка запроса'+#13#10);
        if not FCOM.OutCom(s) then continue;
        Write('прием ответа '+#13#10);
        if not FCOM.Incom(s1,1,0) then begin Write('нет ответа'#13#10);continue; end;
        if ord(s1[1])<>ACK then begin; Write('ответ не ACK'#13#10);continue; end;
        Write('ответ ACK'+#13#10);
      end;
      else continue;
    end;
  // прием ответа
  //    прием STX
    delay:=1000;
    Time:=GetTickCount;
    Write('прием ответа '+#13#10);
    Repeat
      b:=FCOM.InCom(s1,1,0);
      if b then break;
    until (GetTickCount>Time+delay);
    if not b then continue;

    if ord(s1[1])<>STX then continue;
    Write('ответ ACK'+#13#10);

  //    прием длины
    Write('прием длины '+#13#10);
    if not FCOM.Incom(s1,1,0) then continue;
    Write('длина = '+s1[1]+#13#10);
    len:=ord(s1[1]);

  //    прием ответа
    temp:=len;
    Write('прием ответа на команду '+#13#10);
    if not FCOM.InCom(s1,temp,0) then continue;
    Write('ответ  = '+s1+#13#10);

  //    прием CRC
    Write('прием CRC '+#13#10);
    if not FCOM.InCom(s2,1,0) then continue;
    Write('CRC  = '+inttostr(ord(s2[1]))+#13#10);

  // проверка на правильность CRC
    crc:=len;
    for j:=1 to len do crc:=crc xor ord(s1[j]);

    if crc=Ord(s2[1]) then begin
      Write('CRC верно - посылаем ACK'+#13#10);
      if not FCOM.OutCom(Chr(ACK)) then continue;
      Write('ACK послан'+#13#10);
    end
    else begin
      Write('CRC не верно - посылаем NAK'+#13#10);
      FCOM.OutCom(Chr(NAK));
      Write('NAK послан'+#13#10);
      continue;
    end;
    break;
  end;
  s:='';
  if (i<3) and (Length(s1)>=2) then Result:=ord(s1[2])
  else Result:=-1;

  s:=chr(len)+s1+s2;
  if Result<>-1 then begin
    FOutput:=IntToHex(ord(STX),2)+' ';
    for temp:=1 to length(s) do FOutput:=FOutput+IntToHex(ord(s[temp]),2)+' ';
  end;
  SetLength(s,Length(s)-1);
{$IFNDEF NODEBUG}
f.Free;
{$ENDIF}
end;

function TCommSM.Obmen(var s: string):integer;
var s1:string;
begin
  cs.Enter;
  s1:=s;
  s:='';
  Result:=-1;
  FOutput:='';
  FInput:='';

  // выход, если не весы и команда не запрос типа устройства
  if (not isCorrectDevice) and (ord(s1[3])<>$fc) then begin
    Result:=-18;
    s1:='';
  end
  else begin
    AddCRC(s1);
    Result:=ObmenCOM(s1);
  end;
  s:=s1;
  cs.Leave;
end;

function TCommSM.OpenCom: integer;
begin
  CloseCom;
  FCOM.ComNumber:=FComNumber;
  FCOM.BaudRate:=FBaudRate;
  FCOM.TimeOut:=FTimeout;
  Result:=FCOM.OpenCom;
end;

procedure TCommSM.Set_BaudRate(const Value: Cardinal);
begin
  FBaudRate := Value;
end;

procedure TCommSM.Set_ComNumber(const Value: Cardinal);
begin
  FComNumber := Value;
end;

procedure TCommSM.Set_TimeOut(const Value: Cardinal);
begin
  FTimeout := Value;
end;

constructor TCommSM.Create;
begin
  FCOM:=TCommExchange.Create;
  cs:=TCriticalSection.Create;
end;

destructor TCommSM.Destroy;
begin
  cs.Free;
  FCOM.Free;
  inherited;
end;

procedure TCommSM.Set_CorrectDevice(const Value: boolean);
begin
  isCorrectDevice:=Value;
end;

end.
