unit MyUtils;

interface

uses Windows, dialogs, sysutils;

const IsWin95:boolean=true;

type
  _MIB_IPNETROW = Record
      dwIndex: DWORD; // adapter index
      dwPhysAddrLen: DWORD; // physical address length
      bPhysAddr: Array[1..6]of Byte; // physical address
      dwAddr: DWORD; // IP address
      dwType: DWORD; // ARP entry type
    End;
    PMIB_IPNETROW = ^MIB_IPNETROW;
    MIB_IPNETROW = _MIB_IPNETROW;
    _MIB_IPNETTABLE = Record
      dwNumEntries: DWORD; // number of entries in table
      table: Array[0..255] of MIB_IPNETROW; // array of ARP entries
    End;
    MIB_IPNETTABLE = _MIB_IPNETTABLE;

    TGetIpNetTable=Function(Var pIpNetTable: MIB_IPNETTABLE;
         Var pdwSize: ULONG;
         bOrder: BOOL): DWORD; stdcall;
    TDeleteIpNetEntry=Function(pArpEntry:PMIB_IPNETROW): DWORD; stdcall;

function DOSCode(s: string): string;
function WINCode(s: string): string;
function Win95: boolean;

Function GetIpNetTable_(Var pIpNetTable: MIB_IPNETTABLE;
         Var pdwSize: ULONG;
         bOrder: BOOL): DWORD; stdcall;
Function DeleteIpNetEntry_(pArpEntry:PMIB_IPNETROW): DWORD; stdcall;

implementation
{
Function GetIpNetTable_(Var pIpNetTable: MIB_IPNETTABLE;
         Var pdwSize: ULONG;
         bOrder: BOOL): DWORD; stdcall;
         external 'iphlpapi.dll';
Function DeleteIpNetEntry_(pArpEntry:PMIB_IPNETROW): DWORD; stdcall;
         external 'iphlpapi.dll';     }
Function GetIpNetTable_(Var pIpNetTable: MIB_IPNETTABLE;
         Var pdwSize: ULONG;
         bOrder: BOOL): DWORD;
var Handle:THandle;
  func:TGetIpNetTable;
  p:MIB_IPNETTABLE;
  u: ULONG;
  pu:PULONG;
begin
  Handle:=LoadLibrary('iphlpapi.dll');
  if Handle<>NULL then begin
    @func := GetProcAddress(Handle, 'GetIpNetTable');
    if @func<>nil then begin
      Result:=func(pIpNetTable,pdwSize,bOrder);
    end;
    FreeLibrary(Handle);
  end;
end;

Function DeleteIpNetEntry_(pArpEntry:PMIB_IPNETROW): DWORD; stdcall;
var Handle:THandle;
  func:TDeleteIpNetEntry;
begin
  Handle:=LoadLibrary('iphlpapi.dll');
  if Handle<>NULL then begin
   @func := GetProcAddress(Handle, 'DeleteIpNetEntry');
    if @func<>nil then begin
      Result:=func(pArpEntry);
    end;
    FreeLibrary(Handle);
  end;
end;

function Win95: boolean;
var VersionInfo:TOSVersionInfoA;
begin
  GetVersionExA(VersionInfo);
  Result:= ((VersionInfo.dwPlatformId=VER_PLATFORM_WIN32s) and
            (VersionInfo.dwMajorVersion=4) and
            (VersionInfo.dwMinorVersion=0));
end;

function DOSCode(s: string): string;
var i: longint;
    str: string;
begin
  str:=s;
  for i:=1 to Length(str) do begin
    case ord(str[i]) of
      0..127:   ;
      168:      str[i]:=chr(240);
      184:      str[i]:=chr(241);
      185:      str[i]:=chr(252);
      192..239: str[i]:=chr(ord(str[i])-64);
      240..255: str[i]:=chr(ord(str[i])-16);
      else str[i]:=' ';
    end;
  end;
  Result:=str;
end;

function WINCode(s: string): string;
var i: longint;
    str: string;
begin
  str:=s;
  for i:=1 to Length(str) do
    case ord(str[i]) of
      0..127:   ;
      240:      str[i]:=chr(168);
      241:      str[i]:=chr(184);
      252:      str[i]:=chr(185);
      128..175: str[i]:=chr(ord(str[i])+64);
      224..239: str[i]:=chr(ord(str[i])+16);
      else str[i]:=' ';
    end;
  Result:=str;
end;

end.
