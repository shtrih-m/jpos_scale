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
    ListBox1.Items.Add(Format(_('Канал №%d'), [i+1]));

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
      Result := _('<нет>')
    else
      Result := _('<есть>');
  end;

var
  S: string;
begin
  Memo1.Clear;
  Driver.ChannelNumber := ListBox1.ItemIndex;
  if Driver.GetChannelParam <> 0 then
  begin
    Application.MessageBox(PWideChar(Driver.ResultCodeDescription),
      _('Ошибка'), [], smsCritical);
    Exit;
  end;

  Memo1.Lines.Add(Format(_('Характеристики весового канала: %d'), [ListBox1.ItemIndex+1]));
  case lo(Driver.ChannelFlags) and $3 of
    0: s := _('<тензоканал>');
    else s := _('<неизвестный>');
  end;
  Memo1.Lines.Add(Format(_('Тип канала         : %s'),[s]));
  Memo1.Lines.Add(Format(_('Выборка массы тары : %s'), [ChannelFlags($4)]));
  Memo1.Lines.Add(Format(_('Максимальный вес   : %8.3f кг'),[Driver.ChannelMaxWeight]));
  Memo1.Lines.Add(Format(_('Минимальный вес    : %8.3f кг'),[Driver.ChannelMinWeight]));
  Memo1.Lines.Add(Format(_('Максимальная тара  : %8.3f кг'), [Driver.ChannelMaxTare]));
  Memo1.Lines.Add(Format(_('Диапазон №%d        : %8.3f-%8.3f кг'),
    [1, 0.0, Driver.ChannelRange1]));
  if Driver.ChannelRange2 <> 0 then
    Memo1.Lines.Add(Format(_('Диапазон №%d        : %8.3f-%8.3f кг'),
    [2, Driver.ChannelRange1, Driver.ChannelRange2]));
  if Driver.ChannelRange3 <> 0 then
    Memo1.Lines.Add(Format(_('Диапазон №%d        : %8.3f-%8.3f кг'),
    [3, Driver.ChannelRange2, Driver.ChannelRange3]));

  Memo1.Lines.Add(Format(_('Дискретность на диапазоне №%d: %8.3f кг'),
    [1, Driver.ChannelDiscreteness1]));
  if Driver.ChannelDiscreteness2 <> 0 then
    Memo1.Lines.Add(Format(_('Дискретность на диапазоне №%d: %8.3f кг'),
    [2, Driver.ChannelDiscreteness2]));
  if Driver.ChannelDiscreteness3 <> 0 then
    Memo1.Lines.Add(Format(_('Дискретность на диапазоне №%d: %8.3f кг'),
    [3, Driver.ChannelDiscreteness3]));
  if Driver.ChannelDiscreteness4 <> 0 then
    Memo1.Lines.Add(Format(_('Дискретность на диапазоне №%d: %8.3f кг'),
    [4, Driver.ChannelDiscreteness4]));
  Memo1.Lines.Add(Format(_('Количество градуировочных точек: %d'),
    [Driver.ChannelPointsCount]));
end;

end.
