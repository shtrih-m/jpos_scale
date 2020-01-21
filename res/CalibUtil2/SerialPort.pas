unit SerialPort;

interface

uses
  // CLX
  Types, SysUtils;

type
  { ISerialPort }

  ISerialPort = interface
  ['{4BD6A5CB-6C38-49EA-AB48-C61D96171D74}']
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

    property Opened: Boolean read GetOpened;
    property Timeout: DWORD read GetTimeout write SetTimeout;
    property BaudRate: DWORD read GetBaudRate write SetBaudRate;
    property PortName: string read GetPortName write SetPortName;
    property CmdTimeout: DWORD read GetCmdTimeout write SetCmdTimeout;
  end;

implementation

end.
