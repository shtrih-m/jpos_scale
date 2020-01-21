unit fmuPage1;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls,
  // This
  Pages;

type
  TfmPage1 = class(TPage)
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Change(Sender: TObject);
  end;

implementation

{$R *.xfm}

uses
  fmuConnect;

procedure TfmPage1.Button1Click(Sender: TObject);
begin
  ShowConnectDlg(Handle, Driver);
  ComboBox1.ItemIndex := Driver.ComNumber-1;
  ComboBox2.ItemIndex := Driver.BaudRate;
  Edit1.Text := IntToStr(Driver.Password);
end;

procedure TfmPage1.ComboBox1Change(Sender: TObject);
begin
  Driver.ComNumber:=ComboBox1.ItemIndex+1;
end;

procedure TfmPage1.ComboBox2Change(Sender: TObject);
begin
  Driver.BaudRate:=ComboBox2.ItemIndex;
end;

procedure TfmPage1.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=Driver.ComNumber-1;
  ComboBox2.ItemIndex:=Driver.BaudRate;
  Edit1.Text:=IntToStr(Driver.Password);
end;

procedure TfmPage1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0','1','2','3','4','5','6','7','8','9',#8]) then
    Key:=#0;
end;

procedure TfmPage1.Edit1Change(Sender: TObject);
begin
  Driver.Password:=StrToIntDef(Edit1.Text,Driver.Password);
  Edit1.Text:=IntToStr(Driver.Password);
end;

end.
