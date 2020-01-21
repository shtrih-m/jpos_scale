unit fmuPage3;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls,
  // This
  Pages, gnugettext;

type
  TfmPage3 = class(TPage)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FPointNumber: integer;
  end;

implementation

{$R *.xfm}

procedure TfmPage3.FormShow(Sender: TObject);
begin
  if Driver.CalibrationWeight = 0 then
    FPointNumber := 0
  else
    Inc(FPointNumber);
  Label8.Caption := Format(_('  ������������ �������� ����� �%d (��� %8.3f ��).'),
    [FPointNumber + 1, Driver.CalibrationWeight]);
  Label2.Caption := Format(_('  �������� �� ��������� ��� %8.3f ��.'),
    [Driver.CalibrationWeight]);
  if Driver.CalibrationWeight = 0 then
    Label2.Caption := Label2.Caption + _(' ���������, ��� ��������� �����.');
end;

end.
