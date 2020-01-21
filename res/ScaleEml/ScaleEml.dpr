program ScaleEml;

uses
  Forms,
  fmuMain in 'fmuMain.pas' {fmMain},
  Scale in 'Scale.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
