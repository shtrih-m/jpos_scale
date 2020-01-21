unit MyCOM;

interface

Uses Windows, SysUtils, SyncObjs, Classes, Registry,
  Dialogs, USBDetect;

const
  BaudRates:array[0..6] of integer=(CBR_2400,CBR_4800,CBR_9600,
                              CBR_19200,CBR_38400,CBR_57600,
                              CBR_115200);
Type
  TCommExchange = class
  private
    FComPortHandle: Cardinal;
    cn: Cardinal; //новые
    bd: Cardinal; //новые
    tm: Cardinal; //новые
    FComNumber: Cardinal; //текущие
    FBaudrate: Cardinal;  //текущие
    FTimeOut: Cardinal;   //текущие
    hEvent: Cardinal;
    cs: TCriticalSection;
    FLogOn: Boolean;
    LogFileStream:TFileStream;
    FInput: string;
    FOutput: string;
    FError: Integer;
    FAnswerCommand: Byte;
    FConnected: Boolean;
    FUSBDetect: TComponentUSB;
    procedure Set_ComNumber(AComNumber:Cardinal);
    procedure Set_BaudRate(ABaudRate:Cardinal);
    procedure Set_TimeOut(ATimeOut:Cardinal);
    procedure WriteLog(s: string);
    procedure USBRemove(Sender: TObject);
  public
    constructor Create;
    destructor Destroy;override;
    function InCom(var s: string; num: byte;total:Integer): boolean;
    function OutCom(s: string): boolean;
    function OpenCom: integer;
    function CloseCom: integer;
  published
    property ComNumber: Cardinal read FComNumber write Set_ComNumber default 1;
    property BaudRate: Cardinal read FBaudRate write Set_BaudRate default 1;
    property TimeOut: Cardinal read FTimeout write Set_TimeOut default 100;
    property LogOn:Boolean read FLogOn write FLogOn default FALSE;
    property Input: string read FInput;
    property Output: string read FOutput;
    property Error: Integer read FError default 0;
    property AnswerCommand: Byte read FAnswerCommand;
    property Connected: Boolean read FConnected;
  end;

implementation

{ TComm }

function TCommExchange.CloseCom: integer;
begin
  if hEvent<>0 then begin
    CloseHandle(hEvent);
    hEvent:=0;
  end;
  if FComPortHandle<>INVALID_HANDLE_VALUE then begin
    CloseHandle(FComPortHandle);
    FComPortHandle:=INVALID_HANDLE_VALUE;
    FUSBDetect.USBUnregister;
  end;
  Result:=0;
  FConnected:=FALSE;
  if FLogOn then
     if LogFileStream<>nil Then WriteLog('  Закрываем Сом-порт'#13#10);
  if FLogOn then
    if LogFileStream<>nil Then Begin
      LogFileStream.Free;
      LogFileStream:=nil;
    end;
end;

constructor TCommExchange.Create;
Var Reg: TRegistry;
begin
  cs:=TCriticalSection.Create;

  Reg:=TRegistry.Create;
  if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Param',false) then
    try
      FLogOn:=Reg.ReadBool('LogOn');
    except
      on Exception do begin
        FLogOn:=FALSE;
      end;
    end;
  Reg.Free;
  FUSBDetect := TComponentUSB.Create(nil);
  FUSBDetect.OnUSBRemove := USBRemove;
end;

destructor TCommExchange.Destroy;
begin
  CloseCom;
  FUSBDetect.Free;
  Inherited;
end;

function TCommExchange.InCom(var s: string; num: byte;total:Integer): boolean;
var  read:Cardinal;
     LastError,ResC:Cardinal;
     Res:LongBool;
     buf:array[0..255] of char;
     i:integer;
     lp:TOverLapped;
     sLog:string;
     tm:TCommTimeouts;
begin
  if FComPortHandle<>INVALID_HANDLE_VALUE then begin
   GetCommTimeouts(FComPortHandle,tm);
   tm.ReadTotalTimeoutConstant:=Total;
   SetCommTimeouts(FComPortHandle,tm);
   FillChar(Buf, SizeOf(Buf), 0);
   lp.Offset:=0;
   lp.OffsetHigh:=0;
   lp.hEvent:=hEvent;
   if not ReadFile(FComPortHandle,buf,num,read,@lp) then begin
     LastError:=GetLastError;
     case LastError of
      ERROR_IO_PENDING: begin
        if FLogOn then WriteLog('  Вызов GetOverlappedResult...');
        Res:=GetOverlappedResult(FComPortHandle,lp,read,TRUE);
        if FLogOn then WriteLog('  завершен'+#13#10);
        if not Res then begin
          ResC:=GetLastError;
          if FLogOn then WriteLog('  Результат: '+SysErrorMessage(ResC)+#13#10);
          result:=False;
          exit;
        end;
      end;
      else begin
        Result:=false;
        if FLogOn then
          WriteLog('  Ошибка приема: '+SysErrorMessage(lastError)+#13#10);
        exit;
      end;
     end;
   end;
   if read<>num then begin
     if FLogOn then WriteLog('  Таймаут'#13#10);
     OpenCom;
     Result:=False;
   end
   else begin
     if FLogOn then begin
       sLog:='  Приняли ';
       for i:=0 to read-1 do sLog:=sLog+IntToHex(ord(buf[i]),2)+' ';
       sLog:=sLog+#13#10;
       WriteLog(sLog);
     end;
     s:='';
     for i:=0 to read-1 do s:=s+buf[i];
     result:=true;
   end;
  end
  else begin
    if FLogOn then WriteLog('  Сом не открыт'#13#10);
    Result:=false;
  end;
end;

function TCommExchange.OpenCom: integer;
var comName:string;
    dcb:TDCB;
    ct:_COMMTIMEOUTS;
    lastError:Cardinal;
begin
  CloseCom;
  if Flogon then begin
    try
      LogFileStream:=TFileStream.Create('DrvSM.log',fmOpenReadWrite);
    except
      on EFOpenError do begin
        LogFileStream:=TFileStream.Create('DrvSM.log',fmCreate);
      end;
    end;
    LogFileStream.Seek(0, soFromEnd);
  end;
  FComNumber:=cn;
  FBaudrate:=bd;
  FTimeout:=tm;
  hEvent:=CreateEvent(nil,False,False,'CommRoutineComplete');
  if FLogOn and (hEvent=0) then begin
    WriteLog('  Неизвестная ошибка при создании Event:'#13#10);
    WriteLog('  '+SysErrorMessage(GetlastError)+#13#10);
  end;
  SysUtils.FmtStr( comName, '\\.\COM%-d',[cn]);
  FComPortHandle := CreateFile(
            pchar(comName),
            GENERIC_READ or GENERIC_WRITE,
            0, { Not shared }
            nil, { No security attributes }
            OPEN_EXISTING,
            FILE_FLAG_OVERLAPPED,
            0 { No template }
          ) ;
  if FComPortHandle<>INVALID_HANDLE_VALUE then begin
    GetCommState(FComPortHandle,dcb);
    dcb.BaudRate:=BaudRates[bd];
    dcb.Flags:=1;
    dcb.Parity:=NOPARITY;
    dcb.StopBits:=ONESTOPBIT;
    dcb.ByteSize:=8;
    SetCommState(FComPortHandle, dcb);
    SetupComm(FComPortHandle, 1024, 1024);
    GetCommTimeOuts(FComPortHandle,ct);
    ct.ReadIntervalTimeout:=tm;
    ct.ReadTotalTimeoutMultiplier:=tm;
    ct.ReadTotalTimeoutConstant:=100;
    ct.WriteTotalTimeoutMultiplier:=tm;
    ct.WriteTotalTimeoutConstant:=100;
    SetCommTimeOuts(FComPortHandle,ct);
    Result:=0;
    FConnected:=TRUE;
    FUSBDetect.USBRegister(FComPortHandle);
    if FLogOn then
      WriteLog('  Открыт Com'+IntToStr(cn)+' на скорости '+IntToStr(bd)+#13#10);
  end
  else begin
    lastError:=GetLastError;
    case LastError of
      ERROR_FILE_NOT_FOUND: begin
        Result:=-3;
        if FLogOn then
          WriteLog('  Com'+IntToStr(cn)+'открыт другим приложением'#13#10);
      end;
      ERROR_ACCESS_DENIED: begin
        Result:=-2;
        if FLogOn then
          WriteLog('  Com'+IntToStr(cn)+' отсутствует в системе'#13#10);
      end;
      else begin
        Result:=-1;
        if FLogOn then begin
          WriteLog('  Неизвестная ошибка при открытии порта:'#13#10);
          WriteLog(SysErrorMessage(lastError)+#13#10);
        end;
      end;
    end;
  end;
end;

function TCommExchange.OutCom(s: string): boolean;
var written,lenCom,CommError:Cardinal;
    j:integer;
    sLog:string;
    lp:TOverLapped;
    LastError,ResC:Cardinal;
    res:LongBool;
    cs:TComStat;
    read,Num:Cardinal;
    buf:array[0..255] of char;
begin
  if FComPortHandle<>INVALID_HANDLE_VALUE then begin
    PurgeComm(FComPortHandle,PURGE_TXCLEAR or PURGE_RXCLEAR or PURGE_TXABORT or	PURGE_RXABORT);
    ClearCommError(FComPortHandle,CommError,@cs);
    if cs.cbInQue>0 then begin
      lp.Offset:=0;
      lp.OffsetHigh:=0;
      lp.hEvent:=hEvent;
      num:=cs.cbInQue;
      if not ReadFile(FComPortHandle,buf,num,read,@lp) then begin
        LastError:=GetLastError;
        if FLogOn then WriteLog('  В коме что-то оставалось');
        case LastError of
          ERROR_IO_PENDING: begin
            if FLogOn then WriteLog('  Вызов GetOverlappedResult...');
            Res:=GetOverlappedResult(FComPortHandle,lp,written,TRUE);
            if FLogOn then WriteLog('  завершен'+#13#10);
            if not Res then begin
              ResC:=GetLastError;
              if FLogOn then WriteLog('  Результат:'+SysErrorMessage(ResC)+#13#10);
              result:=False;
              exit;
            end;
          end;
          else begin
            if FLogOn then
              WriteLog('  Ошибка чтения:'+SysErrorMessage(lastError)+#13#10);
          end;
        end;
      end;
    end;
    lenCom:=length(s);
    written:=0;
    if FLogOn then begin
      sLog:='  Передаем ';
      for j:=1 to length(s) do sLog:=sLog+IntToHex(ord(s[j]),2)+' ';
      sLog:=sLog+#13#10;
      WriteLog(sLog);
    end;
    if LenCom>256 then begin
      result:=false;
      exit;
    end;
    lp.hEvent:=hEvent;
    lp.Offset:=0;
    lp.OffsetHigh:=0;
    if FLogOn then
      WriteLog('  Вызов WriteFile...');
    if not WriteFile(FComPortHandle,PChar(s)^,lenCom,
      written,@lp) then begin
      LastError:=GetLastError;
      if FLogOn then begin
        WriteLog('  завершен'#13#10);
        WriteLog('  Результат:'+SysErrorMessage(lastError)+#13#10);
      end;
      case LastError of
        ERROR_IO_PENDING: begin
          if FLogOn then WriteLog('  Вызов WaitForSingleObject...');
          ResC:=WaitForSingleObject(hevent,200+100*length(s));
          if ResC<>WAIT_FAILED then begin
            case ResC of
              WAIT_ABANDONED: begin
                if FLogOn then begin
                  WriteLog('  провален'+#13#10);
                  WriteLog('  Результат: WAIT_ABANDONED'+#13#10);
                end;
                OpenCom;
                if FLogOn then WriteLog('  отменили'+#13#10);
                Result:=False;
                exit;
              end;
              WAIT_OBJECT_0: begin
                if FLogOn then WriteLog('  завершен'+#13#10);
              end;
              WAIT_TIMEOUT: begin
                if FLogOn then begin
                  WriteLog('  провален'+#13#10);
                  WriteLog('  Результат: WAIT_TIMEOUT'+#13#10);
                end;
                OpenCom;
                if FLogOn then WriteLog('  отменили'+#13#10);
                Result:=False;
                exit;
              end;
              else begin
                if FLogOn then begin
                  WriteLog('  провален'+#13#10);
                  WriteLog('  Результат: UNKNOWN'+#13#10);
                end;
                OpenCom;
                if FLogOn then WriteLog('  отменили'+#13#10);
                Result:=False;
                exit;
              end;
            end;
          end
          else begin
            if FLogOn then begin
              WriteLog('  провален'+#13#10);
              WriteLog('  Результат:'+SysErrorMessage(GetlastError)+#13#10);
            end;
            OpenCom;
            if FLogOn then WriteLog('  отменили'+#13#10);
            Result:=False;
            exit;
          end;
        end;
        else begin
          Result:=false;
          exit;
        end;
      end;
    end;
    Result:=true;
  end
  else begin
    Result:=false;
    if FLogOn then
      WriteLog('  Сом не открыт'#13#10);
  end;
end;

procedure TCommExchange.Set_BaudRate(ABaudRate: Cardinal);
begin
  bd:=ABaudRate;
end;

procedure TCommExchange.Set_ComNumber(AComNumber: Cardinal);
begin
  cn:=AComNumber;
end;

procedure TCommExchange.Set_TimeOut(ATimeOut: Cardinal);
begin
  tm:=ATimeOut;
end;

procedure TCommExchange.WriteLog(s: string);
begin
  LogFileStream.Write(s[1],length(s));
end;

procedure TCommExchange.USBRemove(Sender: TObject);
begin
  CloseCom;
end;

end.



