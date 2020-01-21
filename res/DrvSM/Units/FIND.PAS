unit find;

interface

uses
  Classes, SysUtils, Windows, ComCtrls, Dialogs, SMConsts;

type
  TFindDevice = class(TThread)
  private
    comn,bd:integer;
    name:string;
    li:TListItem;
    procedure Update1;
  protected
    procedure Execute; override;
  public
    lw:TListView;
    FLP: OleVariant;
  end;

implementation

uses showresfind, SMType;

{ FindDevice }

procedure TFindDevice.Update1;
begin
  if Terminated and (name=stSearching) then
    name:=stSearchBreaken;
  if bd=0 then begin
    li:=lw.Items.Add;
    li.Caption:=Format(stCOM,[comn]);
  end;
  with li do begin
    SubItems.Clear;
    SubItems.Add(strBaudRates[bd]);
    SubItems.Add(name);
  end;
end;

procedure TFindDevice.Execute;
var i,j:integer;
begin
  FLP.Timeout:=50;
  for i:=1 to 32 do begin
    If Terminated Then break;
    FLP.ComNumber:=i;
    for j:=0 to 6 do begin
      If Terminated Then break;
      FLP.BaudRate:=j;
      comn:=i;
      bd:=j;
      If j=6 Then name:=stNotFound
        else name:=stSearching;
      FLP.Connect;
      If FLP.ResultCode=0 Then begin
        name:=FLP.UDescription;
        Synchronize(Update1);
        break;
      end
      else
        If FLP.ResultCode>0 Then begin
          name:='';
        end
        else
          If (FLP.ResultCode=-2) or (FLP.ResultCode=-3) Then begin
            break;
          end;
      Synchronize(Update1);
    end;
  end;
  FLP.Disconnect;
end;

end.

