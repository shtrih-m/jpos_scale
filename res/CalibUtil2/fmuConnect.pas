unit fmuConnect;

interface

uses
  // CLX
  SysUtils, Classes,
  Qt, QGraphics, QControls, QStdCtrls, QExtCtrls, QForms, QDialogs, QComCtrls,
  // This
  ScaleIntf, fmuMain, fmuSearch, fmuAbout;

type
  TfmConnect = class(TForm)
    btnSetBaudRate: TButton;
    btnConnect: TButton;
    btnFind: TButton;
    edtResult: TEdit;
    btnAbout: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    gsParams: TGroupBox;
    lblBaudRate: TLabel;
    lblComNumber: TLabel;
    lblTimeout: TLabel;
    cbBaudRate: TComboBox;
    cbComNumber: TComboBox;
    seTimeout: TSpinEdit;
    lblPassword: TLabel;
    edtPassword: TEdit;
    Bevel1: TBevel;
    lblResult: TLabel;
    procedure btnSetBaudRateClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure PropertyPageShow(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordExit(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure cbComNumberChange(Sender: TObject);
    procedure cbBaudRateChange(Sender: TObject);
    procedure seTimeoutChanged(Sender: TObject; NewValue: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    Driver: DrvSM;
    procedure Changed;
    procedure UpdatePage;
    procedure UpdateObject;
  end;

procedure ShowConnectDlg(AParentWnd: QWidgetH; ADriver: DrvSM);

implementation

{$R *.xfm}

procedure ShowConnectDlg(AParentWnd: QWidgetH; ADriver: DrvSM);
var
  fm: TfmConnect;
begin
  fm := TfmConnect.CreateParented(AParentWnd);
  try
    fm.Driver := ADriver;
    fm.UpdatePage;
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

{ TfmConnect }

procedure TfmConnect.UpdatePage;
begin
  cbComNumber.ItemIndex := Driver.ComNumber-1;
  cbBaudRate.ItemIndex := Driver.BaudRate;
  seTimeout.Value := Driver.Timeout;
  edtPassword.Text := IntToStr(Driver.Password);
end;

procedure TfmConnect.UpdateObject;
begin
  Driver.ComNumber := cbComNumber.ItemIndex + 1;
  Driver.Baudrate := cbBaudRate.ItemIndex;
  Driver.Timeout := seTimeOut.Value;
  Driver.Password := StrToInt(edtPassword.Text);
end;

procedure TfmConnect.btnSetBaudRateClick(Sender: TObject);
begin
  if not Driver.Connected then Driver.Connect;
  Driver.BaudRate := cbBaudrate.ItemIndex;
  Driver.Timeout := seTimeOut.Value;
  Driver.SetExchangeParam;
  edtResult.Text := IntToStr(Driver.ResultCode)+': '+ Driver.ResultCodeDescription;
end;

procedure TfmConnect.btnConnectClick(Sender: TObject);
begin
  edtResult.Clear;
  UpdateObject;
  Driver.Connect;
  if Driver.ResultCode = 0 then
  begin
    edtResult.Text := TrimRight(Driver.UDescription);
  end else
  begin
    edtResult.Text := Format('%d: %s', [Driver.ResultCode, Driver.ResultCodeDescription]);
  end;
end;

procedure TfmConnect.btnFindClick(Sender: TObject);
begin
  Driver.Disconnect;
  ShowFindDlg(Driver);
  cbComNumber.Text := Format('COM%d', [Driver.ComNumber]);
  cbBaudRate.ItemIndex := Driver.Baudrate;
end;

procedure TfmConnect.edtPasswordKeyPress(Sender: TObject; var Key: Char);
const
  IntSet:set of char=['0','1','2','3','4','5','6','7','8','9',#8];
begin
 if not (Key in IntSet) then Key:=#0;
end;


procedure TfmConnect.btnAboutClick(Sender: TObject);
begin
  ShowAboutDlg(Handle);
end;

procedure TfmConnect.PropertyPageShow(Sender: TObject);
begin
  UpdatePage;
end;

procedure TfmConnect.edtPasswordExit(Sender: TObject);
begin
  try
    Driver.Password:=StrToInt(edtPassword.Text);
  except
    on EConvertError do ;
  end;
end;

procedure TfmConnect.btnApplyClick(Sender: TObject);
begin
  UpdateObject;
  btnApply.Enabled := False;
end;

procedure TfmConnect.cbComNumberChange(Sender: TObject);
begin
  Changed;
end;

procedure TfmConnect.cbBaudRateChange(Sender: TObject);
begin
  Changed;
end;

procedure TfmConnect.seTimeoutChanged(Sender: TObject; NewValue: Integer);
begin
  Changed;
end;

procedure TfmConnect.Changed;
begin
  btnApply.Enabled := True;
end;

procedure TfmConnect.FormCreate(Sender: TObject);
var
  i:integer;
begin
  cbComNumber.Items.Clear;
  for i := 1 to 255 do
    cbComNumber.Items.Add(Format('COM%d',[i]));
end;

procedure TfmConnect.btnOKClick(Sender: TObject);
begin
  UpdateObject;
  ModalResult := mrOK;
end;

end.


















