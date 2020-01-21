unit fmuSearch;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls,
  QForms, QStdCtrls, QComCtrls, QExtCtrls, QDialogs,
  // This
  FindDevice, ScaleIntf;

type
  { TIPRange }

  TIPRange = packed record
    First: Integer;
    Last: Integer;
    Port: Word;
    group: string;
  end;

  { TfmSearch }
  
  TfmSearch = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Animate1: TAnimate;
    Button3: TButton;
    Panel1: TPanel;
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    ListView1: TListView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Driver: DrvSM;
    fd: TFindDevice;
    baudrate:integer;
    comnumber:integer;
    timeout:integer;
    procedure threadTerminate(Sender: TObject);
  public
    NameGroup:string;
    StartIP:string;
    EndIP:string;
    UDPPort:integer;
  end;

procedure ShowFindDlg(ADriver: DrvSM);

implementation

{$R *.xfm}

procedure ShowFindDlg(ADriver: DrvSM);
var
  fm: TfmSearch;
begin
  fm := TfmSearch.Create(nil);
  try
    fm.Driver := ADriver;
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

{ TfmSearch }

procedure TfmSearch.Button1Click(Sender: TObject);
begin
  if fd<>nil then begin
    fd.Terminate;
    fd.WaitFor;
    fd.Free;
    fd:=nil;
  end;
end;

procedure TfmSearch.Button2Click(Sender: TObject);
begin
  Screen.Cursor:=crAppStart;
  ListView1.Items.Clear;
  fd:=TFindDevice.Create(true);
  fd.FreeOnTerminate:=false;
  fd.lw:=ListView1;
  fd.FLP:=Driver;
  fd.OnTerminate:=threadTerminate;
  Button2.Enabled:=false;
  Button1.Enabled:=true;
  Button3.Enabled:=false;
  with Animate1 do begin
    Play(StartFrame,StopFrame,0);
    Visible:=true;
  end;
  fd.Resume;
end;

procedure TfmSearch.Button3Click(Sender: TObject);
begin
  if fd<>nil then begin
    fd.Terminate;
    fd.WaitFor;
    fd.Free;
    fd:=nil;
  end;
  Close;
end;

procedure TfmSearch.ThreadTerminate(Sender: TObject);
begin
  Button1.Enabled:=false;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
  Animate1.Stop;
  Animate1.Visible:=false;
  Screen.Cursor:=crDefault;
end;

procedure TfmSearch.FormShow(Sender: TObject);
begin
  comnumber:=Driver.ComNumber;
  baudrate:=Driver.BaudRate;
  timeout:=Driver.Timeout;
  Button2.Enabled:=true;
  Button1.Enabled:=false;
  Button3.Enabled:=true;
  // application position
  if (Screen.Width=2048) and (Screen.Height=768) then begin
    Left:=(1024 - Width) div 2;
    Top:=(768 - Height) div 2;
  end
  else begin
    Left:=(Screen.Width - Width) div 2;
    Top:=(Screen.Height - Height) div 2;
  end;
end;

procedure TfmSearch.ListView1DblClick(Sender: TObject);
var b:integer;
begin
  if ListView1.Selected<>nil then begin
    try
      timeout:=50;
      ComNumber:=StrToInt(copy(ListView1.Selected.Caption,5,255));
      b:=StrToInt(ListView1.Selected.SubItems.Strings[0]);
      case b of
        2400: BaudRate:=0;
        4800: BaudRate:=1;
        9600: BaudRate:=2;
        19200: BaudRate:=3;
        38400: BaudRate:=4;
        57600: BaudRate:=5;
        115200: BaudRate:=6;
        else  BaudRate:=2;
      end;
    except
      on EConvertError do begin
        ComNumber:=1;
        BaudRate:=2;
      end;
    end;
    if fd<>nil then begin
      fd.Terminate;
      fd.WaitFor;
      fd.Free;
      fd:=nil;
    end;
    Close;
  end;
end;

procedure TfmSearch.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Driver.ComNumber:=comnumber;
  Driver.BaudRate:=baudrate;
  Driver.Timeout:=timeout;
end;

end.
