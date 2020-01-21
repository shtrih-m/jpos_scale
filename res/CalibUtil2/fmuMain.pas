unit fmuMain;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QExtCtrls, QStdCtrls,
  // This
  pages, ScaleIntf, ScaleDriver, gnugettext,
  fmuPage1, fmuPage2, fmuPage3, fmuPage4, fmuPage5, fmuPage2_5, fmuPassword;

type
  TfmMain = class(TForm)
    btnClose: TButton;
    btnNext: TButton;
    btnPrev: TButton;
    Panel: TPanel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FDriver: DrvSM;
    FLastPage: TPage;
    FPageList: TPageList;
    FActivePageIndex: integer;
    FCloseButton: boolean;
    function GetNextPage(ACurrent: integer): integer;
    function GetPrevPage(ACurrent: integer): integer;
    procedure SetActivePageIndex(AValue: integer);
    procedure ShowPage(Page: TPage);
    function IndexToPage(Index: Integer): TPage;
    property Driver: DrvSM read FDriver;
    property ActivePageIndex: integer read FActivePageIndex write SetActivePageIndex;
    procedure UpdateError;
    procedure UpdatePage(Sender: TObject);
    procedure BreakCalibration;
    procedure EnterCalibrationMode;
    procedure EnterCalibrationModeEx;
    function GetMode: integer;
    function GetConfirmation: Boolean;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.xfm}

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  FCloseButton:=true;
  Close;
end;

procedure TfmMain.ShowPage(Page: TPage);
begin
  if Page <> FLastPage then
  begin
    if Page <> nil then
    begin
      Page.Align := alClient;
      Page.Reparent(Panel);
      Page.Visible := True;
      Page.Width := Panel.ClientWidth;
    end;
    if FLastPage <> nil then FLastPage.Visible := False;
    FLastPage := Page;
  end;
end;

function TfmMain.IndexToPage(Index: Integer): TPage;
begin
  if (Index < 0) or (Index >= FPageList.Count) then
    raise Exception.Create(_('Invalid page index'));
  Result := FPageList[Index].Page;
end;

procedure TfmMain.btnNextClick(Sender: TObject);
begin
  ActivePageIndex:=GetNextPage(ActivePageIndex);
  if ActivePageIndex=4 then btnNext.Enabled:=false;
end;

procedure TfmMain.btnPrevClick(Sender: TObject);
begin
  ActivePageIndex:=GetPrevPage(ActivePageIndex);
end;

procedure TfmMain.SetActivePageIndex(AValue: integer);
begin
  if (AValue>=0) and (AValue<FPageList.Count) then begin
    FActivePageIndex:=AValue;
    ShowPage(IndexToPage(FActivePageIndex));
    btnNext.Enabled:=not (FActivePageIndex=FPageList.Count-1);
    btnPrev.Enabled:=not (FActivePageIndex=0);
  end;
  if AValue in [2,3] then
    btnClose.Caption := _('Прервать')
  else
    btnClose.Caption := _('Выйти');
end;

function TfmMain.GetNextPage(ACurrent: integer): integer;
var
  bErr: boolean;
  stNoCalibMode: string;
begin
  stNoCalibMode := _('Невозможно перейти в режим градуировки.'#13#10 +
    'Возможно, надо установить градуировочный переключатель'#13#10 +
    'в положение ВКЛ (ON).');

  btnClose.Enabled:=false;
  btnNext.Enabled:=false;
  btnPrev.Enabled:=false;
  Result:=ACurrent;
    case ACurrent of
      0: begin
        // делаем Connect
        if Driver.Connect <> 0 then UpdateError
        // проверка на правильность пароля
        else if Driver.GetExchangeParam<>0 then UpdateError
        else Result:=1;
      end;
      1: Result:=2;
      2: begin
        // переходим в режим градуировки
        bErr := true;
        case GetMode of
          -1: UpdateError;
          0: begin
            EnterCalibrationMode;
            if Driver.ResultCode<0 then UpdateError;
            if Driver.ResultCode=0 then bErr := false;
            if Driver.ResultCode>0 then
            begin
              case ShowGradEnterForm of
                mrOK: begin
                  EnterCalibrationModeEx;
                  if Driver.ResultCode<>0 then UpdateError
                  else bErr := false;
                end;
                mrRetry: begin
                  EnterCalibrationMode;
                  if Driver.ResultCode<0 then UpdateError
                  else bErr := false;
                end;
                mrCancel: Application.MessageBox(PChar(stNoCalibMode),
                  PWideChar(_('Ошибка')), [], smsCritical);
              end;
            end;
            if not bErr then begin
              Sleep(500);
              case GetMode of
                -1: UpdateError;
                0:  Application.MessageBox(PChar(stNoCalibMode), PWideChar(_('Ошибка')), [], smsCritical);
                1:  begin
                  if Driver.GetCalibrationStatus<>0 then UpdateError
                  else Result := 3;
                end;
              end;
            end;
          end;
          1: begin
            if Driver.GetCalibrationStatus<>0 then UpdateError
            else Result := 3;
          end;
        end;
      end;
      3: begin
        if Driver.StartCalibration<>0 then UpdateError
        else Result:=4;
      end;
      4: begin
        BreakCalibration;
        Result:=5;
      end;
  end;
  btnClose.Enabled:=true;
  btnNext.Enabled:=true;
  btnPrev.Enabled:=true;
end;

procedure TfmMain.BreakCalibration;
begin
  btnClose.Enabled:=false;
  btnNext.Enabled:=false;
  btnPrev.Enabled:=false;
  with Driver do begin
    Driver.BreakCalibration;
    Driver.Mode:=0;
    Driver.SetMode;
    Driver.LockKeyboardON:=false;
    Driver.LockKeyboard;
  end;
  btnClose.Enabled:=true;
  btnNext.Enabled:=true;
  btnPrev.Enabled:=true;
end;

function TfmMain.GetPrevPage(ACurrent: integer): integer;
begin
  btnClose.Enabled:=false;
  btnNext.Enabled:=false;
  btnPrev.Enabled:=false;
  Result:=ACurrent;
  case ACurrent of
    1,5: Result:=0;
    2: begin
      Result:=1;
      if GetMode=1 then BreakCalibration;
    end;
    3,4:
    begin
      if GetConfirmation then
      begin
        BreakCalibration;
        Result := 0;
      end;
    end;
  end;
  btnClose.Enabled:=true;
  btnNext.Enabled:=true;
  btnPrev.Enabled:=true;
end;

function TfmMain.GetConfirmation: Boolean;
var
  stConfirmation: string;
  stconfirmationTitle: string;
begin
  stConfirmation := _('Вы уверены, что хотите прервать процесс градуировки?');
  stconfirmationTitle := _('Подтверждение');
  Result := Application.MessageBox(PChar(stConfirmation),
    PChar(stconfirmationTitle), [smbYes, smbNo], smsInformation) = smbYes;
end;


procedure TfmMain.FormCreate(Sender: TObject);
var i: Integer;
    Item: TPageItem;
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
  // initialization
  FDriver := TScaleDriver.Create(nil);
  FPageList := TPageList.Create;
  FPageList.Add(TfmPage1);  {0}
  FPageList.Add(TfmPage2);  {1}
  FPageList.Add(TfmPage2_5);{2}
  FPageList.Add(TfmPage3);  {3}
  FPageList.Add(TfmPage4);  {4}
  FPageList.Add(TfmPage5);  {5}
  for i := 0 to FPageList.Count-1 do begin
    Item := FPageList[i];
    if Item.Page = nil then begin
      Item.Page := Item.PageClass.CreatePage(Self, Driver);
      Item.Page.Parent := Panel;
      Item.Page.BorderStyle := fbsSizeable;
      Item.Page.OnUpdate := UpdatePage;
      Item.Page.Width := Panel.ClientWidth;
      Item.Page.Height := Panel.ClientHeight;
      Item.Page.Tag := i;
    end;
  end;
  ActivePageIndex:=0;
  FCloseButton:=false;
end;

procedure TfmMain.UpdatePage(Sender: TObject);
begin
  if Driver.ResultCode<>0 then begin
    UpdateError;
    BreakCalibration;
    ActivePageIndex:=0;
  end
  else if TPage(Sender).Tag=4 then begin
    if Driver.FixedPointStatus=0 then
      ActivePageIndex:=3 // продолжаем калибровку
    else ActivePageIndex:=GetNextPage(ActivePageIndex);// готово => завершение
  end;
end;

procedure TfmMain.UpdateError;
begin
  if Driver.ResultCode <> 0 then
  begin
    Application.MessageBox(PWideChar(Driver.ResultCodeDescription),
      PWideChar(_('Ошибка')), [], smsCritical);
  end;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btnClose.Caption = _('Прервать') then
  begin
    CanClose := not FCloseButton;
    if GetConfirmation then
    begin
      BreakCalibration;
      if FCloseButton then ActivePageIndex := 0;
    end;
  end;
  FCloseButton:=false;
end;

procedure TfmMain.EnterCalibrationMode;
begin
  with Driver do begin
    Driver.LockKeyboardON:=true;
    Driver.LockKeyboard;
    if (Driver.ResultCode<>0) and (Driver.ResultCode<>167) then exit;
    Driver.Mode:=1;
    Driver.SetMode;
  end;
end;

procedure TfmMain.EnterCalibrationModeEx;
const
  Keys:array[1..10] of byte = (60, 60, 188, 61, 189, 61, 61, 189, 60, 188);
var
  i: integer;
begin
  with Driver do begin
    for i:=low(Keys) to high(Keys) do begin
      Driver.Key := Keys[i];
      if Driver.KeyEmulation<>0 then break;
    end;
  end;
end;

function TfmMain.GetMode: integer;
begin
  Result := -1;
  if Driver.GetMode=0 then Result := Driver.Mode;
end;

end.
