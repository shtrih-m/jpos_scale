unit USBDetect;

// component to detect when usb devices are connected or disconnected
// using registerdevicenotification

interface

uses
  windows, messages, sysutils, classes, forms;

type

 { PDevBroadcastHdr = ^dev_broadcast_hdr;
  dev_broadcast_hdr = packed record
    dbch_size: dword;
    dbch_devicetype: dword;
    dbch_reserved: dword;
  end;}

  PDevBroadcastDeviceInterface = ^dev_broadcast_deviceinterface;
  DEV_BROADCAST_DEVICEINTERFACE = record
    dbcc_size: DWORD;
    dbcc_devicetype: DWORD;
    dbcc_reserved: DWORD;
    dbcc_classguid: TGUID;
    dbcc_name: array [0..0] of AnsiChar;
  end;

  PDevBroadcastHandle = ^TDevBroadcastHandle;
  DEV_BROADCAST_HANDLE = record
    dbch_size: DWORD;
    dbch_devicetype: DWORD;
    dbch_reserved: DWORD;
    dbch_handle: THandle;            { file handle used in call to RegisterDeviceNotification }
    dbch_hdevnotify: DWORD;          { HDEVNOTIFY returned from RegisterDeviceNotification }
    { The following 3 fields are only valid if wParam is DBT_CUSTOMEVENT. }
    dbch_eventguid: TGUID;
    dbch_nameoffset: DWORD;           { offset (bytes) of variable-length string buffer (-1 if none)}
    dbch_data: array [0..0] of Byte;  { variable-sized buffer, potentially containing binary and/or text data }
  end;
  TDevBroadcastHandle = DEV_BROADCAST_HANDLE;

const
  GUID_DEVINTERFACE_USB_DEVICE: TGuid = '{a5dcbf10-6530-11d2-901f-00c04fb951ed}';
  DBT_DEVTYP_OEM     = $00000000;  // oem-defined device type
  DBT_DEVTYP_DEVNODE = $00000001;  // devnode number
  DBT_DEVTYP_VOLUME  = $00000002;  // logical volume
  DBT_DEVTYP_PORT    = $00000003;  // serial, parallel
  DBT_DEVTYP_NET     = $00000004;  // network resource
  DBT_DEVTYP_DEVICEINTERFACE = $00000005; // device interface class
  DBT_DEVTYP_HANDLE  = $00000006;  // file system handle

  DBT_DEVICEARRIVAL           = $8000;  // system detected a new device
  DBT_DEVICEQUERYREMOVE       = $8001;  // wants to remove, may fail
  DBT_DEVICEQUERYREMOVEFAILED = $8002;  // removal aborted
  DBT_DEVICEREMOVEPENDING     = $8003;  // about to remove, still avail.
  DBT_DEVICEREMOVECOMPLETE    = $8004;  // device is gone
  DBT_DEVICETYPESPECIFIC      = $8005;  // type specific event

type

  TComponentUSB = class(TComponent)
  private
    FNotifyHandle: HDEVNOTIFY;
    FWindowHandle: HWND;
    FOnUSBArrival: TNotifyEvent;
    FOnUSBRemove: TNotifyEvent;
    procedure wndproc(var msg: tmessage);
  protected
    procedure WMDeviceChange(var msg: tmessage); dynamic;
  public
    function USBRegister(Handle: THandle): boolean;
    procedure USBUnregister;
    constructor Create(aowner: tcomponent); override;
    destructor Destroy; override;
  published
    property OnUSBArrival: TNotifyEvent read FOnUSBArrival write FOnUSBArrival;
    property OnUSBRemove: TNotifyEvent read FOnUSBRemove write FOnUSBRemove;
  end;

implementation

constructor TComponentUSB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWindowHandle := AllocateHWnd(wndproc);
  //UsbRegister;
end;

destructor TComponentusb.Destroy;
begin
  USBUnregister;
  DeallocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TComponentusb.wndproc(var msg: TMessage);
begin
  if (msg.msg = WM_DEVICECHANGE) then begin
    try
      WMDeviceChange(msg);
    except
      Application.HandleException(self);
    end;
  end
  else msg.Result := DefWindowProc(FWindowHandle, msg.Msg, msg.wparam, msg.lparam);
end;

procedure TComponentusb.WMDeviceChange(var msg: TMessage);
begin
  if (msg.wparam = DBT_DEVICEARRIVAL) or (msg.wparam = DBT_DEVICEREMOVECOMPLETE) then begin
    if (msg.wparam = DBT_DEVICEARRIVAL) and Assigned(FOnUSBArrival) then FOnUSBArrival(self)
    else if (msg.wparam = DBT_DEVICEREMOVECOMPLETE) and Assigned(FOnUSBRemove) then FOnUSBRemove(self)
  end
  else DefWindowProc(FWindowHandle, Msg.Msg, Msg.wParam, Msg.lParam);
end;

function TComponentUSB.USBRegister(Handle: THandle): boolean;
var dbh: DEV_BROADCAST_HANDLE;
begin
  Result := false;
  ZeroMemory(@dbh, sizeof(dbh));
  dbh.dbch_size := sizeof(dbh);
  dbh.dbch_devicetype := DBT_DEVTYP_HANDLE;
  dbh.dbch_handle := Handle;
  FNotifyHandle := RegisterDeviceNotification(FWindowHandle, @dbh, DEVICE_NOTIFY_WINDOW_HANDLE);
  if Assigned(FNotifyHandle) then Result := true;
end;

procedure TComponentUSB.USBUnregister;
begin
  if Assigned(FNotifyHandle) then UnregisterDeviceNotification(FNotifyHandle);
  FNotifyHandle := nil;
end;

end.


 