unit fmuPage2_5;

interface

uses
  // CLX
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls,
  // This
  Pages, QTypes;

type
  TfmPage2_5 = class(TPage)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Timer: TTimer;
    procedure TimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  end;

var
  fmPage2_5: TfmPage2_5;

implementation

{$R *.xfm}

procedure TfmPage2_5.TimerTimer(Sender: TObject);
begin
  if Driver.GetADCValue=0 then
    Edit1.Text:=IntToStr(Driver.ADCValue);
end;

procedure TfmPage2_5.FormShow(Sender: TObject);
begin
  Timer.Enabled:=true;
end;

procedure TfmPage2_5.FormHide(Sender: TObject);
begin
  Timer.Enabled:=false;
end;

end.
