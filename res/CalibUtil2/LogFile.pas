unit LogFile;

interface

uses
  
  Types, Classes, SysUtils, SyncObjs,
  
  QtUtils, DebugUtils;

type
  { TLogFile }

  TLogFile = class
  private
    FHandle: Integer;
    FFileName: string;
    FEnabled: Boolean;
    FLock: TCriticalSection;

    procedure Lock;
    procedure Unlock;
    procedure OpenFile;
    procedure CloseFile;
    function GetOpened: Boolean;
    function GetDefEnabled: Boolean;
    function GetDefFileName: string;
    procedure Write(const Data: string);
    procedure SetEnabled(Value: Boolean);
    procedure AddLine(const Data: string);
    procedure SetFileName(const Value: string);

    property Opened: Boolean read GetOpened;
  public
    constructor Create;
    destructor Destroy; override;

    class function GetTimeStamp: string;
    class function GetLineHeader: string;

    procedure Info(const Data: string);
    procedure Warn(const Data: string);
    procedure Error(const Data: string);
    procedure Debug(const Data: string);
    procedure Trace(const Data: string);

    property DefEnabled: Boolean read GetDefEnabled;
    property DefFileName: string read GetDefFileName;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property FileName: string read FFileName write SetFileName;
  end;


function GlobalLogger: TLogFile;

implementation

const
  StrLen        = 20; 
  S_SEPARATOR   = '------------------------------------------------------------';

  TagInfo         = '[ INFO] ';
  TagTrace        = '[TRACE] ';
  TagDebug        = '[DEBUG] ';
  TagError        = '[ERROR] ';
  TagWarn         = '[ WARN] ';

var
  FLogFile: TLogFile;

function GlobalLogger: TLogFile;
begin
  if FLogFile = nil then
    FLogFile := TLogFile.Create;
  Result := FLogFile;
end;

procedure FreeLogFile;
begin
  FLogFile.Free;
  FLogFile := nil;
end;

const
  INVALID_HANDLE_VALUE = -1;

{ TLogFile }

constructor TLogFile.Create;
begin
  inherited Create;
  FLock := TCriticalSection.Create;
  FHandle := INVALID_HANDLE_VALUE;
end;

destructor TLogFile.Destroy;
begin
  CloseFile;
  FLock.Free;
  inherited Destroy;
end;

function TLogFile.GetDefEnabled: Boolean;
begin
  Result := True;
end;

function TLogFile.GetDefFileName: string;
begin
  Result := ChangeFileExt(GetModuleFileName, '.log');
end;

class function TLogFile.GetTimeStamp: string;
var
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Time, Hour, Min, Sec, MSec);
  Result := Format('%.2d.%.2d.%.4d %.2d:%.2d:%.2d.%.3d',[
    Day, Month, Year, Hour, Min, Sec, MSec]);
end;

procedure TLogFile.Lock;
begin
  FLock.Enter;
end;

procedure TLogFile.Unlock;
begin
  FLock.Leave;
end;

procedure TLogFile.OpenFile;
begin
  Lock;
  try
    if not Opened then
    begin
      if FileExists(FileName) then
        FHandle := FileOpen(FileName, fmOpenWrite + fmShareDenyWrite)
      else
        FHandle := FileCreate(FileName);

      if Opened then
        FileSeek(FHandle, 0, 2); 
    end;
  finally
    Unlock;
  end;
end;

procedure TLogFile.CloseFile;
begin
  Lock;
  try
    if Opened then
      FileClose(FHandle);
    FHandle := INVALID_HANDLE_VALUE;
  finally
    Unlock;
  end;
end;

function TLogFile.GetOpened: Boolean;
begin
  Result := FHandle <> INVALID_HANDLE_VALUE;
end;

procedure TLogFile.SetEnabled(Value: Boolean);
begin
  if Value <> Enabled then
  begin
    FEnabled := Value;
    CloseFile;
  end;
end;

procedure TLogFile.SetFileName(const Value: string);
begin
  if Value <> FileName then
  begin
    CloseFile;
    FFileName := Value;
  end;
end;

procedure TLogFile.Write(const Data: string);
var
  S: string;
begin
  Lock;
  try
    if not Enabled then Exit;
    S := Data;
    OpenFile;
    if Opened then
    begin
      FileWrite(FHandle, S[1], Length(S));
    end;
  finally
    Unlock;
  end;
end;

class function TLogFile.GetLineHeader: string;
begin
  Result := Format('[%s] [%.8d] ', [GetTimeStamp, GetCurrentThreadID]);
end;

procedure TLogFile.AddLine(const Data: string);
begin
  Write(GetLineHeader + Data + #13#10);
end;

procedure TLogFile.Trace(const Data: string);
begin
  AddLine(TagTrace + Data);
end;

procedure TLogFile.Warn(const Data: string);
begin
  AddLine(TagWarn + Data);
end;

procedure TLogFile.Info(const Data: string);
begin
  AddLine(TagInfo + Data);
end;

procedure TLogFile.Error(const Data: string);
begin
  AddLine(TagError + Data);
end;

procedure TLogFile.Debug(const Data: string);
begin
  AddLine(TagDebug + Data);
end;

initialization

finalization
  FreeLogFile;

end.
