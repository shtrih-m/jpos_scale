unit ScaleProtocol;

interface

uses
  // CLX
  SysUtils, Classes, SyncObjs, QtUtils,
  // This
  SerialPort, SerialPortX, StringUtils;

const
  STX = $02;
  STE = $03;
  ENQ = $05;
  ACK = $06;
  NAK = $15;
  BUSY= $0b;

  BaudRates: array [0..6] of Integer = (2400, 4800, 9600,
    19200, 38400, 57600, 115200);

  strBaudRates: array [0..6] of string = ('2400', '4800', '9600',
    '19200','38400','57600', '115200');

type
  { TDeviceType }

  TDeviceType = packed record
    UMajorType: Byte;
    UMinorType: Byte;
    UMajorProtocol: Byte;
    UMinorProtocol: Byte;
    UModel: Byte;
    UCodePage: Byte;
    UDescription: string;
  end;

  { TChannel }

  TChannel = packed record
    Flags: word;
    PointPosition: byte;
    Stepen: shortint;
    MaxWeight: word;
    MinWeight: word;
    MaxTare: word;
    Range1: word;
    Range2: word;
    Range3: word;
    Discreteness1: byte;
    Discreteness2: byte;
    Discreteness3: byte;
    Discreteness4: byte;
    PointsCount: byte;
    CalibrationsCount: byte;
  end;

  { TScaleProtocol }

  TScaleProtocol = class
  private
    FPort: ISerialPort;
    FLock: TCriticalSection;
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
    function Send(var Command: string; Timeout: Integer): Integer;
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

constructor TScaleProtocol.Create;
begin
  inherited Create;
  FPort := TSerialPortX.Create;
  FLock := TCriticalSection.Create;
end;

destructor TScaleProtocol.Destroy;
begin
  FLock.Free;
  FPort := nil;
  inherited Destroy;
end;

function TScaleProtocol.CloseCom: integer;
begin
  FPort.Close;
  Result := 0;
end;

function TScaleProtocol.ObmenCOM(var s: string):integer;
var
  C: Char;
  i, j: Integer;
  s1, s2: string;
  B: Boolean;
  Len, Crc, Temp: Byte;
  Time: Integer;
  Delay: Integer;
begin
  Len := 0;
  FInput := '';
  FOutput := '';
  for i:=1 to length(s) do FInput:=FInput+IntToHex(ord(s[i]),2)+' ';
//если работаем по RS232
  for i:=1 to 2 do begin
  if i>1 then Sleep(500);
    // посылаем ENQ
    FPort.Write(Chr(ENQ));
    // ждем ответ на ENQ
    s1 := FPort.Read(1);
    j:=ord(s1[1]);
    case j of
      NAK:
      begin
        FPort.Write(s);
        s1 := FPort.Read(1);
        if ord(s1[1])<>ACK then
        begin;
         Write('ответ не ACK'#13#10);
         continue;
        end;
      end;
    else
      continue;
    end;
  // прием ответа
  // прием STX
    delay:=1000;
    Time:=GetTickCount;
    Repeat
      b := FPort.ReadChar(C);
      if b then break;
    until (Integer(GetTickCount) > Time+delay);
    if not b then continue;

    if ord(C) <> STX then continue;
    // прием длины
    if not FPort.ReadCHar(C) then continue;
    len:=ord(C);
    // прием ответа
    temp:=len;
    S1 := FPort.Read(temp);
    // прием CRC
    if not FPort.ReadChar(C) then continue;
    // проверка на правильность CRC
    crc:=len;
    for j:=1 to len do crc:=crc xor ord(s1[j]);
    if crc=Ord(C) then
    begin
      FPort.Write(Chr(ACK));
    end
    else begin
      FPort.Write(Chr(NAK));
      continue;
    end;
    break;
  end;
  s:='';
  if (i<3) and (Length(s1)>=2) then Result:=ord(s1[2])
  else Result:=-1;

  s := Chr(len) + s1 + s2;
  FOutput := StrToHex(S);
end;

function TScaleProtocol.Send(var Command: string; Timeout: Integer):integer;
begin
  FLock.Enter;
  try
    FPort.CmdTimeout := Timeout;
    Result := ObmenCOM(Command);
  finally
    FLock.Leave;
  end;
end;

function TScaleProtocol.OpenCom: integer;
begin
  CloseCom;
  FPort.PortName := Format('\\.\COM%d', [FComNumber]);
  FPort.BaudRate := BaudRates[FBaudRate];
  FPort.TimeOut := FTimeout;
  FPort.Open;
  Result := 0;
end;

procedure TScaleProtocol.Set_BaudRate(const Value: Cardinal);
begin
  FBaudRate := Value;
end;

procedure TScaleProtocol.Set_ComNumber(const Value: Cardinal);
begin
  FComNumber := Value;
end;

procedure TScaleProtocol.Set_TimeOut(const Value: Cardinal);
begin
  FTimeout := Value;
end;

procedure TScaleProtocol.Set_CorrectDevice(const Value: boolean);
begin
  isCorrectDevice:=Value;
end;

end.
