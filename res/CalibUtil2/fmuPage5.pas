unit fmuPage5;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  // This
  Pages, gnugettext;

type
  TfmPage5 = class(TPage)
    Label1: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.xfm}

procedure TfmPage5.FormShow(Sender: TObject);
begin
  if Driver.FixedPointStatus=3 then
  begin
    Label1.Caption := _('  ����������� ������� ���������. ������� ���� � ���������.');
    Label6.Visible := False;
  end else
  begin
    Label1.Caption := _('  ����������� ��������� � �������. �������� ����� �� ��������.');
    Label6.Visible := True;
  end;
end;

procedure TfmPage5.FormCreate(Sender: TObject);
begin
  Label6.Caption := _('��������� ������� ������:'#13#10 +
    '1. ������������� ���� �� �������������� ����������.'#13#10 +
    '2. ���������� ���.');
end;

end.
