unit GradEnterForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TfrmGradEnter = class(TForm)
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
  frmGradEnter: TfrmGradEnter;

function ShowGradEnterForm: TModalResult;

implementation

function ShowGradEnterForm: TModalResult;
begin
  Result := frmGradEnter.ShowModal;
end;

{$R *.DFM}

procedure TfrmGradEnter.Button1Click(Sender: TObject);
begin
  if Edit1.Text='316071' then ModalResult:=mrOk;
end;

procedure TfrmGradEnter.FormShow(Sender: TObject);
begin
  Edit1.Text := '';
end;

end.
