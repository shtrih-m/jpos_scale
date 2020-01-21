unit fmuEditLD;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QComCtrls, QExtCtrls,
  // This
  SMType;

type
  TfmEditLD = class(TForm)
    btnClose: TButton;
    lwLD: TListView;
    btnAddLD: TButton;
    btnDelLD: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edName: TEdit;
    Label2: TLabel;
    cbCNLD: TComboBox;
    Label3: TLabel;
    cbBDLD: TComboBox;
    edError: TEdit;
    Bevel1: TBevel;
    seTimeout: TSpinEdit;
    Label8: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure btnAddLDClick(Sender: TObject);
    procedure btnDelLDClick(Sender: TObject);
    procedure lwLDSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormShow(Sender: TObject);
    procedure seTimeoutChange(Sender: TObject);
    procedure lwLDDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
    FMemo:OleVariant;
    NextNumLD:Word;
    ComNumber_:byte;
    BaudRate_:byte;
    Timeout_:word;
    change: boolean;
  end;

procedure ShowFormLD(AMemo:OleVariant);

implementation

{$R *.xfm}

procedure ShowFormLD(AMemo:OleVariant);
begin
  with TfmEditLD.Create(nil) do
    try
      FMemo:=AMemo;
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfmEditLD.btnAddLDClick(Sender: TObject);
begin
  FMemo.LDName:=edName.Text;
  FMemo.LDComNumber:=cbCNLD.ItemIndex+1;
  FMemo.LDBaudRate:=cbBDLD.ItemIndex;
  FMemo.LDTimeout:=seTimeout.Value;
  with lwLD.Items.Add do begin
    If FMemo.AddLD=0 Then begin
      Caption:=IntToStr(FMemo.LDNumber);
      SubItems.Add(FMemo.LDName);
      inc(NextNumLD);
      Selected:=true;
    End;
    edError.Text:=IntToStr(FMemo.ResultCode)+': '+
      FMemo.ResultCodeDescription;
    lwLd.Scroll(0,1000);
  end;
end;

procedure TfmEditLD.btnDelLDClick(Sender: TObject);
var lI:TListItem;
begin
  if lwLD.Selected<>nil then begin
    FMemo.LDNumber:=StrToInt(lwLD.Selected.Caption);
    If FMemo.DeleteLD=0 Then Begin
      li:=lwLD.GetNextItem(lwLD.Selected,sdAll,[isNone]);
      lwLD.Selected.Delete;
      if li<>nil then begin
        li.Selected:=true;
      end
      else begin
        edName.Text:='';
        cbCNLD.ItemIndex:=-1;
        cbBDLD.ItemIndex:=-1;
        seTimeout.Value:=0;
      end;
    End;
    edError.Text:=IntToStr(FMemo.ResultCode)+': '+
      FMemo.ResultCodeDescription;
  end;
end;

procedure TfmEditLD.lwLDSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  if Selected then begin
    FMemo.LDNumber:=StrToInt(Item.Caption);
    FMemo.GetParamLD;
    edName.Text:=FMemo.LDName;
    cbCNLD.ItemIndex:=FMemo.LDComNumber-1;
    cbBDLD.ItemIndex:=FMemo.LDBaudRate;
    seTimeout.Value:=FMemo.LDTimeout;
  end;
end;

procedure TfmEditLD.FormShow(Sender: TObject);
var i:integer;
    num: Integer;
    act:integer;
begin
  // application position
  if (Screen.Width=2048) and (Screen.Height=768) then begin
    Left:=(1024 - Width) div 2;
    Top:=(768 - Height) div 2;
  end
  else begin
    Left:=(Screen.Width - Width) div 2;
    Top:=(Screen.Height - Height) div 2;
  end;
  //
  change:=false;
  if FMemo.GetActiveLD<0 then act:=0
    else act:=FMemo.LDIndex;
  FMemo.GetCountLD;
  num:=FMemo.LDCount;
  for i:=0 to num-1 do begin
    FMemo.LDIndex:=i;
    FMemo.EnumLD;
    with lwLD.Items.Add do begin
      Caption:=IntToStr(FMemo.LDNumber);
      SubItems.Add(FMemo.LDName);
      if i=act then Selected:=true;
    end;
  End;
  if FMemo.GetActiveLD<>0 then FMemo.LDIndex:=0;
  FMemo.EnumLD;
  edName.Text:=FMemo.LDName;
  cbCNLD.ItemIndex:=FMemo.LDComNumber-1;
  cbBDLD.ItemIndex:=FMemo.LDBaudRate;
  seTimeout.Value:=FMemo.LDTimeout;
  NextNumLD:=num+1;
end;

procedure TfmEditLD.seTimeoutChange(Sender: TObject);
begin
{  if lwLD.Selected<>nil then begin
    FMemo.LDNumber:=StrToInt(lwLD.Selected.Caption);
    FMemo.GetParamLD;
    FMemo.LDTimeout:=seTimeout.Value;
    FMemo.SetParamLD;
  end;           }
end;

procedure TfmEditLD.lwLDDblClick(Sender: TObject);
begin
  if lwLD.Selected<>nil then begin
    FMemo.LDNumber:=StrToInt(lwLD.Selected.Caption);
    FMemo.SetActiveLD;
    Change:=true;
    Close;
  end;
end;

procedure TfmEditLD.Button1Click(Sender: TObject);
begin
  if lwLD.Selected<>nil then begin
    FMemo.LDName:=edName.Text;
    lwLD.Selected.SubItems[0]:=edName.Text;
    FMemo.LDComNumber:=cbCNLD.ItemIndex+1;
    FMemo.LDBaudRate:=cbBDLD.ItemIndex;
    FMemo.LDTimeout:=seTimeout.Value;
    FMemo.LDNumber:=StrToInt(lwLD.Selected.Caption);
    if FMemo.SetParamLD<>0 Then
        edError.Text:=IntToStr(FMemo.ResultCode)+': '+FMemo.ResultCodeDescription;
  end;
end;

procedure TfmEditLD.Button2Click(Sender: TObject);
begin
  cbCNLD.ItemIndex:=ComNumber_-1;
  cbBDLD.ItemIndex:=BaudRate_;
  seTimeout.Value:=Timeout_;
  edName.SelectAll;
  edName.SetFocus;
end;

end.






