program CalibUtil;

uses
  QForms,
  Pages in 'Pages.pas',
  fmuMain in 'fmuMain.pas' {fmMain},
  fmuPage1 in 'fmuPage1.pas' {fmPage1},
  fmuPage2 in 'fmuPage2.pas' {fmPage2},
  fmuPage3 in 'fmuPage3.pas' {fmPage3},
  fmuPage4 in 'fmuPage4.pas' {fmPage4},
  fmuPage5 in 'fmuPage5.pas' {fmPage5},
  fmuPage2_5 in 'fmuPage2_5.pas' {fmPage2_5},
  fmuPassword in 'fmuPassword.pas' {fmPassword},
  QtUtils in 'QtUtils.pas',
  BaseForm in 'BaseForm.pas',
  DebugUtils in 'DebugUtils.pas',
  synautil in 'synautil.pas',
  synafpc in 'synafpc.pas',
  fmuAbout in 'fmuAbout.pas' {fmAbout},
  fmuConnect in 'fmuConnect.pas' {fmConnect: TPropertyPage},
  fmuSearch in 'fmuSearch.pas' {fmSearch},
  FindDevice in 'FindDevice.pas',
  ScaleDriver in 'ScaleDriver.pas',
  ScaleProtocol in 'ScaleProtocol.pas',
  ScaleIntf in 'ScaleIntf.pas',
  DriverError in 'DriverError.pas',
  SerialPort in 'SerialPort.pas',
  StringUtils in 'StringUtils.pas',
  RegExpr in 'RegExpr.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmPassword, fmPassword);
  Application.Run;
end.
