program CalibUtil;

uses
  Forms,
  main in 'main.pas' {frmMain},
  pages in 'pages.pas',
  AddIn_TLB in 'AddIn_TLB.pas',
  page1 in 'page1.pas' {frmPage1},
  Page2 in 'Page2.pas' {frmPage2},
  Page3 in 'Page3.pas' {frmPage3},
  Page4 in 'Page4.pas' {frmPage4},
  Page5 in 'Page5.pas' {frmPage5},
  Page2_5 in 'Page2_5.pas' {frmPage2_5},
  cuConsts in 'cuConsts.pas',
  GradEnterForm in 'GradEnterForm.pas' {frmGradEnter};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmGradEnter, frmGradEnter);
  Application.Run;
end.
