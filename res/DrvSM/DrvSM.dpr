library DrvSM;

uses
  ComServ,
  AddIn_TLB in 'AddIn_TLB.pas',
  main in 'Units\main.pas' {DrvSM: CoClass},
  About in 'Units\About.pas' {frmAbout},
  CommUnit in 'Units\CommUnit.pas',
  Connect in 'Units\Connect.pas' {frmConnect: TPropertyPage},
  EditLD in 'Units\EditLD.pas' {frmLD},
  find in 'Units\FIND.PAS',
  MyCOM in 'Units\MyCOM.pas',
  showresfind in 'Units\showresfind.pas' {frmFindDevice},
  SMType in 'Units\SMType.pas',
  SMConsts in 'Units\SMConsts.pas',
  Unit1 in 'Units\Unit1.pas' {Form1},
  USBDetect in 'Units\USBDetect.pas';

{Form1}

exports
  DllGetClassObject,
  DllCanUnloadNow,
  DllRegisterServer,
  DllUnregisterServer;

{$R *.TLB}

{$R *.RES}

begin
end.
