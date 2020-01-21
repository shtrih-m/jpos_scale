unit fmuMain;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin,
  // This
  Scale;

type
  TfmMain = class(TForm)
    gbSerialParams: TGroupBox;
    lblBaudRate: TLabel;
    lblSerialPort: TLabel;
    lblTimeout: TLabel;
    cbBaudRate: TComboBox;
    cbSerialPort: TComboBox;
    seTimeout: TSpinEdit;
    btnEnableDevice: TButton;
    btnClose: TButton;
    btnDisableDevice: TButton;
    edtStatus: TEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnEnableDeviceClick(Sender: TObject);
    procedure btnDisableDeviceClick(Sender: TObject);
  private
    FScale: TScale;
    property Scale: TScale read FScale;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

{ TfmMain }

constructor TfmMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScale := TScale.Create;
end;

destructor TfmMain.Destroy;
begin
  FScale.Free;
  inherited Destroy;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  cbSerialPort.ItemIndex := 0;
  cbBaudRate.ItemIndex := 2;
end;

procedure TfmMain.btnEnableDeviceClick(Sender: TObject);
var
  Params: TSerialParams;
begin
  Params.PortNumber := cbSerialPort.ItemIndex + 1;
  Params.BaudRate := StrToInt(cbBaudRate.Text);
  Params.Timeout := seTimeout.Value;
  Scale.Enable(Params);
  edtStatus.Text := Scale.Status;
end;

procedure TfmMain.btnDisableDeviceClick(Sender: TObject);
begin
  Scale.Disable;
  edtStatus.Text := Scale.Status;
end;

end.
