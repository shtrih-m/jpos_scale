unit fmuPage4;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QComCtrls, QTypes,
  // This
  Pages, gnugettext;

type
  TfmPage4 = class(TPage)
    Label1: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Timer: TTimer;
    Animate1: TAnimate;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
  private
    FPointNumber: integer;
    function StatusString(Number: integer): string;
  end;

implementation

{$R *.xfm}

procedure TfmPage4.FormShow(Sender: TObject);
begin
  if Driver.CalibrationWeight=0 then FPointNumber:=0
  else inc(FPointNumber);
  Label8.Caption := Format(_('  Градуируется реперная точка №%d (вес %8.3f кг).'),
    [FPointNumber + 1, Driver.CalibrationWeight]);
  Timer.Enabled := True;
  //with Animate1 do Play(StartFrame,StopFrame div 2,0);
end;

procedure TfmPage4.FormHide(Sender: TObject);
begin
  //Animate1.Stop;
  Timer.Enabled:=false;
end;

procedure TfmPage4.TimerTimer(Sender: TObject);
begin
  if Driver.GetCalibrationStatus=0 then begin
    Label7.Caption:=StatusString(Driver.FixedPointStatus);
    if Driver.FixedPointStatus in [0,3,4] then begin
      Timer.Enabled:=false;
      UpdatePage;
    end;
  end
  else begin
    Timer.Enabled:=false;
    UpdatePage;
  end;
end;

function TfmPage4.StatusString(Number: integer): string;
begin
  case Number of
    0: Result := _('точка готова для измерения');
    1: Result := _('успокоения нет');
    2: Result := _('точка измеряется, успокоение есть');
    3: Result := _('градуировка закончена успешно');
    4: Result := _('градуировка закончена с ошибкой, реперные точки не изменены');
  else
    Result := '';
  end;
end;

end.
