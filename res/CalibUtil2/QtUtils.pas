unit QtUtils;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows,
  {$ENDIF}
  Classes, SysUtils, Qt, QForms, QGraphics, SyncObjs,
  // This
  synautil;

type
  { TVersionInfo }

  TVersionInfo = record
    MajorVersion: WORD;
    MinorVersion: WORD;
    ProductRelease: WORD;
    ProductBuild: WORD;
  end;

const
  DefaultFontSize = 12;
  DefaultFontCharset = fcsKOI8R;
  DefaultFontName = 'cronyx-courier';

function GetTickCount: Integer;
function GetModuleFileName: string;
function GetModuleVersion: string;
function GetFileVersionInfoStr: string;
function GetModuleVersionShort: string;
function GetFileVersionInfo: TVersionInfo;
function IsDigit(Key: Char): Boolean;
function GetCurrentThreadID: Integer;
procedure Sleep(Timeout: Integer);
function SetToInteger(const SetValue; SizeOfSetType: Integer): Integer;
procedure IntegerToSet(const IntValue: Integer; SizeOfSetType: Integer; var SetValue);

procedure SetMemoFont(Font: TFont);

implementation

{$IFDEF MSWINDOWS}
function GetTickCount: Integer;
begin
  Result := Windows.GetTickCount;
end;
{$ELSE}
function GetTickCount: Integer;
begin
  Result := synautil.GetTick;
end;
{$ENDIF}

{$IFDEF MSWINDOWS}
function GetFileVersionInfo: TVersionInfo;
var
  hVerInfo: THandle;
  hGlobal: THandle;
  AddrRes: pointer;
  Buf: array[0..7]of byte;
begin
  Result.MajorVersion := 0;
  Result.MinorVersion := 0;
  Result.ProductRelease := 0;
  Result.ProductBuild := 0;

  hVerInfo:= FindResource(hInstance, '#1', RT_VERSION);
  if hVerInfo <> 0 then
  begin
    hGlobal := LoadResource(hInstance, hVerInfo);
    if hGlobal <> 0 then
    begin
      AddrRes:= LockResource(hGlobal);
      try
        CopyMemory(@Buf, Pointer(Integer(AddrRes)+48), 8);
        Result.MinorVersion := Buf[0] + Buf[1]*$100;
        Result.MajorVersion := Buf[2] + Buf[3]*$100;
        Result.ProductBuild := Buf[4] + Buf[5]*$100;
        Result.ProductRelease := Buf[6] + Buf[7]*$100;
      finally
        FreeResource(hGlobal);
      end;
    end;
  end;
end;
{$ELSE}
function GetFileVersionInfo: TVersionInfo;
begin
  Result.MajorVersion := 4;
  Result.MinorVersion := 9;
  Result.ProductRelease := 0;
  Result.ProductBuild := 211;
end;
{$ENDIF}

function GetFileVersionInfoStr: string;
var
  vi: TVersionInfo;
begin
  vi := GetFileVersionInfo;
  Result := Format('%d.%d.%d.%d', [vi.MajorVersion, vi.MinorVersion,
    vi.ProductRelease, vi.ProductBuild]);
end;

{$IFDEF MSWINDOWS}
function GetModuleFileName: string;
var
  Buffer: array[0..261] of Char;
begin
  SetString(Result, Buffer, Windows.GetModuleFileName(HInstance,
    Buffer, SizeOf(Buffer)));
end;
{$ELSE}
function GetModuleFileName: string;
begin
  Result := 'DrvFRTst.exe';
end;
{$ENDIF}

function GetModuleVersion: string;
begin
  Result := GetFileVersionInfoStr;
end;

function GetModuleVersionShort: string;
var
  vi: TVersionInfo;
begin
  vi := GetFileVersionInfo;
  Result := Format('%d.%d', [vi.MajorVersion, vi.MinorVersion]);
end;

function IsDigit(Key: Char): Boolean;
begin
  Result := Key in ['0'..'9', Chr(Key_Delete), Chr(Key_BackTab)];
end;

function GetCurrentThreadID: Integer;
begin
  {$IFDEF MSWINDOWS}
  Result := Windows.GetCurrentThreadID;
  {$ELSE}
  Result := 0; { !!! }
  {$ENDIF}
end;

procedure Sleep(Timeout: Integer);
var
  Event: TSimpleEvent;
begin
  Event := TSimpleEvent.Create;
  try
    Event.WaitFor(Timeout);
  finally
    Event.Free;
  end;
end;

function SetToInteger(const SetValue; SizeOfSetType: Integer): Integer;
begin
  case SizeOfSetType of
    1: Result := Byte(SetValue);
    2: Result := Word(SetValue);
    4: Result := Integer(SetValue);
  else
    raise Exception.Create('Invalid size of set');
  end;
end;

procedure IntegerToSet(const IntValue: Integer; SizeOfSetType: Integer; var SetValue);
begin
  case SizeOfSetType of
    1: Byte(SetValue) := IntValue;
    2: Word(SetValue) := IntValue;
    4: Integer(SetValue) := IntValue;
  else
    raise Exception.Create('Invalid size of set');
  end;
end;

function SelectScreenFontName(const FontName: string): string;
var
  i: Integer;
begin
  Result := FontName;
  for i := 0 to Screen.Fonts.Count-1 do
  begin
    if Pos(FontName, Screen.Fonts[i]) <> 0 then
    begin
      Result := Screen.Fonts[i];
      Break;
    end;
  end;
end;

procedure SetMemoFont(Font: TFont);
begin
  Font.Name := DefaultFontName;
  Font.Size := DefaultFontSize;
  Font.Charset := DefaultFontCharset
end;


end.
