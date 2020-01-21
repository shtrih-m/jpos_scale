unit Page3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Pages, StdCtrls, cuConsts;

type
  TfrmPage3 = class(TPage)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FPointNumber: integer;
  end;

implementation

{$R *.DFM}

procedure TfrmPage3.FormShow(Sender: TObject);
begin
  if Driver.CalibrationWeight=0 then FPointNumber:=0
  else inc(FPointNumber);
  Label8.Caption:=Format(stCalibPoint,[FPointNumber+1,double(Driver.CalibrationWeight)]);
  Label2.Caption:=Format(stNeedLoad,[double(Driver.CalibrationWeight)]);
  if Driver.CalibrationWeight=0 then
    Label2.Caption:=Label2.Caption+stEmptyReceptor;
end;

end.
