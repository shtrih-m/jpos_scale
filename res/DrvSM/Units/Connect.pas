unit Connect;

interface

uses SysUtils, Windows, Messages, Classes, Graphics,
  Controls, StdCtrls, ExtCtrls, Forms, ComServ, ComObj,
  StdVcl, AxCtrls, Dialogs, ComCtrls, main, OleCtrls, Spin,
  SMConsts;

const
  IntSet:set of char=['0','1','2','3','4','5','6','7','8','9',#8];

type
  TfrmConnect = class(TPropertyPage)
    Label1: TLabel;
    Label2: TLabel;
    cbComNumber: TComboBox;
    cbBaudRate: TComboBox;
    btnSetBaudRate: TButton;
    btnConnect: TButton;
    btnFind: TButton;
    edError: TEdit;
    Button8: TButton;
    cbLD: TComboBox;
    btnEditLD: TButton;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label4: TLabel;
    seTimeOut: TSpinEdit;
    Edit1: TEdit;
    Label5: TLabel;
    Label7: TLabel;
    procedure btnSetBaudRateClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure edPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure Button8Click(Sender: TObject);
    procedure btnEditLDClick(Sender: TObject);
    procedure cbLDChange(Sender: TObject);
    procedure PropertyPageShow(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);
  private
    comN,BaudR, TimeO: byte;
    Act:integer;
  protected
    { Protected declarations }
  public
    procedure UpdatePropertyPage; override;
    procedure UpdateObject; override;
  end;

const
  Class_frmConnectLP: TGUID = '{DB22866D-5882-4A1D-9998-3EABBD10E4A5}';
  AvailKey=['0','1','2','3','4','5','6','7','8','9',#8];

implementation

uses About, {downlevel,} SMType, showresfind, //Table,
     Registry, editLD;

{$R *.DFM}

procedure TfrmConnect.UpdatePropertyPage;
var
  i:integer;
begin
  cbLD.Clear;
  OleObject.GetCountLD;
  for i:=0 to OleObject.LDCount-1 do begin
    OleObject.LDIndex:=i;
    OleObject.EnumLD;
    cbLD.Items.Add(OleObject.LDName);
  End;
  if OleObject.GetActiveLD=0 then cbLD.ItemIndex:=Oleobject.LDIndex
    else cbLD.ItemIndex:=-1;
  cbComNumber.Items.Clear;
  for i:=1 to 255 do
    cbComNumber.Items.Add(Format(stCOM,[i]));
  cbComNumber.Text:=Format(stCOM,[integer(OleObject.ComNumber)]);
  cbBaudRate.ItemIndex:=OleObject.BaudRate;
  seTimeout.Value:=OleObject.Timeout;

  Edit1.Text:=IntToStr(OleObject.Password);

  ComN:=OleObject.ComNumber;
  BaudR:=OleObject.BaudRate;
  TimeO:=OleObject.Timeout;
  if OleObject.GetActiveLD=0 then Act:=OleObject.LDNumber
    else Act:=0;
end;

procedure TfrmConnect.UpdateObject;
var s: string;
begin
  { Update OleObject from your controls }
  s:=cbComNumber.Text;
  if Length(s)>3 then s:=copy(s,4,Length(s)-3)
                 else s:='1';
  OleObject.ComNumber:=StrToInt(s);
  oleObject.Baudrate:=cbBaudRate.ItemIndex;
  OleObject.Timeout:=seTimeOut.Value;
  OleObject.Password:=StrToInt(Edit1.Text);

  if cbLD.ItemIndex>=0 then begin
    OleObject.LDIndex:=cbLD.ItemIndex;
    OleObject.EnumLD;
    if (OleObject.LDComNumber=StrToInt(s)) and
       (oleObject.LDBaudrate=cbBaudRate.ItemIndex) and
       (OleObject.LDTimeout=seTimeOut.Value) then
          OleObject.SetActiveLD;
  end;
  ComN:=OleObject.ComNumber;
  BaudR:=OleObject.BaudRate;
  TimeO:=OleObject.Timeout;
  if OleObject.GetActiveLD=0 then Act:=OleObject.LDNumber
    else Act:=0;

  OleObject.Connect;
end;

procedure TfrmConnect.btnSetBaudRateClick(Sender: TObject);
begin
  if not OleObject.Connected then OleObject.Connect;
  OleObject.BaudRate:=cbBaudrate.ItemIndex;
  OleObject.Timeout:=seTimeOut.Value;
  OleObject.SetExchangeParam;
  if OleObject.ResultCode=167 then edError.Text:='-1: '+erDescr_1
  else
  edError.Text:=IntToStr(OleObject.ResultCode)+': '+
    OleObject.ResultCodeDescription;
  OleObject.BaudRate:=BaudR;
  OleObject.Timeout:=TimeO;
end;

procedure TfrmConnect.btnConnectClick(Sender: TObject);
var s:string;
begin
  edError.Text:='';
  edError.Refresh;
  s:=cbComNumber.Text;
  if Length(s)>3 then s:=copy(s,4,Length(s)-3)
                 else s:='1';
  OleObject.ComNumber:=StrToInt(s);
  OleObject.BaudRate:=cbBaudRate.ItemIndex;
  OleObject.Timeout:=seTimeOut.Value;
  OleObject.Connect;
  if OleObject.ResultCode=0 then begin
      s:='';
      s:=TrimRight(OleObject.UDescription);
    end
    else s:=IntToStr(OleObject.ResultCode)+': '+OleObject.ResultCodeDescription;
  OleObject.ComNumber:=ComN;
  OleObject.BaudRate:=BaudR;
  OleObject.Timeout:=TimeO;
  if Act>0 then begin
    OleObject.LDNumber:=Act;
    OleObject.SetActiveLD;
  end;
  edError.Text:=s;
end;

procedure TfrmConnect.btnFindClick(Sender: TObject);
begin
  OleObject.Disconnect;
  ShowFormFindDevice(OleObject);
  cbComNumber.Text:=Format(stCOM,[integer(OleObject.ComNumber)]);
  cbBaudRate.ItemIndex:=OleObject.Baudrate;
  OleObject.ComNumber:=ComN;
  OleObject.BaudRate:=BaudR;
  OleObject.Timeout:=TimeO;
  if Act>0 then begin
    OleObject.LDNumber:=Act;
    OleObject.SetActiveLD;
  end;
end;

procedure TfrmConnect.edPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in AvailKey) then Key:=#0;
end;

procedure TfrmConnect.Button8Click(Sender: TObject);
begin
  ShowFormAbout;
end;

procedure TfrmConnect.btnEditLDClick(Sender: TObject);
var s: string;
  ischangeLD:boolean;
  i: integer;
begin
  with TfrmLD.Create(nil) do
    try
      s:=cbComNumber.Text;
      if Length(s)>3 then s:=copy(s,4,Length(s)-3)
                     else s:='1';
      ComNumber_:=StrToInt(s);
      BaudRate_:=cbBaudRate.ItemIndex;
      Timeout_:=Self.seTimeOut.Value;
      FMemo:=OleObject;
      ShowModal;
      ischangeLD:=change;
    finally
      Free;
    end;

  cbLD.Clear;
  OleObject.GetCountLD;
  for i:=0 to OleObject.LDCount-1 do begin
    OleObject.LDIndex:=i;
    OleObject.EnumLD;
    cbLD.Items.Add(OleObject.LDName);
  End;
  if OleObject.GetActiveLD=0 then cbLD.ItemIndex:=Oleobject.LDIndex
    else cbLD.ItemIndex:=-1;
  cbLDChange(nil);
end;

procedure TfrmConnect.cbLDChange(Sender: TObject);
begin
  if cbLD.ItemIndex<0 then exit;
  OleObject.LDIndex:=cbLD.ItemIndex;
  OleObject.EnumLD;
  OleObject.SetActiveLD;
  cbComNumber.Text:=Format(stCOM,[integer(OleObject.LDComNumber)]);
  cbBaudRate.ItemIndex:=OleObject.LDBaudRate;
  seTimeOut.Value:=OleObject.LDTimeout;

  OleObject.ComNumber:=ComN;
  OleObject.BaudRate:=BaudR;
  OleObject.Timeout:=TimeO;
  if Act>0 then begin
    OleObject.LDNumber:=Act;
    OleObject.SetActiveLD;
  end;

end;

procedure TfrmConnect.PropertyPageShow(Sender: TObject);
begin
  UpdatePropertyPage;
end;

procedure TfrmConnect.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in IntSet) then Key:=#0;
end;

procedure TfrmConnect.Edit1Exit(Sender: TObject);
begin
  try
    OleObject.Password:=StrToInt(Edit1.Text);
  except
    on EConvertError do ;
  end;
end;

initialization
  TActiveXPropertyPageFactory.Create(
    ComServer,
    TfrmConnect,
    Class_frmConnectLP);
end.


















