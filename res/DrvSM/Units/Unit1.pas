unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, ActiveX, OleCtnrs, Connect, ComObj, ExtCtrls,
  StdCtrls, Registry, {downlevel,} Math, ComCtrls, NMUDP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ippage:IPropertyPage;
  end;

var     p: PUnknownList;
       LDChanged:boolean;

procedure ShowForm(a: IDispatch; var b:boolean);

implementation
{$R *.DFM}

procedure ShowForm(a: IDispatch; var b:boolean);
begin
  new(p);
  p[0]:=a;
  with Tform1.Create(nil) do
    try
      LDChanged:=false;
      ShowModal;
    finally
      Dispose(p);
      Free;
    end;
  b:=LDChanged;
end;

procedure TForm1.FormCreate(Sender: TObject);
var r:TRect;
    pageInfo:TPropPageInfo;
const
  MGU : TGUID = '{B1EB82F2-1AF7-4F23-AEF0-8563DD05C08C}';
begin
  ippage:=CreateComObject(Class_frmConnectLP) as IPropertyPage;
  ippage.GetPageInfo(pageInfo);
  r.Left:=0;
  r.Top:=0;
  r.Right:=pageInfo.size.cx;
  r.Bottom:=pageInfo.size.cy;
  PageControl1.Width:=pageInfo.size.cx+PageControl1.Width-
    TabSheet1.Width;
  PageControl1.Height:=pageInfo.size.cy+PageControl1.Height-
    TabSheet1.Height-24;
  ClientWidth:=PageControl1.Width+16;
  ClientHeight:=PageControl1.Height+Panel1.Height+4;
  TabSheet1.Caption:=pageinfo.pszTitle;
  ippage.Activate(TabSheet1.Handle,r,false);
  ippage.SetObjects(1,p);
  ippage.Show(1);
  // application position
  if (Screen.Width=2048) and (Screen.Height=768) then begin
    Left:=(1024 - Width) div 2;
    Top:=(768 - Height) div 2;
  end
  else begin
    Left:=(Screen.Width - Width) div 2;
    Top:=(Screen.Height - Height) div 2;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LDChanged:=true;
  ippage.Apply;
  close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  LDChanged:=true;
  ippage.Apply
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ippage.Deactivate;
  ippage:=nil;
end;

end.







