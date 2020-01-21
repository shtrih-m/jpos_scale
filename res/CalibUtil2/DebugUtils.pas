unit DebugUtils;

interface

uses
  // VCL
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
  SysUtils, QtUtils;

procedure ODS(const S: string);

implementation

function GetTimeStamp: string;
var
  Year, Month, Day: Word;
  Hour, Min, Sec, MSec: Word;
begin
  DecodeDate(Date, Year, Month, Day);
  DecodeTime(Time, Hour, Min, Sec, MSec);
  Result := Format('[%.2d.%.2d.%.4d %.2d:%.2d:%.2d.%.3d] [%.8d] ',[
    Day, Month, Year, Hour, Min, Sec, MSec, GetCurrentThreadID]);
end;

procedure ODS(const S: string);
begin
{$IFDEF DEBUG}
{$IFDEF MSWINDOWS}
  OutputDebugString(PChar(GetTimeStamp + S));
{$ENDIF}
{$ENDIF}
end;

end.
