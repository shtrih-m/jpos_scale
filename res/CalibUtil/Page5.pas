unit Page5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  pages, cuConsts;

type
  TfrmPage5 = class(TPage)
    Label1: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.DFM}

procedure TfrmPage5.FormShow(Sender: TObject);
begin
  if Driver.FixedPointStatus=3 then begin
    Label1.Caption:=stCalibSuccess;
    Label6.Visible:=false;
  end
  else begin
    Label1.Caption:=stCalibFailed;
    Label6.Visible:=true;
  end;
end;

procedure TfrmPage5.FormCreate(Sender: TObject);
begin
  Label6.Caption:=stErrorReasons;
end;

end.
