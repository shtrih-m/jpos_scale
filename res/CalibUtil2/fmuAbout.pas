unit fmuAbout;

interface

uses
  // CLX
  SysUtils, Classes,
  {$IFDEF MSWINDOWS}
  Windows, ShellAPI,
  {$ENDIF}
  Qt, QGraphics, QControls, QForms, QExtCtrls, QStdCtrls, QDialogs;

type
  TfmAbout = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    Memo1: TMemo;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Label4Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
  end;

procedure ShowAboutDlg(AParentWnd: QWidgetH);

implementation

{$R *.xfm}

procedure ShowAboutDlg(AParentWnd: QWidgetH);
var
  fm: TfmAbout;
begin
  fm := TfmAbout.CreateParented(AParentWnd);
  try
    fm.ShowModal;
  finally
    fm.Free;
  end;
end;

procedure TfmAbout.Label4Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  ShellExecute(GetDesktopWindow(), nil, 'http://www.shtrih-m.ru',
    nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfmAbout.Label6Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  ShellExecute(GetDesktopWindow(), nil, 'mailto:info@shtrih-m.ru',
    nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfmAbout.Label8Click(Sender: TObject);
begin
  {$IFDEF MSWINDOWS}
  ShellExecute(GetDesktopWindow(), nil,'mailto:support@shtrih-m.ru',
    nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

end.
