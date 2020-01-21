unit Page2;
                    
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  pages, cuConsts;

type
  TfrmPage2 = class(TPage)
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

{$R *.DFM}

procedure TfrmPage2.FormShow(Sender: TObject);
var i: integer;
begin
  Label3.Caption:=Driver.UDescription;
  ListBox1.Clear;
  for i:=0 to Driver.ChannelsCount-1 do
    ListBox1.Items.Add(Format(stChannelNum,[i+1]));
  if ListBox1.Items.Count>0 then ListBox1.ItemIndex:=0;
  ListBox1Click(nil);
end;

procedure TfrmPage2.ListBox1Click(Sender: TObject);
  function ChannelFlags(bit:byte):string;
  var t:byte;
  begin
    t:=Driver.ChannelFlags;
    if (t and bit)=0 then Result:=stFlagNo
                     else Result:=stFlagYes;
  end;
var s:string;
begin
  Memo1.Clear;
  Driver.ChannelNumber:=ListBox1.ItemIndex;
  if Driver.GetChannelParam=0 then begin
    with Memo1.Lines do begin
      Add(Format(stWCParams,[ListBox1.ItemIndex+1]));
      Add(stFlags);
      case lo(Integer(Driver.ChannelFlags)) and $3 of
        0: s:=stChannelType1;
        else s:=stChannelType4;
      end;
      Add(#9+Format(stFlagChannelType,[s]));
      Add(#9+Format(stFlagTareDevice,[ChannelFlags($4)]));
      Add(Format(stMax,[double(Driver.ChannelMaxWeight)]));
      Add(Format(stMin,[double(Driver.ChannelMinWeight)]));
      Add(Format(stMaxTare,[double(Driver.ChannelMaxTare)]));
      Add(Format(stInterval,[1,0.0,double(Driver.ChannelRange1)]));
      if Driver.ChannelRange2<>0 then
        Add(Format(stInterval,[2,double(Driver.ChannelRange1),double(Driver.ChannelRange2)]));
      if Driver.ChannelRange3<>0 then
        Add(Format(stInterval,[3,double(Driver.ChannelRange2),double(Driver.ChannelRange3)]));
      Add(Format(stDiscreteness,[1,double(Driver.ChannelDiscreteness1)]));
      if Driver.ChannelDiscreteness2<>0 then
        Add(Format(stDiscreteness,[2,double(Driver.ChannelDiscreteness2)]));
      if Driver.ChannelDiscreteness3<>0 then
        Add(Format(stDiscreteness,[3,double(Driver.ChannelDiscreteness3)]));
      if Driver.ChannelDiscreteness4<>0 then
        Add(Format(stDiscreteness,[4,double(Driver.ChannelDiscreteness4)]));
      Add(Format(stPointsCount,[integer(Driver.ChannelPointsCount)]));
    end;
  end
  else Application.MessageBox(
         PChar(string(Driver.ResultCodeDescription)),
         PChar(stError),MB_OK or MB_ICONERROR);
end;

end.
