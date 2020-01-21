unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,
  pages, cuConsts,
  Page1, Page2, Page3, Page4, Page5, page2_5, GradEnterForm;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FDriver: TDriver;
    FLastPage: TPage;
    FPageList: TPageList;
    FActivePageIndex: integer;
    FCloseButton: boolean;
    function GetNextPage(ACurrent: integer): integer;
    function GetPrevPage(ACurrent: integer): integer;
    procedure SetActivePageIndex(AValue: integer);
    procedure ShowPage(Page: TPage);
    function IndexToPage(Index: Integer): TPage;
    property Driver: TDriver read FDriver;
    property ActivePageIndex: integer read FActivePageIndex write SetActivePageIndex;
    procedure UpdateError;
    procedure UpdatePage(Sender: TObject);
    procedure BreakCalibration;
    procedure EnterCalibrationMode;
    procedure EnterCalibrationModeEx;
    function GetMode: integer;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.DFM}

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  FCloseButton:=true;
  Close;
end;

procedure TfrmMain.ShowPage(Page: TPage);
begin
  if Page <> FLastPage then begin
    if Page <> nil then begin
      Page.Align := alClient;
      Page.Visible := True;
      Page.Width := Panel.ClientWidth;
    end;
    if FLastPage <> nil then FLastPage.Visible := False;
    FLastPage := Page;
  end;
end;

function TfrmMain.IndexToPage(Index: Integer): TPage;
begin
  if (Index < 0) or (Index >= FPageList.Count) then
    raise Exception.Create('Invalid page index');
  Result := FPageList[Index].Page;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  ActivePageIndex:=GetNextPage(ActivePageIndex);
  if ActivePageIndex=4 then Button2.Enabled:=false;
end;

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  ActivePageIndex:=GetPrevPage(ActivePageIndex);
end;

procedure TfrmMain.SetActivePageIndex(AValue: integer);
begin
  if (AValue>=0) and (AValue<FPageList.Count) then begin
    FActivePageIndex:=AValue;
    ShowPage(IndexToPage(FActivePageIndex));
    Button2.Enabled:=not (FActivePageIndex=FPageList.Count-1);
    Button3.Enabled:=not (FActivePageIndex=0);
  end;
  if AValue in [2,3] then Button1.Caption:=stBreak
  else Button1.Caption:=stExit;
end;

function TfrmMain.GetNextPage(ACurrent: integer): integer;
var bErr: boolean;
//    mr: TModalResult;
begin
  Button1.Enabled:=false;
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  Result:=ACurrent;
  with Driver do begin
    case ACurrent of
      0: begin
        // делаем Connect
        if DrvSM.Connect<>0 then UpdateError
        // проверка на правильность пароля
        else if DrvSM.GetExchangeParam<>0 then UpdateError
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
            if DrvSM.ResultCode<0 then UpdateError;
            if DrvSM.ResultCode=0 then bErr := false;
            if DrvSM.ResultCode>0 then begin
              case ShowGradEnterForm of
                mrOK: begin
                  EnterCalibrationModeEx;
                  if DrvSM.ResultCode<>0 then UpdateError
                  else bErr := false;
                end;
                mrRetry: begin
                  EnterCalibrationMode;
                  if DrvSM.ResultCode<0 then UpdateError
                  else bErr := false;
                end;
                mrCancel: MessageBox(Handle, PChar(stNoCalibMode), PChar(stError), MB_OK or MB_ICONERROR);
              end;
            end;
            if not bErr then begin
              Sleep(500);
              case GetMode of
                -1: UpdateError;
                0:  MessageBox(Handle, PChar(stNoCalibMode), PChar(stError), MB_OK or MB_ICONERROR);
                1:  begin
                  if DrvSM.GetCalibrationStatus<>0 then UpdateError
                  else Result := 3;
                end;
              end;
            end;
          end;
          1: begin
            if DrvSM.GetCalibrationStatus<>0 then UpdateError
            else Result := 3;
          end;
        end;
      end;
      3: begin
        if DrvSM.StartCalibration<>0 then UpdateError
        else Result:=4;
      end;
      4: begin
        BreakCalibration;
        Result:=5;
      end;
    end;
  end;
  Button1.Enabled:=true;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;

procedure TfrmMain.BreakCalibration;
begin
  Button1.Enabled:=false;
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  with Driver do begin
    DrvSM.BreakCalibration;
    DrvSM.Mode:=0;
    DrvSM.SetMode;
    DrvSM.LockKeyboardON:=false;
    DrvSM.LockKeyboard;
  end;
  Button1.Enabled:=true;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;

function TfrmMain.GetPrevPage(ACurrent: integer): integer;
begin
  Button1.Enabled:=false;
  Button2.Enabled:=false;
  Button3.Enabled:=false;
  Result:=ACurrent;
  case ACurrent of
    1,5: Result:=0;
    2: begin
      Result:=1;
      if GetMode=1 then BreakCalibration;
    end;
    3,4: begin
      if MessageBox(Handle,
          PChar(stConfirmation),
          PChar(stconfirmationTitle),
          MB_YESNO or MB_ICONQUESTION)=mrYes then begin
        BreakCalibration;
        Result:=0;
      end;
    end;
  end;
  Button1.Enabled:=true;
  Button2.Enabled:=true;
  Button3.Enabled:=true;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
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
  FDriver := TDriver.Create;
  FPageList := TPageList.Create;
  FPageList.Add(TfrmPage1);  {0}
  FPageList.Add(TfrmPage2);  {1}
  FPageList.Add(TfrmPage2_5);{2}
  FPageList.Add(TfrmPage3);  {3}
  FPageList.Add(TfrmPage4);  {4}
  FPageList.Add(TfrmPage5);  {5}
  for i := 0 to FPageList.Count-1 do begin
    Item := FPageList[i];
    if Item.Page = nil then begin
      Item.Page := Item.PageClass.CreatePage(Self, Driver);
      Item.Page.BorderStyle := bsNone;
      Item.Page.Parent := Panel;
      Item.Page.OnUpdate := UpdatePage;
      Item.Page.Width := Panel.ClientWidth;
      Item.Page.Height := Panel.ClientHeight;
      Item.Page.Tag := i;
    end;
  end;
  ActivePageIndex:=0;
  FCloseButton:=false;
end;

procedure TfrmMain.UpdatePage(Sender: TObject);
begin
  if Driver.DrvSM.ResultCode<>0 then begin
    UpdateError;
    BreakCalibration;
    ActivePageIndex:=0;
  end
  else if TPage(Sender).Tag=4 then begin
    if Driver.DrvSM.FixedPointStatus=0 then
      ActivePageIndex:=3 // продолжаем калибровку
    else ActivePageIndex:=GetNextPage(ActivePageIndex);// готово => завершение
  end;
end;

procedure TfrmMain.UpdateError;
begin
  if Driver.DrvSM.ResultCode<>0 then
    MessageBox(Handle,
         PChar(string(Driver.DrvSM.ResultCodeDescription)),
         PChar(stError),MB_OK or MB_ICONERROR);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Button1.Caption=stBreak then begin
    CanClose:=not FCloseButton;
    if MessageBox(Handle,
         PChar(stConfirmation),
         PChar(stconfirmationTitle),
         MB_YESNO or MB_ICONQUESTION)=mrYes then begin
      BreakCalibration;
      if FCloseButton then ActivePageIndex:=0;
    end;
  end;
  FCloseButton:=false;
end;

procedure TfrmMain.EnterCalibrationMode;
begin
  with Driver do begin
    DrvSM.LockKeyboardON:=true;
    DrvSM.LockKeyboard;
    if (DrvSM.ResultCode<>0) and (DrvSM.ResultCode<>167) then exit;
    DrvSM.Mode:=1;
    DrvSM.SetMode;
  end;
end;

procedure TfrmMain.EnterCalibrationModeEx;
const Keys:array[1..10] of byte = (60, 60, 188, 61, 189, 61, 61, 189, 60, 188);
var i: integer;
begin
  with Driver do begin
    for i:=low(Keys) to high(Keys) do begin
      DrvSM.Key := Keys[i];
      if DrvSM.KeyEmulation<>0 then break;
    end;
  end;
end;

function TfrmMain.GetMode: integer;
begin
  Result := -1;
  if Driver.DrvSM.GetMode=0 then Result := Driver.DrvSM.Mode;
end;

end.
