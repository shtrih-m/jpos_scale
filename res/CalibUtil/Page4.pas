unit Page4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls,
  pages, cuConsts;

type
  TfrmPage4 = class(TPage)
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

{$R *.DFM}

procedure TfrmPage4.FormShow(Sender: TObject);
begin
  if Driver.CalibrationWeight=0 then FPointNumber:=0
  else inc(FPointNumber);
  Label8.Caption:=Format(stCalibPoint2,[FPointNumber+1,double(Driver.CalibrationWeight)]);
  with Animate1 do Play(StartFrame,StopFrame div 2,0);
  Timer.Enabled:=true;
end;

procedure TfrmPage4.FormHide(Sender: TObject);
begin
  Animate1.Stop;
  Timer.Enabled:=false;
end;

procedure TfrmPage4.TimerTimer(Sender: TObject);
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

function TfrmPage4.StatusString(Number: integer): string;
begin
  case Number of
    0: Result:=stCalibStatus1;
    1: Result:=stCalibStatus2;
    2: Result:=stCalibStatus3;
    3: Result:=stCalibStatus4;
    4: Result:=stCalibStatus5;
    else Result:='';
  end;
end;

end.
