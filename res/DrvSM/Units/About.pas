unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, ExtCtrls, StdCtrls, ShellApi, registry, Dialogs,
  SMConsts;

type
  TfrmAbout = class(TForm)
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  end;

procedure ShowFormAbout;

implementation

//uses DownLevel;

{$R *.DFM}

procedure GetFileVersion(FileName: string; var Major1, Major2,
    Minor1, Minor2: Integer);
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  InfoSize := GetFileVersionInfoSize(PChar(FileName), Tmp);
  if InfoSize = 0 then
    //Файл не содержит информации о версии
  else
  begin
    GetMem(Info, InfoSize);
    try
      GetFileVersionInfo(PChar(FileName), 0, InfoSize, Info);
      VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
      Major1 := FileInfo.dwFileVersionMS shr 16;
      Major2 := FileInfo.dwFileVersionMS and $FFFF;
      Minor1 := FileInfo.dwFileVersionLS shr 16;
      Minor2 := FileInfo.dwFileVersionLS and $FFFF;
    finally
      FreeMem(Info, FileInfoSize);
    end;
  end;
end;

procedure ShowFormAbout;
begin
  with TfrmAbout.Create(nil) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TfrmAbout.Label4Click(Sender: TObject);
begin
  ShellExecute(Handle,nil,'http://www.shtrih-m.ru',nil,nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.Label6Click(Sender: TObject);
begin
  ShellExecute(Handle,nil,'mailto:info@shtrih-m.ru',nil,nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.Label8Click(Sender: TObject);
begin
  ShellExecute(Handle,nil,'mailto:support@shtrih-m.ru',nil,nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
var Major1,Major2,Minor1,Minor2:integer;
    FileName,s:string;
    Reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_CLASSES_ROOT;
  if Reg.OpenKey('\AddIn.DrvSM\CLSID',false) then begin
    s:=Reg.ReadString('');
    Reg.RootKey:=HKEY_CLASSES_ROOT;
    if Reg.OpenKey('\CLSID\'+s+'\InprocServer32',false) then begin
      FileName:=Reg.ReadString('');
    end
  end;
  GetFileVersion(FileName,Major1,Major2,Minor1,Minor2);
  label9.Caption:=Format(stVersion,[Major2,Minor1,Minor2]);
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

end.
