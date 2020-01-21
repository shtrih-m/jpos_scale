unit fmuPage2;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls,
  // This
  Pages, gnugettext;

type
  TfmPage2 = class(TPage)
    Label1: TLabel;
    Label5: TLabel;
    ListBox1: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
  end;

implementation

{$R *.xfm}

procedure TfmPage2.FormShow(Sender: TObject);
var i: integer;
begin
  Label3.Caption:=Driver.UDescription;
  ListBox1.Clear;
  for i := 0 to Driver.ChannelsCount-1 do
    ListBox1.Items.Add(Format(_('����� �%d'), [i+1]));

  if ListBox1.Items.Count > 0 then
    ListBox1.ItemIndex := 0;
  ListBox1Click(nil);
end;

procedure TfmPage2.ListBox1Click(Sender: TObject);

  function ChannelFlags(Bit: Byte): string;
  var
    T: Byte;
  begin
    T := Driver.ChannelFlags;
    if (T and bit) = 0 then
      Result := _('<���>')
    else
      Result := _('<����>');
  end;

var
  S: string;
begin
  Memo1.Clear;
  Driver.ChannelNumber := ListBox1.ItemIndex;
  if Driver.GetChannelParam <> 0 then
  begin
    Application.MessageBox(PWideChar(Driver.ResultCodeDescription),
      _('������'), [], smsCritical);
    Exit;
  end;

  Memo1.Lines.Add(Format(_('�������������� �������� ������: %d'), [ListBox1.ItemIndex+1]));
  case lo(Driver.ChannelFlags) and $3 of
    0: s := _('<����������>');
    else s := _('<�����������>');
  end;
  Memo1.Lines.Add(Format(_('��� ������         : %s'),[s]));
  Memo1.Lines.Add(Format(_('������� ����� ���� : %s'), [ChannelFlags($4)]));
  Memo1.Lines.Add(Format(_('������������ ���   : %8.3f ��'),[Driver.ChannelMaxWeight]));
  Memo1.Lines.Add(Format(_('����������� ���    : %8.3f ��'),[Driver.ChannelMinWeight]));
  Memo1.Lines.Add(Format(_('������������ ����  : %8.3f ��'), [Driver.ChannelMaxTare]));
  Memo1.Lines.Add(Format(_('�������� �%d        : %8.3f-%8.3f ��'),
    [1, 0.0, Driver.ChannelRange1]));
  if Driver.ChannelRange2 <> 0 then
    Memo1.Lines.Add(Format(_('�������� �%d        : %8.3f-%8.3f ��'),
    [2, Driver.ChannelRange1, Driver.ChannelRange2]));
  if Driver.ChannelRange3 <> 0 then
    Memo1.Lines.Add(Format(_('�������� �%d        : %8.3f-%8.3f ��'),
    [3, Driver.ChannelRange2, Driver.ChannelRange3]));

  Memo1.Lines.Add(Format(_('������������ �� ��������� �%d: %8.3f ��'),
    [1, Driver.ChannelDiscreteness1]));
  if Driver.ChannelDiscreteness2 <> 0 then
    Memo1.Lines.Add(Format(_('������������ �� ��������� �%d: %8.3f ��'),
    [2, Driver.ChannelDiscreteness2]));
  if Driver.ChannelDiscreteness3 <> 0 then
    Memo1.Lines.Add(Format(_('������������ �� ��������� �%d: %8.3f ��'),
    [3, Driver.ChannelDiscreteness3]));
  if Driver.ChannelDiscreteness4 <> 0 then
    Memo1.Lines.Add(Format(_('������������ �� ��������� �%d: %8.3f ��'),
    [4, Driver.ChannelDiscreteness4]));
  Memo1.Lines.Add(Format(_('���������� �������������� �����: %d'),
    [Driver.ChannelPointsCount]));
end;

end.
