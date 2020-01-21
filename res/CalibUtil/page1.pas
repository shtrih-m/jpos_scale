unit page1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  pages;

type
  TfrmPage1 = class(TPage)
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

{$R *.DFM}

procedure TfrmPage1.Button1Click(Sender: TObject);
begin
  Driver.ShowProperties;
  ComboBox1.ItemIndex:=Driver.ComNumber-1;
  ComboBox2.ItemIndex:=Driver.BaudRate;
  Edit1.Text:=IntToStr(Driver.Password);
end;

procedure TfrmPage1.ComboBox1Change(Sender: TObject);
begin
  Driver.ComNumber:=ComboBox1.ItemIndex+1;
end;

procedure TfrmPage1.ComboBox2Change(Sender: TObject);
begin
  Driver.BaudRate:=ComboBox2.ItemIndex;
end;

procedure TfrmPage1.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=Driver.ComNumber-1;
  ComboBox2.ItemIndex:=Driver.BaudRate;
  Edit1.Text:=IntToStr(Driver.Password);
end;

procedure TfrmPage1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0','1','2','3','4','5','6','7','8','9',#8]) then
    Key:=#0;
end;

procedure TfrmPage1.Edit1Change(Sender: TObject);
begin
  Driver.Password:=StrToIntDef(Edit1.Text,Driver.Password);
  Edit1.Text:=IntToStr(Driver.Password);
end;

end.
