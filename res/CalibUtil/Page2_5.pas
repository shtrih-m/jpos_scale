unit Page2_5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,
  Pages;

type
  TfrmPage2_5 = class(TPage)
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
  frmPage2_5: TfrmPage2_5;

implementation

{$R *.DFM}

procedure TfrmPage2_5.TimerTimer(Sender: TObject);
begin
  if Driver.GetADCValue=0 then 
    Edit1.Text:=IntToStr(Driver.ADCValue);
end;

procedure TfrmPage2_5.FormShow(Sender: TObject);
begin
  Timer.Enabled:=true;
end;

procedure TfrmPage2_5.FormHide(Sender: TObject);
begin
  Timer.Enabled:=false;
end;

end.
