unit fmuPassword;

interface

uses
  // CLX
  SysUtils, Classes,
  QGraphics, QControls, QForms, QDialogs, QStdCtrls;

type
  TfmPassword = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPassword: TfmPassword;

function ShowGradEnterForm: TModalResult;

implementation

function ShowGradEnterForm: TModalResult;
begin
  Result := fmPassword.ShowModal;
end;

{$R *.xfm}

procedure TfmPassword.Button1Click(Sender: TObject);
begin
  if Edit1.Text='316071' then ModalResult:=mrOk;
end;

procedure TfmPassword.FormShow(Sender: TObject);
begin
  Edit1.Text := '';
end;

end.
