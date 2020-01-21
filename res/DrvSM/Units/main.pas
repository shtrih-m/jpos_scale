unit main;

interface

uses
  ComObj, ActiveX, AddIn_TLB, StdVcl, axctrls, Forms, classes,
  Windows, SMType, Registry, Sysutils, Dialogs, CommUnit, SMConsts;

type
  TDrvSM = class(TActiveXControl, IDrvSM, IDrvSM2, IDrvSM3, IDrvSM4, IDrvSM5, IDrvSM6)
  private
    FConnected:boolean;
    FFileVersionLS: LongWord;
    FFileVersionMS: LongWord;
    FInput:WideString;
    FOutput:WideString;
    FError:integer;
    FErrorDescription:WideString;

    FDeviceType:TDeviceType;
    FBaudRate:integer;
    FComNumber:integer;
    FTimeOut:word;
    FPortNumber: integer;
    FPassword:LongWord;
    FNewPassword:LongWord;
    FKey:byte;
    FKeyboardMode:byte;
    FMode:byte;
    FTare:smallint;
    FWeightDeviceMode: word;
    FWeight:integer;
    FFixedPointStatus: byte;
    FADCValue: longword;
    FDegrees: array[0..255] of integer;
    FChannel: TChannel;

    FPointNumber: byte;
    FChannelsCount: byte;
    FChannelNumber: byte;
    FCalibrationWeight: integer;
    FChannelON: boolean;
    FTestData: string;

    FVoltage5: word;
    FVoltage12: word;
    FVoltageX: word;
    FVoltageFlags: byte;
    FVoltageX1: byte;

    FCurLD:integer;
    FLDName: WideString;
    FLDComNumber: Byte;
    FLDBaudrate: Byte;
    FLDIndex: Integer;
    FLDUNumber: Cardinal;
    FLDCount: Cardinal;
    FLDTimeout: byte;

    FPrice: integer;
    FCost:  integer;
    FGoodType: byte;
    FLastKey:  byte;
    FQuantity: byte;
    FDeviceCRC: word;

    isErrorParam: boolean;
    FComm:TCommSM;
    List:TList;
    SM:OleVariant;
    dSM:IDispatch;
    act_ch: integer; // active channel
    function GetStringPassword(password: Cardinal): string;
    procedure SaveLD;
    procedure DecodeAnswer(str:string);
    procedure LoadDefaultParam;
    procedure InitProperties;
    function exp(AValue: Shortint): double;
    {$IFDEF TEST}
    function ReadTestData(var testError, testWeight, testTare, testFlags: integer): boolean;
    {$ENDIF}
  public
    procedure Initialize;override;
    destructor Destroy;override;
  protected         
    function Connect: Integer; safecall;
    function Get_Connected: WordBool; safecall;
    function Get_FileVersionLS: Integer; safecall;
    function Get_FileVersionMS: Integer; safecall;
    function Get_LDBaudRate: Integer; safecall;
    function Get_LDComNumber: Integer; safecall;
    function Get_LDIndex: Integer; safecall;
    function Get_LDName: WideString; safecall;
    function Get_LDNumber: Integer; safecall;
    function Get_LDTimeout: Integer; safecall;
    function Get_ResultCode: Integer; safecall;
    function Get_ResultCodeDescription: WideString; safecall;
    function AddLD: Integer; safecall;
    function DeleteLD: Integer; safecall;
    function Disconnect: Integer; safecall;
    function EnumLD: Integer; safecall;
    function GetActiveLD: Integer; safecall;
    function GetCountLD: Integer; safecall;
    function GetParamLD: Integer; safecall;
    procedure Set_LDBaudRate(Value: Integer); safecall;
    procedure Set_LDComNumber(Value: Integer); safecall;
    procedure Set_LDIndex(Value: Integer); safecall;
    procedure Set_LDName(const Value: WideString); safecall;
    procedure Set_LDNumber(Value: Integer); safecall;
    procedure Set_LDTimeout(Value: Integer); safecall;
    function SetActiveLD: Integer; safecall;
    function SetParamLD: Integer; safecall;
    function ShowProperties: Integer; safecall;
    function GetDeviceMetrics: Integer; safecall;
    function Get_UCodePage: Integer; safecall;
    function Get_UDescription: WideString; safecall;
    function Get_UMajorProtocolVersion: Integer; safecall;
    function Get_UMajorType: Integer; safecall;
    function Get_UMinorProtocolVersion: Integer; safecall;
    function Get_UMinorType: Integer; safecall;
    function Get_UModel: Integer; safecall;
    function Get_BaudRate: Integer; safecall;
    function Get_ComNumber: Integer; safecall;
    function Get_LockKeyboardON: WordBool; safecall;
    function Get_Mode: Integer; safecall;
    function Get_Password: Integer; safecall;
    function Get_Tare: Double; safecall;
    function Get_Timeout: Integer; safecall;
    function Get_Weight: Double; safecall;
    function Get_WeightChannelMode: Integer; safecall;
    function Get_ChannelMaxWeight: Double; safecall;
    function GetExchangeParam: Integer; safecall;
    function GetFixedPoint: Integer; safecall;
    function GetCalibrationStatus: Integer; safecall;
    function GetMode: Integer; safecall;
    function GetChannelStatus: Integer; safecall;
    function BreakCalibration: Integer; safecall;
    function KeyEmulation: Integer; safecall;
    procedure Set_BaudRate(Value: Integer); safecall;
    procedure Set_ComNumber(Value: Integer); safecall;
    procedure Set_Key(Value: Integer); safecall;
    procedure Set_LockKeyboardON(Value: WordBool); safecall;
    procedure Set_Mode(Value: Integer); safecall;
    procedure Set_NewPassword(Value: Integer); safecall;
    procedure Set_Password(Value: Integer); safecall;
    procedure Set_Tare(Value: Double); safecall;
    procedure Set_Timeout(Value: Integer); safecall;
    procedure Set_WeightChannelMode(Value: Integer); safecall;
    procedure Set_ChannelMaxWeight(Value: Double); safecall;
    function SetExchangeParam: Integer; safecall;
    function SetFixedPoint: Integer; safecall;
    function SetMode: Integer; safecall;
    function SetPassword: Integer; safecall;
    function SetTare: Integer; safecall;
    function SetTareValue: Integer; safecall;
    function SetZero: Integer; safecall;
    function StartCalibration: Integer; safecall;
    function Get_FixedPointStatus: Integer; safecall;
    function LockKeyboard: Integer; safecall;
    function Get_Input: WideString; safecall;
    function Get_Output: WideString; safecall;
    function Get_LDCount: Integer; safecall;
    function Get_ADCValue: Integer; safecall;
    function GetADCValue: Integer; safecall;
    function SetChannelMode: Integer; safecall;
    function GetChannelsCount: Integer; safecall;
    function GetChannelParam: Integer; safecall;
    function SetActiveChannel: Integer; safecall;
    function SetChannelParam: Integer; safecall;
    function Reset: Integer; safecall;
    function RestartChannel: Integer; safecall;
    function GetActiveChannel: Integer; safecall;
    function Get_ChannelDegree: Integer; safecall;
    function Get_ChannelDiscreteness1: Double; safecall;
    function Get_ChannelDiscreteness2: Double; safecall;
    function Get_ChannelDiscreteness3: Double; safecall;
    function Get_ChannelDiscreteness4: Double; safecall;
    function Get_ChannelFlags: Integer; safecall;
    function Get_ChannelMaxTare: Double; safecall;
    function Get_ChannelMinWeight: Double; safecall;
    function Get_ChannelNumber: Integer; safecall;
    function Get_ChannelON: WordBool; safecall;
    function Get_ChannelPointsCount: Integer; safecall;
    function Get_ChannelRange1: Double; safecall;
    function Get_ChannelRange2: Double; safecall;
    function Get_ChannelRange3: Double; safecall;
    function Get_ChannelsCount: Integer; safecall;
    function Get_CalibrationWeight: Double; safecall;
    function Get_PointNumber: Integer; safecall;
    procedure Set_ChannelDegree(Value: Integer); safecall;
    procedure Set_ChannelDiscreteness1(Value: Double); safecall;
    procedure Set_ChannelDiscreteness2(Value: Double); safecall;
    procedure Set_ChannelDiscreteness3(Value: Double); safecall;
    procedure Set_ChannelDiscreteness4(Value: Double); safecall;
    procedure Set_ChannelFlags(Value: Integer); safecall;
    procedure Set_ChannelMaxTare(Value: Double); safecall;
    procedure Set_ChannelMinWeight(Value: Double); safecall;
    procedure Set_ChannelNumber(Value: Integer); safecall;
    procedure Set_ChannelON(Value: WordBool); safecall;
    procedure Set_ChannelPointsCount(Value: Integer); safecall;
    procedure Set_ChannelRange1(Value: Double); safecall;
    procedure Set_ChannelRange2(Value: Double); safecall;
    procedure Set_ChannelRange3(Value: Double); safecall;
    procedure Set_CalibrationWeight(Value: Double); safecall;
    procedure Set_PointNumber(Value: Integer); safecall;
    function TestClr: Integer; safecall;
    function TestGet: Integer; safecall;
    function Get_TestData: WideString; safecall;
    function GetVoltage: Integer; safecall;
    function Get_Voltage12: Integer; safecall;
    function Get_Voltage5: Integer; safecall;
    function Get_VoltageFlags: Integer; safecall;
    function Get_VoltageX: Integer; safecall;
    function Get_VoltageX1: Integer; safecall;
    function GetChannelStatusEx: Integer; safecall;
    function Get_Cost: Currency; safecall;
    function Get_GoodType: Integer; safecall;
    function Get_LastKey: Integer; safecall;
    function Get_Price: Currency; safecall;
    function Get_Quantity: Integer; safecall;
    function SetGoodData: Integer; safecall;
    procedure Set_GoodType(Value: Integer); safecall;
    procedure Set_LastKey(Value: Integer); safecall;
    procedure Set_Price(Value: Currency); safecall;
    procedure Set_Quantity(Value: Integer); safecall;
    function Get_CalibrationsCount: Integer; safecall;
    function Get_DeviceCRC: Integer; safecall;
    function GetDeviceCRC: Integer; safecall;
    function Get_PortNumber: Integer; safecall;
    procedure Set_PortNumber(Value: Integer); safecall;
  end;

implementation

uses ComServ, unit1;

procedure TDrvSM.Initialize;
var Reg:TRegistry;
    e,eld:boolean;
    list1:TStringList;
    i:integer;
    p:PLDRec;

  procedure GetFileVersion(var ms, ls: dword);
    var
      Info: Pointer;
      InfoSize: DWORD;
      FileInfo: PVSFixedFileInfo;
      FileInfoSize: DWORD;
      Tmp: DWORD;
      Reg: TRegistry;
      FileName:string;
    begin
      Reg:=TRegistry.Create;
      Reg.RootKey:=HKEY_CLASSES_ROOT;
      if Reg.OpenKey('\AddIn.DrvSM\CLSID',false) then begin
        FileName:=Reg.ReadString('');
        Reg.RootKey:=HKEY_CLASSES_ROOT;
        if Reg.OpenKey('\CLSID\'+FileName+'\InprocServer32',false) then begin
          FileName:=Reg.ReadString('');
        end
      end;
      InfoSize := GetFileVersionInfoSize(PChar(FileName), Tmp);
      if InfoSize = 0 then
        //Файл не содержит информации о версии
      else
      begin
        GetMem(Info, InfoSize);
        try
          GetFileVersionInfo(PChar(FileName), 0, InfoSize, Info);
          VerQueryValue(Info, '\', Pointer(FileInfo), FileInfoSize);
          ms := FileInfo.dwFileVersionMS;
          ls := FileInfo.dwFileVersionLS;
        finally
          FreeMem(Info, FileInfoSize);
        end;
      end;
    end;
begin
  inherited Initialize;
  FComm:=TCommSM.Create;
  InitProperties;
  GetFileVersion(FFileVersionMS, FFileVersionLS);
  eld:=false;
//создаем список логических устройств
  List:=TList.Create;
  Reg:=TRegistry.Create;
  try
    if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices',false) then
    begin
      if Reg.HasSubKeys then begin
        list1:=TStringList.Create;
        Reg.GetKeyNames(list1);
        for i:=0 to list1.Count-1 do begin
          if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices\'+list1.Strings[i],false) then begin
            new(p);

            try
              p.Name:=Reg.ReadString('Name');
            except
              p.Name:=Format(stLDName,[i]);
              eld:=true;
            end;

            try
              p.ComNumber:=Reg.ReadInteger('ComNumber');
            except
              p.ComNumber:=1;
              eld:=true;
            end;
            if (p.ComNumber<1) or (p.ComNumber>255) then begin
              p.ComNumber:=1;
              eld:=true;
            end;

            try
              p.BaudRate:=Reg.ReadInteger('BaudRate');
            except
              p.BaudRate:=2;
              eld:=true;
            end;
            if (p.BaudRate<0) or (p.BaudRate>6) then begin
              p.BaudRate:=2;
              eld:=true;
            end;

            try
              p.UNumber:=Reg.ReadInteger('Number');
            except
              eld:=true;
              continue;
            end;

            try
              p.Timeout:=Reg.ReadInteger('Timeout');
            except
              p.Timeout:=150;
              eld:=true;
            end;
            if (p.Timeout<1) or (p.Timeout>256) then begin
              p.Timeout:=150;
              eld:=true;
            end;

            if p.UNumber<>4294967295 then
            List.Add(p);
          end;
        end;
        list1.Free;
      end;
    end;
  finally
    Reg.Free;
  end;
  If list.Count=0 Then begin
    new(p);
    p.Name:=Format(stLDName,[1]);
    p.ComNumber:=1;
    p.BaudRate:=2;
    p.UNumber:=1;
    p.Timeout:=150;
    List.Add(p);
    FCurLD:=-1;
  End;
  e:=false;
  Reg:=TRegistry.Create;
  try
    try
      if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Param',false) then begin
        FBaudRate:=Reg.ReadInteger('Baudrate');
        FComNumber:=Reg.ReadInteger('ComNumber');
        FTimeout:=Reg.ReadInteger('Timeout');
        if FTimeout=0 then FTimeout:=256;
        FCurLD:=Reg.ReadInteger('CurrentDevice');
      end
      else LoadDefaultParam;
    except
      on ERegistryException do e:=true;
    end;
  finally
    Reg.Free;
  end;

  if (FCurLD<-1) or (FCurLD>List.Count-1) then begin
    e:=true;
    FCurLD:=-1;
  end;
  if FCurLD>=0 then begin
    FLDIndex:=FCurLD;
    enumLD;
    if SetActiveLD<>0 then eld:=true;
  end;
  if (FBaudRate<0) or (FBaudRate>6) then begin
    e:=true;
    FBaudRate:=2;
  end;
  if (FComNumber<1) or (FComNumber>255) then begin
    e:=true;
    FComNumber:=1;
  end;
  if (FTimeout<1) or (FTimeout>256) then begin
    e:=true;
    FTimeout:=150;
  end;
  if e and eld then begin
    LoadDefaultParam;
    ShowMessage(stLoadErr);
  end
  else begin
    if e then begin
      LoadDefaultParam;
      ShowMessage(stLoadErr2);
    end;
    if eld then
      ShowMessage(stLoadErr1);
  end;
  Reg:=TRegistry.Create;
  try
    if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Param',true) then begin
      Reg.WriteInteger('Baudrate',FBaudRate);
      Reg.WriteInteger('ComNumber',FComNumber);
      Reg.WriteInteger('Timeout',FTimeout);
      Reg.WriteInteger('CurrentDevice',FCurLD);
    end;
  finally
    Reg.Free;
  end;

  Reg:=TRegistry.Create;
  try
    if not Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices',false) then
    begin
      if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices\0',true) then begin
         Reg.WriteString('Name',Format(stLDName,[1]));
         reg.WriteInteger('ComNumber',1);
         reg.WriteInteger('Baudrate',2);
         reg.WriteInteger('Number',0);
         reg.WriteInteger('Timeout',200);
      end;
    end;
  finally
    Reg.Free;
  end;
end;

destructor TDrvSM.Destroy;
var Reg:TRegistry;
    i:integer;
begin
  Reg:=TRegistry.Create;
  try
    if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Param',true) then begin
      Reg.WriteInteger('Baudrate',FBaudRate);
      Reg.WriteInteger('ComNumber',FComNumber);
      Reg.WriteInteger('Timeout',FTimeout);
      Reg.WriteInteger('CurrentDevice',FCurLD);
    end;
  finally
    Reg.Free;
  end;
//пишем в реестр параметры ЛУ и освобождаем память
  Reg:=TRegistry.Create;
  try
    Reg.DeleteKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices');
    if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices',true) then
    begin
      If List<>nil Then Begin
        for i:=0 to List.Count-1 do begin
          if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices\'+IntToSTr(i),true) then begin
             Reg.WriteString('Name',PLDRec(List[i]).Name);
             reg.WriteInteger('ComNumber',PLDRec(List[i]).ComNumber);
             reg.WriteInteger('Baudrate',PLDRec(List[i]).BaudRate);
             reg.WriteInteger('Number',PLDRec(List[i]).UNumber);
             reg.WriteInteger('Timeout',PLDRec(List[i]).Timeout);
          end;
        end;
      End;
    end;
  finally
    Reg.Free;
  end;
//
  if List<>nil then Begin
    for i:=0 to List.Count-1 do
      Dispose(PLDRec(List.Items[i]));
    List.Free;
    List:=nil;
  End;

  FComm.CloseCom;
  FComm.Free;
  inherited;
end;

procedure TDrvSM.LoadDefaultParam;
begin
  FCurLD:=0;
  FBaudRate:=2;
  FComNumber:=1;
  FTimeout:=150;
  FPortNumber:=0;
end;

procedure TDrvSM.InitProperties;
begin
  LoadDefaultParam;
  isErrorParam:=false;
  FConnected:=false;
  FFileVersionLS:=0;
  FFileVersionMS:=0;
  FInput:='';
  FOutput:='';
  FError:=0;
  FErrorDescription:=erDescr0;
  FDeviceType.UMajorType:=0;
    FDeviceType.UMinorType:=0;
    FDeviceType.UMajorProtocol:=0;
    FDeviceType.UMinorProtocol:=0;
    FDeviceType.UModel:=0;
    FDeviceType.UCodePage:=0;
    FillChar(FDeviceType.UDescription,SizeOf(FDeviceType.UDescription),#$0);
  FPassword:=30;
  FNewPassword:=0;
  FKey:=0;
  FKeyboardMode:=0;
  FMode:=0;
  FTare:=0;
  FWeightDeviceMode:=0;
  FWeight:=0;
  FFixedPointStatus:=0;
  FADCValue:=0;

  FPointNumber:=0;
  FChannelsCount:=0;
  FChannelNumber:=0;
  FCalibrationWeight:=0;
  FChannelON:=true;

  act_ch:=0;
  FillChar(FDegrees[0],256,0);
  with FChannel do begin
    Flags:=0;
    PointPosition:=0;
    Stepen:=0;
    MaxWeight:=0;
    MinWeight:=0;
    MaxTare:=0;
    Range1:=0;
    Range2:=0;
    Range3:=0;
    Discreteness1:=0;
    Discreteness2:=0;
    Discreteness3:=0;
    Discreteness4:=0;
    PointsCount:=0;
    CalibrationsCount:=0;
  end;
  FVoltage5:=0;
  FVoltage12:=0;
  FVoltageX:=0;
  FVoltageX1:=0;
  FVoltageFlags:=0;

  FLDName:='';
  FLDComNumber:=1;
  FLDBaudrate:=2;
  FLDIndex:=0;
  FLDUNumber:=0;
  FLDCount:=0;
  FLDTimeout:=150;

  FPrice:=0;
  FCost:=0;
  FGoodType:=0;
  FLastKey:=0;
  FQuantity:=0;
end;

procedure TDrvSM.SaveLD;
var Reg: TRegistry;
  i: integer;
begin
  Reg:=TRegistry.Create;
  try
    Reg.DeleteKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices');
    if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices',true) then
    begin
      If List<>nil Then Begin
        for i:=0 to List.Count-1 do begin
          if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Logical Devices\'+IntToSTr(i),true) then begin
             Reg.WriteString('Name',PLDRec(List[i]).Name);
             reg.WriteInteger('ComNumber',PLDRec(List[i]).ComNumber);
             reg.WriteInteger('Baudrate',PLDRec(List[i]).BaudRate);
             reg.WriteInteger('Number',PLDRec(List[i]).UNumber);
             reg.WriteInteger('Timeout',PLDRec(List[i]).Timeout);
          end;
        end;
      End;
    end;
  finally
    Reg.Free;
  end;
end;

function TDrvSM.GetStringPassword(password: Cardinal): string;
var s,str:string;
    i:integer;
begin
  s:=IntToStr(password);
  str:='';
  for i:=1 to 4-Length(s) do str:=str+'0';
  Result:=str+s;
end;

//-----------------------------------------------------------

{$IFDEF TEST}
function TDrvSM.ReadTestData(var testError, testWeight, testTare, testFlags: integer): boolean;
var Reg: TRegistry;
    i: integer;
    testflag: array[0..7] of boolean;
begin
  testError:=1000;
  Reg:=TRegistry.Create;
  try
    if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\test',false) then begin
      for i:=0 to 7 do testflag[i] := Reg.ReadBool('bit'+chr(ord('0')+i));
      testWeight := Reg.ReadInteger('Weight');
      testTare   := Reg.ReadInteger('Tare');
      try
        testError  := StrToInt(Reg.ReadString('Error'));
      except
        testError  := 0;
      end;
    end;
  finally
    Reg.Free;
  end;
  testFlags:=0;
  for i:=0 to 7 do
    if testflag[i] then testFlags:=testFlags or (1 shl i);
  Result:=(testerror<1000);
end;
{$ENDIF}


function TDrvSM.Connect: Integer;
var e: integer;
    i: integer;
    {$IFDEF TEST}
    te,tw,tt,tf: integer;
    {$ENDIF}
begin
  {$IFDEF TEST}
  if ReadTestData(te,tw,tt,tf) then begin
    FError:=te;
    FWeight:=tw;
    FTare:=tt;
    FWeightDeviceMode:=tf;
    FConnected:=true;
    FDegrees[0]:=-3;
    exit;
  end;
  {$ENDIF}

  FComm.CorrectDevice:=true;
  FComm.BaudRate:=FBaudRate;
  FComm.ComNumber:=FComNumber;
  FComm.TimeOut:=FTimeOut;

  e:=FComm.OpenCom;
  if e=0 then begin
    FConnected:=true;
    FError:=GetDeviceMetrics;
    if FError<>0 then begin e:=-1; Disconnect end;
  end;
  if (e=0) and (FDeviceType.UMajorType=1) and (FDeviceType.UMinorType=3) then begin
    FError:=GetChannelsCount;
    if (FError<>0) or (FChannelsCount<1) then begin e:=-1; Disconnect end;
    if e=0 then begin
      FError:=GetActiveChannel;
      if (FError<>0) or (FChannelNumber<0) or (FChannelNumber>FChannelsCount-1) then begin
        e:=-1;
        Disconnect;
      end
      else act_ch:=FChannelNumber;
    end;
    if e=0 then
      for i:=0 to FChannelsCount-1 do begin
        FChannelNumber:=i;
        FError:=GetChannelParam;
        if FError<>0 then begin e:=-1; Disconnect; break; end;
        FDegrees[i]:=FChannel.Stepen;
      end;
  end
  else if (e=0) and ((FDeviceType.UMajorType<>1) or (FDeviceType.UMinorType<>3)) then
        FComm.CorrectDevice:=false;
  FError:=e;

  if FCurLD>=0 then begin
    FLDIndex:=FCurLD;
    EnumLD;
    if (FComNumber<>FLDComNumber) or
       (FBaudRate<>FLDBaudRate) or
       (FTimeout<>FLDTimeout)
       then FCurLD:=-1;
  end;

  FError:=e;
  FInput:='';
  FOutput:='';
  FConnected:= (FError=0);
  Result:=FError;
end;

function TDrvSM.Get_Connected: WordBool;
begin
  Result:=FConnected;
end;

function TDrvSM.Get_FileVersionLS: Integer;
begin
  Result:=FFileVersionLS;
end;

function TDrvSM.Get_FileVersionMS: Integer;
begin
  Result:=FFileVersionMS;
end;

function TDrvSM.Get_LDBaudRate: Integer;
begin
  Result:=FLDBaudrate;
end;

function TDrvSM.Get_LDComNumber: Integer;
begin
  Result:=FLDComNumber;
end;

function TDrvSM.Get_LDIndex: Integer;
begin
  Result:=FLDIndex;
end;

function TDrvSM.Get_LDName: WideString;
begin
  Result:=FLDName;
end;

function TDrvSM.Get_LDNumber: Integer;
begin
  Result:=FLDUNumber;
end;

function TDrvSM.Get_LDTimeout: Integer;
begin
  Result:=FLDTimeout;
end;

function TDrvSM.Get_ResultCode: Integer;
begin
  Result:=FError;
end;

function TDrvSM.Get_ResultCodeDescription: WideString;
begin
  case FError of
    -20: FErrorDescription := erDescr_20;
    -18: FErrorDescription := erDescr_18;
    -16: FErrorDescription := erDescr_16;
    -15: FErrorDescription := erDescr_15;
    -14: FErrorDescription := erDescr_14;
    -10: FErrorDescription := erDescr_10;
    -9: FErrorDescription := erDescr_9;
    -8: FErrorDescription := erDescr_8;
    -7: FErrorDescription := erDescr_7;
    -3: FErrorDescription := erDescr_3;
    -2: FErrorDescription := erDescr_2;
    -1: FErrorDescription := erDescr_1;
    0: FErrorDescription := erDescr0;
    17: FErrorDescription := erDescr17;
    120: FErrorDescription := erDescr120;
    121: FErrorDescription := erDescr121;
    122: FErrorDescription := erDescr122;
    123: FErrorDescription := erDescr123;
    124: FErrorDescription := erDescr124;
    150: FErrorDescription := erDescr150;
    151: FErrorDescription := erDescr151;
    152: FErrorDescription := erDescr152;
    166: FErrorDescription := erDescr166;
    167: FErrorDescription := erDescr167;
    170: FErrorDescription := erDescr170;
    180: FErrorDescription := erDescr180;
    181: FErrorDescription := erDescr181;
    182: FErrorDescription := erDescr182;
    183: FErrorDescription := erDescr183;
    184: FErrorDescription := erDescr184;
    185: FErrorDescription := erDescr185;
  end;
  Result:=FErrorDescription;
end;

function TDrvSM.AddLD: Integer;
var p:PLDRec;
    i: integer;
    minUnUsedNum: Cardinal;
    a: Array Of boolean;
    sizeA: Cardinal;
    num:Cardinal;
begin
  sizeA:=List.Count+1;
  SetLength(a,sizeA);
  FillChar(a[0],sizeA,FALSE);
  For I:=0 to List.Count-1 Do begin
    num:=PLDRec(List.Items[I]).UNumber;
    If num<sizeA Then begin
      a[num-1]:=TRUE;
    End;
  End;
  minUnUsedNum:=1;
  For I:=0 To sizeA-1 Do
    If Not a[i] Then Begin
      minUnUsedNum:=I+1;
      Break;
    End;
  new(p);
  p.Name:=FLDName;
  p.ComNumber:=FLDComNumber;
  p.BaudRate:=FLDBaudRate;
  p.UNumber:=minUnUsedNum;
  p.Timeout:=FLDTimeout;
  List.Add(p);
  FLDUNumber:=minUnUsedNum;
  Result:=0;
  Setlength(a,0);
end;

function TDrvSM.DeleteLD: Integer;
Var I,ind: Integer;
    f: Boolean;
begin
  f:=FALSE;
  ind:=0;
  For i:=0 To List.Count-1 Do
    If FLDUNumber=PLDRec(List[I]).UNumber Then Begin
      f:=TRUE;
      ind:=I;
      Break;
    End;
  If F Then Begin
    If (List.Count=1) or (ind=FCurLD) Then FError:=-14
    Else Begin
      Dispose(PLDRec(List[ind]));
      List.Delete(ind);
      If FCurLD>ind Then Dec(FCurLD);
      FError:=0;
    End;
  End
  Else FError:=-10;
  Result:=FError;
end;

function TDrvSM.Disconnect: Integer;
begin
  FComm.CloseCom;
  FConnected:=false;
  FError:=0;
  FInput:='';
  FOutput:='';
  Result:=FError;
end;

function TDrvSM.EnumLD: Integer;
begin
  If (FLDIndex<0)and(FLDIndex>=List.Count) Then
    FError:=-10
  Else Begin
    FLDName:=PLDRec(List.Items[FLDIndex]).Name;
    FLDComNumber:=PLDRec(List.Items[FLDIndex]).ComNumber;
    FLDBaudrate:=PLDRec(List.Items[FLDIndex]).Baudrate;
    FLDUNumber:=PLDRec(List.Items[FLDIndex]).UNumber;
    FLDTimeout:=PLDRec(List.Items[FLDIndex]).Timeout;
    FError:=0;
  End;
  result:=FError;
end;

function TDrvSM.GetActiveLD: Integer;
begin
  if FCurLD>=0 then begin
    FError:=0;
    FLDIndex:=FCurLD;
    If List.Count<>0 Then
      FLDUNumber:=PLDRec(List.items[FCurLD]).UNumber;
  end
  else FError:=-16;
  Result:=FError;
end;

function TDrvSM.GetCountLD: Integer;
begin
  FLDCount:=List.Count;
  Result:=0;
  FError:=0;
end;

function TDrvSM.GetParamLD: Integer;
Var I,ind: Integer;
    f: Boolean;
begin
  f:=FALSE;
  ind:=0;
  For i:=0 To List.Count-1 Do
    If FLDUNumber=PLDRec(List[I]).UNumber Then Begin
      f:=TRUE;
      ind:=I;
      Break;
    End;
  If F Then Begin
    FLDName:=PLDRec(List[ind]).Name;
    FLDComNumber:=PLDRec(List[ind]).ComNumber;
    FLDBaudRate:=PLDRec(List[ind]).BaudRate;
    FLDTimeout:=PLDRec(List[ind]).Timeout;
    FError:=0;
  End
  Else FError:=-10;
  Result:=FError;
end;

procedure TDrvSM.Set_LDBaudRate(Value: Integer);
begin
  If Value in [0..6] Then FLDBaudrate:=Value
  else isErrorParam:=true;
end;

procedure TDrvSM.Set_LDComNumber(Value: Integer);
begin
  If Value in [1..255] Then FLDComNumber:=Value
  else isErrorParam:=true;
end;

procedure TDrvSM.Set_LDIndex(Value: Integer);
begin
  FLDIndex:=Value;
end;

procedure TDrvSM.Set_LDName(const Value: WideString);
begin
  FLDName:=Value;
end;

procedure TDrvSM.Set_LDNumber(Value: Integer);
begin
  FLDUNumber:=Value;
end;

procedure TDrvSM.Set_LDTimeout(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then FLDTimeout:=Value
     else isErrorParam:=true;
end;

function TDrvSM.SetActiveLD: Integer;
var
  i:Integer;
  f:boolean;
  ind: Cardinal;
begin
  f:=FALSE;
  ind:=0;
  For i:=0 To List.Count-1 Do
    If FLDUNumber=PLDRec(List[i]).UNumber Then Begin
      f:=TRUE;
      ind:=I;
      Break;
    End;
  if f then begin
    FCurLD:=ind;
    FComNumber:=PLDRec(List[FCurLD]).ComNumber;
    FBaudRate:=PLDRec(List[FCurLD]).BaudRate;
    FTimeout:=PLDRec(List[FCurLD]).Timeout;
    FLDIndex:=ind;
    FError:=0;
  end
  else begin
    FError:=-10;
  end;
  Result:=FError;
end;

function TDrvSM.SetParamLD: Integer;
Var I,ind: Integer;
    f: Boolean;
begin
  f:=FALSE;
  ind:=0;
  For i:=0 To List.Count-1 Do
    If FLDUNumber=PLDRec(List[I]).UNumber Then Begin
      f:=TRUE;
      ind:=I;
      Break;
    End;
  if f then begin
    PLDRec(List[ind]).Name:=FLDName;
    PLDRec(List[ind]).ComNumber:=FLDComNumber;
    PLDRec(List[ind]).BaudRate:=FLDBaudRate;
    PLDRec(List[ind]).Timeout:=FLDTimeout;
    FError:=0;
  end
  else begin
    FError:=-10;
  end;
  Result:=FError;
end;

function TDrvSM.ShowProperties: Integer;
Var I:Integer;
    p:PLDRec;
    b:boolean;
begin
  b:=FConnected;
  Disconnect;
  SaveLD;
  dSM:=CreateComObject(CLASS_DrvSM) as IDispatch;
  SM:=dSM;
  SM.Password:=FPassword;
  SM.ComNumber:=FComNumber;
  SM.Baudrate:=FBaudrate;
  SM.Timeout:=FTimeout;
  SM.PortNumber:=FPortNumber;
  if b then SM.Connect;

  ShowForm(dSM,b);

  FPassword:=SM.Password;
  FTimeout:=SM.Timeout;
  FPortNumber:=SM.PortNumber;
  FComNumber:=SM.ComNumber;
  FBaudRate:=SM.Baudrate;

  if b then begin
    if List<>nil then Begin
      for i:=0 to List.Count-1 do
        Dispose(PLDRec(List.Items[i]));
      List.Free;
      List:=nil;
    End;
    List:=TList.Create;
    SM.GetCountLD;
    For I:=0 To SM.LDCount-1 Do Begin
      SM.LDIndex:=I;
      If SM.EnumLD=0 Then Begin
        new(p);
        p.Name:=SM.LDName;
        p.ComNumber:=SM.LDComNumber;
        p.BaudRate:=SM.LDBaudRate;
        p.UNumber:=SM.LDNumber;
        p.Timeout:=SM.LDTimeout;
        List.Add(p);
      End;
    End;
  end;
  if SM.GetActiveLD=0 then FCurLD:=SM.LDIndex
    else FCurLD:=-1;
  SM.Disconnect;
  SM:=UnAssigned;
  dSM:=Nil;
  SaveLD;
  FError:=Connect;
  result:=FError;
end;

function TDrvSM.GetDeviceMetrics: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$FC;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_UCodePage: Integer;
begin
  Result:=FDeviceType.UCodePage;
end;

function TDrvSM.Get_UDescription: WideString;
begin
  Result:=FDeviceType.UDescription;
end;

function TDrvSM.Get_UMajorProtocolVersion: Integer;
begin
  Result:=FDeviceType.UMajorProtocol;
end;

function TDrvSM.Get_UMajorType: Integer;
begin
  Result:=FDeviceType.UMajorType;
end;

function TDrvSM.Get_UMinorProtocolVersion: Integer;
begin
  Result:=FDeviceType.UMinorProtocol;
end;

function TDrvSM.Get_UMinorType: Integer;
begin
  Result:=FDeviceType.UMinorType;
end;

function TDrvSM.Get_UModel: Integer;
begin
  Result:=FDeviceType.UModel;
end;

function TDrvSM.Get_BaudRate: Integer;
begin
  Result:=FBaudRate;
end;

function TDrvSM.Get_ComNumber: Integer;
begin
  Result:=FComNumber;
end;


function TDrvSM.Get_LockKeyboardON: WordBool;
begin
  Result:=(FKeyboardMode = 1);
end;

function TDrvSM.Get_Mode: Integer;
begin
  Result:=FMode;
end;

function TDrvSM.Get_Password: Integer;
begin
  Result:=FPassword;
end;

function TDrvSM.Get_Tare: Double;
begin
  Result:=exp(FDegrees[act_ch])*integer(FTare);
end;

function TDrvSM.Get_Timeout: Integer;
begin
  if FTimeOut=256 then Result:=0
     else Result:=FTimeOut;
end;

function TDrvSM.Get_Weight: Double;
begin
  Result:=exp(FDegrees[act_ch])*integer(FWeight);
end;

function TDrvSM.Get_WeightChannelMode: Integer;
begin
  Result:=FWeightDeviceMode;
end;

function TDrvSM.Get_ChannelMaxWeight: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.MaxWeight;
end;

function TDrvSM.GetExchangeParam: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$15;
    s:=s+GetStringPassword(FPassword);
    s:=s+#0;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetFixedPoint: Integer;
var s:string;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$71;
    s:=s+GetStringPassword(FPassword);
    p:=@FPointNumber;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetCalibrationStatus: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$73;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetMode: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$12;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetChannelStatus: Integer;
var s:string;
    {$IFDEF TEST}
    te,tw,tt,tf: integer;
    {$ENDIF}
begin
  {$IFDEF TEST}
  if ReadTestData(te,tw,tt,tf) then begin
    FError:=te;
    FWeight:=tw;
    FTare:=tt;
    FWeightDeviceMode:=tf;
    exit;
  end;
  {$ENDIF}

  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$3A;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.BreakCalibration: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$74;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.KeyEmulation: Integer;
var s:string;
    p: ^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$08;
    s:=s+GetStringPassword(FPassword);
    p:=@FKey;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

procedure TDrvSM.Set_BaudRate(Value: Integer);
begin
  if (Value>=0)and(Value<=6) then FBaudRate:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ComNumber(Value: Integer);
begin
  if (Value>=1)and(Value<=255) then FComNumber:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_Key(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then FKey:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_LockKeyboardON(Value: WordBool);
begin
  if Value then FKeyboardMode:=1 else FKeyboardMode:=0;
end;

procedure TDrvSM.Set_Mode(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then FMode:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_NewPassword(Value: Integer);
begin
  if (Value>=0)and(Value<=9999) then FNewPassword:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_Password(Value: Integer);
begin
  if (Value>=0)and(Value<=9999) then FPassword:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_Tare(Value: Double);
begin
  if (Value/exp(FDegrees[act_ch])>=-32768)and(Value/exp(FDegrees[act_ch])<=32768) then
     FTare:=Round(Value/exp(FDegrees[act_ch]))
       else isErrorParam:=True;
end;

procedure TDrvSM.Set_Timeout(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then
      if Value=0 then FTimeOut:=256
              else FTimeOut:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_WeightChannelMode(Value: Integer);
begin
  if (Value>=0)and(Value<=65535) then FWeightDeviceMode:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelMaxWeight(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
     FChannel.MaxWeight:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

function TDrvSM.SetExchangeParam: Integer;
var s:string;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$8#$14;
    s:=s+GetStringPassword(FPassword);
    p:=@FPortNumber;
    s:=s+p^;
    //s:=s+#0;
    p:=@FBaudRate;
    s:=s+p^;
    p:=@FTimeOut;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetFixedPoint: Integer;
var s:string;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$8#$70;
    s:=s+GetStringPassword(FPassword);
    p:=@FPointNumber;
    s:=s+p^;
    p:=@FCalibrationWeight;
    s:=s+p^;
    inc(p);
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetMode: Integer;
var s:string;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$7;
    s:=s+GetStringPassword(FPassword);
    p:=@FMode;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetPassword: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$9#$16;
    s:=s+GetStringPassword(FPassword);
    s:=s+GetStringPassword(FNewPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetTare: Integer;
var s:string;
    {$IFDEF TEST}
    te,tw,tt,tf: integer;
    {$ENDIF}
begin
  {$IFDEF TEST}
  if ReadTestData(te,tw,tt,tf) then begin
    FError:=te;
    FWeight:=tw;
    FTare:=tt;
    FWeightDeviceMode:=tf;
    exit;
  end;
  {$ENDIF}

  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$31;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetTareValue: Integer;
var s:string;
    p:^char;
    {$IFDEF TEST}
    te,tw,tt,tf: integer;
    {$ENDIF}
begin
  {$IFDEF TEST}
  if ReadTestData(te,tw,tt,tf) then begin
    FError:=te;
    FWeight:=tw;
    FTare:=tt;
    FWeightDeviceMode:=tf;
    exit;
  end;
  {$ENDIF}

  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$7#$32;
    s:=s+GetStringPassword(FPassword);
    p:=@FTare;
    s:=s+p^;
    inc(p);
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetZero: Integer;
var s:string;
    {$IFDEF TEST}
    te,tw,tt,tf: integer;
    {$ENDIF}
begin
  {$IFDEF TEST}
  if ReadTestData(te,tw,tt,tf) then begin
    FError:=te;
    FWeight:=tw;
    FTare:=tt;
    FWeightDeviceMode:=tf;
    exit;
  end;
  {$ENDIF}

  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$30;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.StartCalibration: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$72;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_FixedPointStatus: Integer;
begin
  Result:=FFixedPointStatus;
end;

function TDrvSM.LockKeyboard: Integer;
var s:string;
    temp:byte;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$9;
    s:=s+GetStringPassword(FPassword);
    if FKeyboardMode=0 then temp:=0
      else temp:=1;
    p:=@temp;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_Input: WideString;
begin
  Result:=FInput;
end;

function TDrvSM.Get_Output: WideString;
begin
  Result:=FOutput;
end;

function TDrvSM.Get_LDCount: Integer;
begin
  Result:=FLDCount;
end;

function TDrvSM.Get_ADCValue: Integer;
begin
  Result:=FADCValue;
end;

function TDrvSM.GetADCValue: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$75;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetChannelsCount: Integer;
var s: string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$E5;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetChannelParam: Integer;
var s:string;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$2#$E8;
    p:=@FChannelNumber;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetActiveChannel: Integer;
var s:string;
    p:^char;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$E6;
    s:=s+GetStringPassword(FPassword);
    p:=@FChannelNumber;
    s:=s+p^;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.GetActiveChannel: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$EA;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetChannelParam: Integer;
var s:string;
    p:^char;
    i: integer;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1b#$e9;
    s:=s+GetStringPassword(FPassword);
    p:=@FChannelNumber;
    s:=s+p^;
    p:=@FChannel;
    for i:=1 to SizeOf(TChannel)-1 do begin
      s:=s+p^;
      inc(p);
    end;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.SetChannelMode: Integer;
var s: string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$6#$E7;
    s:=s+GetStringPassword(FPassword);
    if FChannelON then s:=s+#1
    else s:=s+#0;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Reset: Integer;
var s: string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$F0;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.RestartChannel: Integer;
var s: string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$EF;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

//-----------------------------------------------------------------

procedure TDrvSM.DecodeAnswer(str: string);
var Reg:TRegistry;
    temp:integer;
    s: string;
    FCom: byte;
begin
  FInput:=FComm.Input;
  FOutput:=FComm.Output;
  if FError=-1 then exit;
  if Length(str)<3 then exit;
  FCom:=ord(str[2]);
  FError:=ord(str[3]);
  FErrorDescription:=Get_ResultCodeDescription;
  s:=copy(str,4,Length(str)-3);
  for temp:=length(str)+1 to 255 do s:=s+#0;
  if FError=0 then
    case FCom of
      $07: begin
      end;
      $08: begin
      end;
      $09: begin
      end;
      $11: begin
        FWeightDeviceMode:=0;
        Move(s[1],FWeightDeviceMode,2);
        FChannelON:=(FWeightDeviceMode and $4) = $4;
        FWeight:=0;
        Move(s[3],FWeight,4);
        FTare:=0;
        Move(s[7],FTare,2);
        Move(s[10],FGoodType,1);
        Move(s[11],FQuantity,1);
        FPrice := 0;
        Move(s[12],FPrice,3);
        FCost := 0;
        Move(s[15],FCost,3);
        Move(s[18],FLastKey,1);
      end;
      $12: begin
        Move(s[1],FMode,1);
      end;
      $14: begin
        FComm.BaudRate:=FBaudRate;
        FComm.TimeOut:=FTimeOut;
        FComm.OpenCom;
        Reg:=TRegistry.Create;
        try
          if Reg.OpenKey('\SOFTWARE\ShtrihM\DrvSM\Param',true) then
            Reg.WriteInteger('Baudrate',FBaudRate);
        finally
          Reg.Free;
        end;
      end;
      $15: begin
        Move(s[1],FBaudRate,1);
        Move(s[2],FTimeOut,1);
      end;
      $16: begin
      end;
      $17: begin
      end;

      $30: begin
      end;
      $31: begin
      end;
      $32: begin
      end;
      $33: begin
      end;

      $3A: begin
        FWeightDeviceMode:=0;
        Move(s[1],FWeightDeviceMode,2);
        FChannelON:=(FWeightDeviceMode and $4) = $4;
        FWeight:=0;
        Move(s[3],FWeight,4);
        FTare:=0;
        Move(s[7],FTare,2);
      end;

      $70: begin
      end;
      $71: begin
        Move(s[1],FCalibrationWeight,2);       
      end;
      $72: begin
      end;
      $73: begin
        Move(s[1],FChannelNumber,1);
        Move(s[2],FCalibrationWeight,2);
        Move(s[4],FFixedPointStatus,1);
      end;
      $74: begin
      end;
      $75: begin
        Move(s[1],FADCValue,4);
      end;
      $90: begin
      end;

      $e5: begin
        Move(s[1],FChannelsCount,1);
      end;
      $e6: begin
        act_ch:=FChannelNumber;
      end;
      $e7: begin
      end;
      $e8: begin
        Move(s[1],FChannel,SizeOf(TChannel));
      end;
      $e9: begin
        FDegrees[FChannelNumber] := FChannel.Stepen;
      end;
      $ea: begin
        Move(s[1],FChannelNumber,1);
      end;

      $f0: begin
      end;
      $f1: begin
        FTestData:=copy(s,1,ord(str[1])-2);
      end;
      $f3: begin
        Move(s[1],FVoltage5,2);
        Move(s[3],FVoltage12,2);
        Move(s[5],FVoltageX,2);
        Move(s[7],FVoltageFlags,1);
        Move(s[8],FVoltageX,1);
      end;

      $f2: begin
        Move(s[1],FDeviceCRC,2);
      end;
      $f8: begin
      end;
      $fc: begin
        fillchar(FDeviceType,sizeof(FDeviceType),0);
        Move(s[1],FDeviceType,sizeof(FDeviceType));
        FComm.CorrectDevice:=((FDeviceType.UMajorType=1) and (FDeviceType.UMinorType=3));
      end;
    end;
end;

function TDrvSM.Get_ChannelDegree: Integer;
begin
  Result:=FChannel.Stepen;
end;

function TDrvSM.Get_ChannelDiscreteness1: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness1;
end;

function TDrvSM.Get_ChannelDiscreteness2: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness2;
end;

function TDrvSM.Get_ChannelDiscreteness3: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness3;
end;

function TDrvSM.Get_ChannelDiscreteness4: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness4;
end;

function TDrvSM.Get_ChannelFlags: Integer;
begin
  Result:=FChannel.Flags;
end;

function TDrvSM.Get_ChannelMaxTare: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.MaxTare;
end;

function TDrvSM.Get_ChannelMinWeight: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.MinWeight;
end;

function TDrvSM.Get_ChannelNumber: Integer;
begin
  Result:=FChannelNumber;
end;

function TDrvSM.Get_ChannelON: WordBool;
begin
  Result:=FChannelON;
end;

function TDrvSM.Get_ChannelPointsCount: Integer;
begin
  Result:=FChannel.PointsCount;
end;

function TDrvSM.Get_ChannelRange1: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Range1;
end;

function TDrvSM.Get_ChannelRange2: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Range2;
end;

function TDrvSM.Get_ChannelRange3: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Range3;
end;

function TDrvSM.Get_ChannelsCount: Integer;
begin
  Result:=FChannelsCount;
end;

function TDrvSM.Get_CalibrationWeight: Double;
begin
  Result:=exp(FChannel.Stepen)*FCalibrationWeight;
end;

function TDrvSM.Get_PointNumber: Integer;
begin
  Result:=FPointNumber;
end;

procedure TDrvSM.Set_ChannelDegree(Value: Integer);
begin
  if (Value>=-128)and(Value<=127) then FChannel.Stepen:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelDiscreteness1(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then FChannel.Discreteness1:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelDiscreteness2(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then FChannel.Discreteness2:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelDiscreteness3(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then FChannel.Discreteness3:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelDiscreteness4(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then FChannel.Discreteness4:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelFlags(Value: Integer);
begin
  if (Value>=0)and(Value<=65535) then FChannel.Flags:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelMaxTare(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then FChannel.MaxTare:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelMinWeight(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then FChannel.MinWeight:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelNumber(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then FChannelNumber:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelON(Value: WordBool);
begin
  FChannelON:=Value;
end;

procedure TDrvSM.Set_ChannelPointsCount(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then FChannelsCount:=Value
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelRange1(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then FChannel.Range1:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelRange2(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then FChannel.Range2:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_ChannelRange3(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then FChannel.Range3:=Round(Value/exp(FChannel.Stepen))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_CalibrationWeight(Value: Double);
begin
  if (Value>=0)and(Value/exp(FDegrees[act_ch])<=65535) then FCalibrationWeight:=Round(Value/exp(FDegrees[act_ch]))
      else isErrorParam:=True;
end;

procedure TDrvSM.Set_PointNumber(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then FPointNumber:=Value
      else isErrorParam:=True;
end;

function TDrvSM.exp(AValue: Shortint): double;
var i: integer;
begin
  Result:=1;
  if AValue>0 then
    for i:=1 to AValue do Result:=Result*10;
  if AValue<0 then
    for i:=AValue to -1 do Result:=Result/10;
end;

function TDrvSM.TestClr: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$F8;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.TestGet: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$F1;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_TestData: WideString;
begin
  Result:=FTestData;
end;

function TDrvSM.GetVoltage: Integer;
var s: string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$F3;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_Voltage12: Integer;
begin
  Result:=FVoltage12;
end;

function TDrvSM.Get_Voltage5: Integer;
begin
  Result:=FVoltage5;
end;

function TDrvSM.Get_VoltageFlags: Integer;
begin
  Result:=FVoltageFlags;
end;

function TDrvSM.Get_VoltageX: Integer;
begin
  Result:=FVoltageX;
end;

function TDrvSM.Get_VoltageX1: Integer;
begin
  Result:=FVoltageX1;
end;

function TDrvSM.GetChannelStatusEx: Integer;
var s: string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$5#$11;
    s:=s+GetStringPassword(FPassword);
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_Cost: Currency;
begin
  Result := FCost/100.0;
end;

function TDrvSM.Get_GoodType: Integer;
begin
  Result := FGoodType;
end;

function TDrvSM.Get_LastKey: Integer;
begin
  Result := FLastKey
end;

function TDrvSM.Get_Price: Currency;
begin
  Result := FPrice/100.0;
end;

function TDrvSM.Get_Quantity: Integer;
begin
  Result := FQuantity;
end;

function TDrvSM.SetGoodData: Integer;
var s: string;
    p: ^char;
    i: integer;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$02#$0A#$33;
    s:=s+GetStringPassword(FPassword);
    p:=@FGoodType; s:=s+p^;
    p:=@FQuantity; s:=s+p^;
    p:=@FPrice;
    for i:=1 to 3 do begin s:=s+p^; inc(p); end;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

procedure TDrvSM.Set_GoodType(Value: Integer);
begin
  If Value in [0..1] Then FGoodType:=Value
  else isErrorParam:=true;
end;

procedure TDrvSM.Set_LastKey(Value: Integer);
begin
  If Value in [0..255] Then FLastKey:=Value
  else isErrorParam:=true;
end;

procedure TDrvSM.Set_Price(Value: Currency);
begin
  If (Value >= 0) and (Value < 10000) Then FPrice:=round(Value*100)
  else isErrorParam:=true;
end;

procedure TDrvSM.Set_Quantity(Value: Integer);
begin
  If Value in [0..99] Then FQuantity:=Value
  else isErrorParam:=true;
end;

function TDrvSM.Get_CalibrationsCount: Integer;
begin
  Result := FChannel.CalibrationsCount;
end;

function TDrvSM.Get_DeviceCRC: Integer;
begin
  Result := FDeviceCRC;
end;

function TDrvSM.GetDeviceCRC: Integer;
var s:string;
begin
  if not FConnected then FError:=-20 else
  if not isErrorParam then begin
    s:=#$2#$1#$F2;
    FError:=FComm.Obmen(s);
    DecodeAnswer(s);
  end
  else begin
    FError:=-9;
    isErrorParam:=false;
  end;
  Result:=FError;
end;

function TDrvSM.Get_PortNumber: Integer;
begin
  Result := FPortNumber;
end;

procedure TDrvSM.Set_PortNumber(Value: Integer);
begin
  if (Value>=16)and(Value<=240) then FPortNumber:=Value
      else isErrorParam:=True;
end;

initialization
  TActiveXControlFactory.Create(
    ComServer,
    TDrvSM,
    TForm,
    Class_DrvSM,
    1,
    GUIDToString(CLASS_DrvSM),
    0,
    tmApartment);

end.
