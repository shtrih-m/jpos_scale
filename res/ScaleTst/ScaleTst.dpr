program ScaleTst;

uses
  Forms,
  fmuMain in 'fmuMain.pas' {fmMain},
  AddIn_TLB in 'AddIn_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
