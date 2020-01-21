unit SerialPortX;

interface

uses
  // CLX
  Types, Classes, SysUtils,
  {$IFDEF MSWINDOWS}
  Windows, Registry,
  {$ENDIF}
  // This
  SerialPort, DriverError, Logger, gnugettext, synaser;

const
  INVALID_HANDLE_VALUE = DWORD(-1);
  ERROR_ACCESS_DENIED = 5;

type
  { TSerialPortX }

  TSerialPortX = class(TInterfacedObject, ISerialPort)
  private
    FTimeout: DWORD;
    FLogger: TLogger;
    FBaudRate: DWORD;
    FPortName: string;
    FCmdTimeout: DWORD;
    FPort: TBlockSerial;

    procedure SetSignals;
    procedure RaiseLastError;
    procedure LogError(const Text: string);
    procedure LogDebug(const Text: string);
  public
    constructor Create;
    destructor Destroy; override;

    procedure Open;
    procedure Close;
    procedure Purge;
    procedure Write(const Data: string);
    procedure SetCmdTimeout(Value: DWORD);
    procedure SetTimeout(const Value: DWORD);
    procedure SetBaudRate(const Value: DWORD);
    procedure SetPortName(const Value: string);

    function GetOpened: Boolean;
    function GetCmdTimeout: DWORD;
    function Read(Count: DWORD): string;
    function ReadChar(var C: Char): Boolean;
    function GetBaudRate: DWORD;
    function GetPortName: string;
    function GetTimeout: DWORD;

    class function GetSystemPortNames: string;
    class function GetSerialPortNames: string;
    class procedure GetSystemPorts(Ports: TStringList);
    class procedure GetDefaultPorts(Ports: TStrings; Count: Integer);

    property Logger: TLogger read FLogger;
    property Opened: Boolean read GetOpened;
    property CmdTimeout: DWORD read GetCmdTimeout;
    property Timeout: DWORD read GetTimeout write SetTimeout;
    property BaudRate: DWORD read GetBaudRate write SetBaudRate;
    property PortName: string read GetPortName write SetPortName;
  end;

implementation

{ TSerialPortX }

constructor TSerialPortX.Create;
begin
  inherited Create;
  FPort := TBlockSerial.Create;
  FPort.RaiseExcept := True;
  FLogger := TLogger.Create(ClassName);
end;

destructor TSerialPortX.Destroy;
begin
  Close;
  FPort.Free;
  FLogger.Free;
  inherited Destroy;
end;

procedure TSerialPortX.SetPortName(const Value: string);
begin
  if Value <> PortName then
  begin
    Close;
    FPortName := Value;
  end;
end;

procedure TSerialPortX.LogError(const Text: string);
begin
  //Logger.Error(Text);
end;

procedure TSerialPortX.LogDebug(const Text: string);
begin
  //Logger.Debug(Text);
end;

procedure TSerialPortX.RaiseLastError;
var
  LastError: DWORD;
begin
  LastError := GetLastError;
  LogError(Format('ERROR: 0x%.8x, %s', [LastError, SysErrorMessage(LastError)]));
  RaiseError(E_NOHARDWARE, _('No hardware'));
end;

function TSerialPortX.GetOpened: Boolean;
begin
  Result := FPort.Opened;
end;

procedure TSerialPortX.Open;
begin
  LogDebug('Open');

  if not Opened then
  begin
    FPort.Connect(PortName);
    FPort.Config(FBaudRate,8,'N',0,false,false);
    SetSignals;
  end;
end;

procedure TSerialPortX.SetSignals;
begin
  LogDebug('SetSignals');
  FPort.DTR := True;
  FPort.RTS := False;
end;

procedure TSerialPortX.Close;
begin
  LogDebug('Close');

  if Opened then
  begin
    FPort.CloseSocket;
  end;
end;

procedure TSerialPortX.Write(const Data: string);
var
  Count: DWORD;
begin
  LogDebug('Write');
  Count := Length(Data);
  if Count = 0 then Exit;
  FPort.SendString(Data);
end;

function TSerialPortX.ReadChar(var C: Char): Boolean;
var
  ReadCount: Integer;
begin
  LogDebug('ReadChar');

  ReadCount := FPort.RecvBufferEx(@C, 1, FCmdTimeout);
  if ReadCount = -1 then
    RaiseLastError;

  Result := ReadCount = 1;
end;

function TSerialPortX.Read(Count: DWORD): string;
var
  ReadCount: DWORD;
begin
  LogDebug('Read');

  Result := '';
  if Count = 0 then Exit;

  SetLength(Result, Count);
  ReadCount := FPort.RecvBufferEx(@Result[1], Count, FTimeout);
  if ReadCount <> Count then
    RaiseLastError;

  SetLength(Result, ReadCount);
end;

procedure TSerialPortX.Purge;
begin
  LogDebug('Purge');
  FPort.Purge;
end;

{$IFDEF MSWINDOWS}
class procedure TSerialPortX.GetDefaultPorts(Ports: TStrings; Count: Integer);
var
  i: Integer;
begin
  Ports.Clear;
  for i := 1 to Count do
    Ports.Add('COM'+ IntToStr(i));
end;
{$ELSE}
class procedure TSerialPortX.GetDefaultPorts(Ports: TStrings; Count: Integer);
var
  i: Integer;
begin
  Ports.Clear;
  for i := 0 to Count-1 do
    Ports.Add('/dev/ttyS'+ IntToStr(i));
end;
{$ENDIF}

class function TSerialPortX.GetSerialPortNames: string;
var
  Ports: TStringList;
begin
  Ports := TStringList.Create;
  try
    {$IFDEF WIN32}
    GetSystemPorts(Ports);
    {$ELSE}
    GetDefaultPorts(Ports, 8);
    {$ENDIF}
    Result := Ports.Text;
  finally
    Ports.Free;
  end;
end;


function CompareInt(Value1, Value2: Integer): Integer;
begin
  if Value1 > Value2 then Result := 1 else
  if Value1 < Value2 then Result := -1 else
  Result := 0;
end;

function IsCharDigit(C: Char): Boolean;
begin
  Result := C in ['0'..'9'];
end;

function GetPortPrefix(const PortName: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(PortName) do
  begin
    if IsCharDigit(PortName[i]) then Break;
    Result := Result + PortName[i];
  end;
end;

function GetPortNumber(const PortName: string): Integer;
var
  i: Integer;
  Code: Integer;
  PortNumber: string;
begin
  PortNumber := '';
  for i := 1 to Length(PortName) do
  begin
    if IsCharDigit(PortName[i]) then
    begin
      PortNumber := PortNumber + PortName[i];
    end else
    begin
      if PortNumber <> '' then Break;
    end;
  end;
  Val(PortNumber, Result, Code);
end;

function SortProc(List: TStringList; Index1, Index2: Integer): Integer;
var
  S1, S2: string;
  I1, I2: Integer;
begin
  S1 := GetPortPrefix(List[Index1]);
  S2 := GetPortPrefix(List[Index2]);
  Result := CompareText(S1, S2);
  if Result = 0 then
  begin
    I1 := GetPortNumber(List[Index1]);
    I2 := GetPortNumber(List[Index2]);
    Result := CompareInt(I1, I2);
  end;
end;

{$IFDEF MSWINDOWS}
class procedure TSerialPortX.GetSystemPorts(Ports: TStringList);
var
  i: Integer;
  Reg: TRegistry;
  PortName: string;
  Strings: TStringList;
begin
  Ports.Clear;
  Reg := TRegistry.Create;
  Strings := TStringList.Create;
  try
    Reg.Access := KEY_READ;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\HARDWARE\DEVICEMAP\SERIALCOMM', False) then
    begin
      Reg.GetValueNames(Strings);
      for i := 0 to Strings.Count-1 do
      begin
        PortName := Trim(Reg.ReadString(Strings[i]));
        if PortName <> '' then
          Ports.Add(PortName);
      end;
      Ports.CustomSort(SortProc);
    end;
  finally
    Reg.Free;
    Strings.Free;
  end;
end;
{$ELSE}
class procedure TSerialPortX.GetSystemPorts(Ports: TStringList);
begin

end;
{$ENDIF}

class function TSerialPortX.GetSystemPortNames: string;
var
  PortNames: TstringList;
begin
  PortNames := TStringList.Create;
  try
    GetSystemPorts(PortNames);
    Result := PortNames.Text;
  finally
    PortNames.Free;
  end;
end;


function TSerialPortX.GetCmdTimeout: DWORD;
begin
  Result := FCmdTimeout;
end;

function TSerialPortX.GetBaudRate: DWORD;
begin
  Result := FBaudRate;
end;

function TSerialPortX.GetPortName: string;
begin
  Result := FPortName;
end;

function TSerialPortX.GetTimeout: DWORD;
begin
  Result := FTimeout;
end;

procedure TSerialPortX.SetBaudRate(const Value: DWORD);
begin
  FBaudRate := Value;
end;

procedure TSerialPortX.SetTimeout(const Value: DWORD);
begin
  FTimeout := Value;
end;

procedure TSerialPortX.SetCmdTimeout(Value: DWORD);
begin
  FPort.DeadlockTimeout := Value;
  FCmdTimeout := Value;
end;

end.
