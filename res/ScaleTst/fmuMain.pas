unit fmuMain;

interface

uses
  // VCL
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  // This
  AddIn_TLB;

type
  TfmMain = class(TForm)
    Memo: TMemo;
    btnStart: TButton;
    btnStop: TButton;
    btnClose: TButton;
    btnDriver: TButton;
    btnClear: TButton;
    btnReadChannel: TButton;
    procedure btnClearClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnDriverClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnReadChannelClick(Sender: TObject);
  private
    function GetDriver: TDrvSM;
    procedure Check(ResultCode: Integer);
    procedure EnterCalibrationMode;
    procedure ExitCalibrationMode;
  private
    FDriver: TDrvSM;
    FStopFlag: Boolean;
    property Driver: TDrvSM read GetDriver;
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

function CalibrationStatusToStr(Number: Integer): string;
begin
  case Number of
    0: Result := 'точка готова для измерения';
    1: Result := 'успокоения нет';
    2: Result := 'точка измеряется, успокоение есть';
    3: Result := 'градуировка закончена успешно';
    4: Result := 'градуировка закончена с ошибкой, реперные точки не изменены';
  else
    Result := 'неизвестное состояние';
  end;
end;

{ TfmMain }

function TfmMain.GetDriver: TDrvSM;
begin
  if FDriver = nil then
    FDriver := TDrvSM.Create(Self);
  Result := FDriver;
end;

procedure TfmMain.btnClearClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TfmMain.Check(ResultCode: Integer);
begin
  if ResultCode <> 0 then
    raise Exception.CreateFmt('%d, %s', [Driver.ResultCode, Driver.ResultCodeDescription]);
end;

procedure TfmMain.EnterCalibrationMode;
const
  Password: array[1..10] of Byte = (60, 60, 188, 61, 189, 61, 61, 189, 60, 188);
var
  i: Integer;
begin
  for i := Low(Password) to High(Password) do
  begin
    Driver.Key := Password[i];
    Check(Driver.KeyEmulation);
  end;
end;

procedure TfmMain.ExitCalibrationMode;
begin
  Driver.BreakCalibration;
  Driver.Mode := 0;
  Driver.SetMode;
  Driver.LockKeyboardON := False;
  Driver.LockKeyboard;
end;

procedure TfmMain.btnStartClick(Sender: TObject);
var
  S: string;
  PointStatus: Integer;
begin
  Memo.Clear;
  PointStatus := -1;
  FStopFlag := False;
  btnStart.Enabled := False;
  btnStop.Enabled := True;
  btnStop.SetFocus;

  Check(Driver.Connect);
  try
    ExitCalibrationMode;
    EnterCalibrationMode();
    Memo.Lines.Add('-> EnterCalibrationMode');
    while not FStopFlag do
    begin
      Sleep(200);
      if Driver.GetCalibrationStatus = 0 then
      begin
        if Driver.FixedPointStatus <> PointStatus then
        begin
          Memo.Lines.Add(Format('<- Вес: %.3f, состояние: %d, %s',
            [Driver.CalibrationWeight, Driver.FixedPointStatus,
            CalibrationStatusToStr(Driver.FixedPointStatus)]));

          PointStatus := Driver.FixedPointStatus;
          if Driver.FixedPointStatus = 0 then
          begin
            S := Format('Установите вес %.3f', [Driver.CalibrationWeight]);
            MessageBox(Handle, PChar(S), 'Внимание', MB_OK);
            check(Driver.StartCalibration);
            Memo.Lines.Add('-> StartCalibration');
          end;
        end;
        Application.ProcessMessages;
        if Driver.FixedPointStatus in [3, 4] then Break;
      end;
    end;
    ExitCalibrationMode;
  finally
    Driver.Disconnect;
    btnStop.Enabled := False;
    btnStart.Enabled := True;
    btnStart.SetFocus;
  end;
end;

procedure TfmMain.btnDriverClick(Sender: TObject);
begin
  Driver.ShowProperties;
end;

procedure TfmMain.btnStopClick(Sender: TObject);
begin
  FStopFlag := True;
end;

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FStopFlag := True;
end;

procedure TfmMain.btnReadChannelClick(Sender: TObject);
var
  i: Integer;
  Count: Integer;
begin
  btnReadChannel.Enabled := False;
  try
    Memo.Clear;
    Check(Driver.Connect);
    Check(Driver.GetChannelsCount);
    Count := Driver.ChannelsCount;
    for i := 0 to Count-1 do
    begin
      Driver.ChannelNumber := i;
      Check(Driver.GetChannelParam);
      Memo.Lines.Add(Format('Минимальный вес   : %.3f', [Driver.ChannelMinWeight]));
      Memo.Lines.Add(Format('Максимальный вес  : %.3f', [Driver.ChannelMaxWeight]));
      Memo.Lines.Add(Format('Максимальная тара : %.3f', [Driver.ChannelMaxTare]));
      Memo.Lines.Add(Format('Количество точек  : %d', [Driver.ChannelPointsCount]));
    end;
  finally
    btnReadChannel.Enabled := True;
    btnReadChannel.SetFocus;
  end;
end;

end.
