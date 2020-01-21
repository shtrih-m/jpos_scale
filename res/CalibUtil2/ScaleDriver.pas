unit ScaleDriver;

interface

uses
  // CLX
  Classes, SysUtils, QForms, QDialogs, Variants, IniFiles, Math,
  // This
  ScaleProtocol, ScaleIntf, gnugettext;

type
  { TScaleDriver }

  TScaleDriver = class(TComponent, IDrvSM6)
  private
    FAnswer: string;
    FConnected: Boolean;
    FFileVersionLS: LongWord;
    FFileVersionMS: LongWord;
    FInput: WideString;
    FOutput: WideString;
    FError:integer;
    FErrorDescription:WideString;
    FDeviceType:TDeviceType;
    FBaudRate:integer;
    FComNumber:integer;
    FTimeOut:Word;
    FPortNumber: integer;
    FPassword:LongWord;
    FNewPassword:LongWord;
    FKey:byte;
    FKeyboardMode:byte;
    FMode:byte;
    FTare:smallint;
    FWeightDeviceMode: Word;
    FWeight:integer;
    FFixedPointStatus: byte;
    FADCValue: longWord;
    FDegrees: array[0..255] of integer;
    FChannel: TChannel;

    FPointNumber: byte;
    FChannelsCount: byte;
    FChannelNumber: byte;
    FCalibrationWeight: integer;
    FChannelON: Boolean;
    FTestData: string;

    FVoltage5: Word;
    FVoltage12: Word;
    FVoltageX: Word;
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
    FDeviceCRC: Word;

    FComm: TScaleProtocol;
    ActChannel: integer; // active channel

    procedure LoadDefaultParam;
    procedure InitProperties;
    function exp(AValue: Shortint): double;
    function GetIniFileName: string;
    procedure LoadParams;
    procedure SaveParams;
    function SendCommand(const command: string): Integer;
    function GetPassword: string;
    function GetPasswordData(const Data: Integer): string;
    function CheckMinLength(const Data: string; Min: Integer): Integer;
    function ClearResult: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
  protected         
    function Connect: Integer; 
    function Get_Connected: WordBool; 
    function Get_FileVersionLS: Integer; 
    function Get_FileVersionMS: Integer; 
    function Get_LDBaudRate: Integer; 
    function Get_LDComNumber: Integer; 
    function Get_LDIndex: Integer; 
    function Get_LDName: WideString; 
    function Get_LDNumber: Integer; 
    function Get_LDTimeout: Integer; 
    function Get_ResultCode: Integer; 
    function Get_ResultCodeDescription: WideString; 
    function AddLD: Integer; 
    function DeleteLD: Integer; 
    function Disconnect: Integer; 
    function EnumLD: Integer; 
    function GetActiveLD: Integer; 
    function GetCountLD: Integer; 
    function GetParamLD: Integer; 
    procedure Set_LDBaudRate(Value: Integer); 
    procedure Set_LDComNumber(Value: Integer); 
    procedure Set_LDIndex(Value: Integer); 
    procedure Set_LDName(const Value: WideString); 
    procedure Set_LDNumber(Value: Integer); 
    procedure Set_LDTimeout(Value: Integer); 
    function SetActiveLD: Integer; 
    function SetParamLD: Integer;
    function ShowProperties: Integer; 
    function GetDeviceMetrics: Integer; 
    function Get_UCodePage: Integer; 
    function Get_UDescription: WideString; 
    function Get_UMajorProtocolVersion: Integer; 
    function Get_UMajorType: Integer; 
    function Get_UMinorProtocolVersion: Integer; 
    function Get_UMinorType: Integer; 
    function Get_UModel: Integer; 
    function Get_BaudRate: Integer; 
    function Get_ComNumber: Integer; 
    function Get_LockKeyboardON: WordBool; 
    function Get_Mode: Integer; 
    function Get_Password: Integer; 
    function Get_Tare: Double; 
    function Get_Timeout: Integer; 
    function Get_Weight: Double; 
    function Get_WeightChannelMode: Integer; 
    function Get_ChannelMaxWeight: Double; 
    function GetExchangeParam: Integer; 
    function GetFixedPoint: Integer; 
    function GetCalibrationStatus: Integer; 
    function GetMode: Integer; 
    function GetChannelStatus: Integer; 
    function BreakCalibration: Integer; 
    function KeyEmulation: Integer; 
    procedure Set_BaudRate(Value: Integer); 
    procedure Set_ComNumber(Value: Integer); 
    procedure Set_Key(Value: Integer); 
    procedure Set_LockKeyboardON(Value: WordBool); 
    procedure Set_Mode(Value: Integer); 
    procedure Set_NewPassword(Value: Integer); 
    procedure Set_Password(Value: Integer); 
    procedure Set_Tare(Value: Double); 
    procedure Set_Timeout(Value: Integer);
    procedure Set_WeightChannelMode(Value: Integer); 
    procedure Set_ChannelMaxWeight(Value: Double); 
    function SetExchangeParam: Integer; 
    function SetFixedPoint: Integer; 
    function SetMode: Integer; 
    function SetPassword: Integer; 
    function SetTare: Integer; 
    function SetTareValue: Integer; 
    function SetZero: Integer; 
    function StartCalibration: Integer; 
    function Get_FixedPointStatus: Integer; 
    function LockKeyboard: Integer; 
    function Get_Input: WideString; 
    function Get_Output: WideString; 
    function Get_LDCount: Integer; 
    function Get_ADCValue: Integer; 
    function GetADCValue: Integer; 
    function SetChannelMode: Integer; 
    function GetChannelsCount: Integer; 
    function GetChannelParam: Integer; 
    function SetActiveChannel: Integer; 
    function SetChannelParam: Integer; 
    function Reset: Integer; 
    function RestartChannel: Integer; 
    function GetActiveChannel: Integer;
    function Get_ChannelDegree: Integer; 
    function Get_ChannelDiscreteness1: Double; 
    function Get_ChannelDiscreteness2: Double; 
    function Get_ChannelDiscreteness3: Double; 
    function Get_ChannelDiscreteness4: Double; 
    function Get_ChannelFlags: Integer; 
    function Get_ChannelMaxTare: Double; 
    function Get_ChannelMinWeight: Double; 
    function Get_ChannelNumber: Integer; 
    function Get_ChannelON: WordBool;
    function Get_ChannelPointsCount: Integer; 
    function Get_ChannelRange1: Double; 
    function Get_ChannelRange2: Double; 
    function Get_ChannelRange3: Double; 
    function Get_ChannelsCount: Integer; 
    function Get_CalibrationWeight: Double; 
    function Get_PointNumber: Integer; 
    procedure Set_ChannelDegree(Value: Integer); 
    procedure Set_ChannelDiscreteness1(Value: Double); 
    procedure Set_ChannelDiscreteness2(Value: Double); 
    procedure Set_ChannelDiscreteness3(Value: Double); 
    procedure Set_ChannelDiscreteness4(Value: Double); 
    procedure Set_ChannelFlags(Value: Integer); 
    procedure Set_ChannelMaxTare(Value: Double); 
    procedure Set_ChannelMinWeight(Value: Double); 
    procedure Set_ChannelNumber(Value: Integer); 
    procedure Set_ChannelON(Value: WordBool); 
    procedure Set_ChannelPointsCount(Value: Integer); 
    procedure Set_ChannelRange1(Value: Double); 
    procedure Set_ChannelRange2(Value: Double); 
    procedure Set_ChannelRange3(Value: Double); 
    procedure Set_CalibrationWeight(Value: Double); 
    procedure Set_PointNumber(Value: Integer); 
    function TestClr: Integer; 
    function TestGet: Integer; 
    function Get_TestData: WideString; 
    function GetVoltage: Integer; 
    function Get_Voltage12: Integer; 
    function Get_Voltage5: Integer; 
    function Get_VoltageFlags: Integer; 
    function Get_VoltageX: Integer; 
    function Get_VoltageX1: Integer; 
    function GetChannelStatusEx: Integer; 
    function Get_Cost: Currency; 
    function Get_GoodType: Integer;
    function Get_LastKey: Integer; 
    function Get_Price: Currency; 
    function Get_Quantity: Integer; 
    function SetGoodData: Integer; 
    procedure Set_GoodType(Value: Integer); 
    procedure Set_LastKey(Value: Integer);
    procedure Set_Price(Value: Currency); 
    procedure Set_Quantity(Value: Integer); 
    function Get_CalibrationsCount: Integer; 
    function Get_DeviceCRC: Integer; 
    function GetDeviceCRC: Integer; 
    function Get_PortNumber: Integer; 
    procedure Set_PortNumber(Value: Integer);
  end;

implementation

uses
  // This
  fmuConnect;

const
  IniSection = 'Params';

function IntToBin(Value, Count: Int64): string;
begin
  Result := '';
  if Count in [1..8] then
  begin
    SetLength(Result, Count);
    Move(Value, Result[1], Count);
  end;
end;

function BinToInt(const S: string; Index, Count: Integer): Int64;
var
  N: Integer;
begin
  Result := 0;
  if (Index > 0)and(Index <= Length(S)) then
  begin
    N := Min(Length(S)-Index + 1, 8);
    if Count <= N then
    begin
      Move(S[Index], Result, Count);
    end;
  end;
end;

{ TScaleDriver }

constructor TScaleDriver.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FComm := TScaleProtocol.Create;
  InitProperties;
  LoadParams;
end;

destructor TScaleDriver.Destroy;
begin
  SaveParams;
  FComm.Free;
  inherited Destroy;
end;

function TScaleDriver.GetIniFileName: string;
begin
  Result := 'CalibUtil.ini';
end;

procedure TScaleDriver.SaveParams;
var
  IniFile: TIniFile;
begin
  try
    IniFile := TIniFile.Create(GetIniFileName);
    try
      IniFile.WriteInteger(IniSection, 'Timeout', FTimeout);
      IniFile.WriteInteger(IniSection, 'Baudrate', FBaudRate);
      IniFile.WriteInteger(IniSection, 'ComNumber', FComNumber);
      IniFile.WriteInteger(IniSection, 'CurrentDevice', FCurLD);
    finally
      IniFile.Free;
    end;
  except
    { !!! }
  end;
end;

procedure TScaleDriver.LoadParams;
var
  IniFile: TIniFile;
begin
  try
    IniFile := TIniFile.Create(GetIniFileName);
    try
      FBaudRate := IniFile.ReadInteger(IniSection, 'Baudrate', 2);
      FComNumber := IniFile.ReadInteger(IniSection, 'ComNumber', 1);
      FTimeout := IniFile.ReadInteger(IniSection, 'Timeout', 150);
      FCurLD := IniFile.ReadInteger(IniSection, 'CurrentDevice', 0);
    finally
      IniFile.Free;
    end;
  except
    { !!! }
    LoadDefaultParam;
  end;
end;

procedure TScaleDriver.LoadDefaultParam;
begin
  FCurLD := 0;
  FBaudRate := 2;
  FComNumber := 1;
  FTimeout := 150;
  FPortNumber := 0;
end;

procedure TScaleDriver.InitProperties;
begin
  LoadDefaultParam;
  FConnected:=false;
  FFileVersionLS:=0;
  FFileVersionMS:=0;
  FInput:='';
  FOutput:='';
  FError:=0;
  FErrorDescription := _('Ошибок нет');
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

  ActChannel:=0;
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

function TScaleDriver.GetPassword: string;
begin
  Result := GetPasswordData(FPassword);
end;

function TScaleDriver.GetPasswordData(const Data: Integer): string;
begin
  Result := IntToStr(Data);
  Result := StringOfChar('0', 4-Length(Result)) + Result;
end;

function TScaleDriver.Connect: Integer;
var
  e: integer;
  i: integer;
begin
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
      if (FError<>0) or (FChannelNumber<0) or (FChannelNumber>FChannelsCount-1) then
      begin
        e:=-1;
        Disconnect;
      end
      else ActChannel:=FChannelNumber;
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

function TScaleDriver.Get_Connected: WordBool;
begin
  Result:=FConnected;
end;

function TScaleDriver.Get_FileVersionLS: Integer;
begin
  Result:=FFileVersionLS;
end;

function TScaleDriver.Get_FileVersionMS: Integer;
begin
  Result:=FFileVersionMS;
end;

function TScaleDriver.Get_LDBaudRate: Integer;
begin
  Result:=FLDBaudrate;
end;

function TScaleDriver.Get_LDComNumber: Integer;
begin
  Result:=FLDComNumber;
end;

function TScaleDriver.Get_LDIndex: Integer;
begin
  Result:=FLDIndex;
end;

function TScaleDriver.Get_LDName: WideString;
begin
  Result:=FLDName;
end;

function TScaleDriver.Get_LDNumber: Integer;
begin
  Result:=FLDUNumber;
end;

function TScaleDriver.Get_LDTimeout: Integer;
begin
  Result:=FLDTimeout;
end;

function TScaleDriver.Get_ResultCode: Integer;
begin
  Result := FError;
end;

function TScaleDriver.Get_ResultCodeDescription: WideString;
begin
  case FError of
    -20: FErrorDescription := _('Соединение не установлено');
    -18: FErrorDescription := _('Неверный тип устройства');
    -16: FErrorDescription := _('Нет активного логического устройства');
    -15: FErrorDescription := _('Команда не реализуется в данной версии');
    -14: FErrorDescription := _('Удаление логического устройства невозможно');
    -10: FErrorDescription := _('Неверный номер логического устройства');
    -9: FErrorDescription := _('Параметр вне диапазона');
    -8: FErrorDescription := _('Неожиданный ответ');
    -7: FErrorDescription := _('Нет связи');
    -3: FErrorDescription := _('Сом-порт недоступен');
    -2: FErrorDescription := _('Сом-порт занят другим приложением');
    -1: FErrorDescription := _('Нет связи');
    0: FErrorDescription := _('Ошибок нет');
    17: FErrorDescription := _('Ошибка в значении тары');
    120: FErrorDescription := _('Неизвестная команда');
    121: FErrorDescription := _('Неверная длина данных команды');
    122: FErrorDescription := _('Неверный пароль');
    123: FErrorDescription := _('Команда не реализуется в данном режиме');
    124: FErrorDescription := _('Неверное значение параметра');
    150: FErrorDescription := _('Ошибка при попытке установки нуля');
    151: FErrorDescription := _('Ошибка при установке тары');
    152: FErrorDescription := _('Вес не фиксирован');
    166: FErrorDescription := _('Сбой энергонезависимой памяти');
    167: FErrorDescription := _('Команда не реализуется интерфейсом');
    170: FErrorDescription := _('Исчерпан лимит попыток обращения с неверным паролем');
    180: FErrorDescription := _('Режим градуировки блокирован градуировочным переключателем');
    181: FErrorDescription := _('Клавиатура заблокирована');
    182: FErrorDescription := _('Нельзя поменять тип текущего канала');
    183: FErrorDescription := _('Нельзя выключить текущий канал');
    184: FErrorDescription := _('С данным каналом вообще ничего нельзя сделать');
    185: FErrorDescription := _('Неверный номер канала');
  end;
  Result := FErrorDescription;
end;

function TScaleDriver.AddLD: Integer;
begin
  Result := 0;
end;

function TScaleDriver.DeleteLD: Integer;
begin
  Result := 0;
end;

function TScaleDriver.Disconnect: Integer;
begin
  FComm.CloseCom;
  FConnected:=false;
  FError:=0;
  FInput:='';
  FOutput:='';
  Result:=FError;
end;

function TScaleDriver.EnumLD: Integer;
begin
  Result := 0;
end;

function TScaleDriver.GetActiveLD: Integer;
begin
  Result := 0;
end;

function TScaleDriver.GetCountLD: Integer;
begin
  FLDCount := 0;
  Result := ClearResult;
end;

function TScaleDriver.GetParamLD: Integer;
begin
  Result := 0;
end;

procedure TScaleDriver.Set_LDBaudRate(Value: Integer);
begin
  if Value in [0..6] then FLDBaudrate := Value;
end;

procedure TScaleDriver.Set_LDComNumber(Value: Integer);
begin
  if Value in [1..255] then FLDComNumber := Value;
end;

procedure TScaleDriver.Set_LDIndex(Value: Integer);
begin
  FLDIndex:=Value;
end;

procedure TScaleDriver.Set_LDName(const Value: WideString);
begin
  FLDName:=Value;
end;

procedure TScaleDriver.Set_LDNumber(Value: Integer);
begin
  FLDUNumber:=Value;
end;

procedure TScaleDriver.Set_LDTimeout(Value: Integer);
begin
  if (Value>=0) and (Value<=255) then
    FLDTimeout := Value;
end;

function TScaleDriver.SetActiveLD: Integer;
begin
  Result := 0;
end;

function TScaleDriver.SetParamLD: Integer;
begin
  Result := 0;
end;

function TScaleDriver.ShowProperties: Integer;
begin
  ShowConnectDlg(nil, Self);
  Result := ClearResult;
end;

function TScaleDriver.GetDeviceMetrics: Integer;
begin
  Result := SendCommand(#$FC);
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, 6);
  if Result <> 0 then Exit;
  Move(FAnswer[1], FDeviceType, 6);
  FDeviceType.UDescription := Copy(FAnswer, 7, Length(FAnswer));
  FComm.CorrectDevice := ((FDeviceType.UMajorType=1) and (FDeviceType.UMinorType=3));
end;

function TScaleDriver.Get_UCodePage: Integer;
begin
  Result:=FDeviceType.UCodePage;
end;

function TScaleDriver.Get_UDescription: WideString;
begin
  Result:=FDeviceType.UDescription;
end;

function TScaleDriver.Get_UMajorProtocolVersion: Integer;
begin
  Result:=FDeviceType.UMajorProtocol;
end;

function TScaleDriver.Get_UMajorType: Integer;
begin
  Result:=FDeviceType.UMajorType;
end;

function TScaleDriver.Get_UMinorProtocolVersion: Integer;
begin
  Result:=FDeviceType.UMinorProtocol;
end;

function TScaleDriver.Get_UMinorType: Integer;
begin
  Result:=FDeviceType.UMinorType;
end;

function TScaleDriver.Get_UModel: Integer;
begin
  Result:=FDeviceType.UModel;
end;

function TScaleDriver.Get_BaudRate: Integer;
begin
  Result:=FBaudRate;
end;

function TScaleDriver.Get_ComNumber: Integer;
begin
  Result:=FComNumber;
end;


function TScaleDriver.Get_LockKeyboardON: WordBool;
begin
  Result:=(FKeyboardMode = 1);
end;

function TScaleDriver.Get_Mode: Integer;
begin
  Result:=FMode;
end;

function TScaleDriver.Get_Password: Integer;
begin
  Result:=FPassword;
end;

function TScaleDriver.Get_Tare: Double;
begin
  Result:=exp(FDegrees[ActChannel])*integer(FTare);
end;

function TScaleDriver.Get_Timeout: Integer;
begin
  if FTimeOut=256 then Result:=0
     else Result:=FTimeOut;
end;

function TScaleDriver.Get_Weight: Double;
begin
  Result:=exp(FDegrees[ActChannel])*integer(FWeight);
end;

function TScaleDriver.Get_WeightChannelMode: Integer;
begin
  Result:=FWeightDeviceMode;
end;

function TScaleDriver.Get_ChannelMaxWeight: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.MaxWeight;
end;

function TScaleDriver.GetExchangeParam: Integer;
begin
  Result := SendCommand(#$15 + GetPassword);
  if Result = 0 then
  begin
    if Length(FAnswer) > 1 then
    begin
      FBaudRate := Ord(FAnswer[1]);
      FTimeOut := Ord(FAnswer[2]);
    end;
  end;
end;

function TScaleDriver.GetFixedPoint: Integer;
begin
  Result := SendCommand(#$71 + GetPassword + Chr(FPointNumber));
  if Result = 0 then
  begin
    Result := CheckMinLength(FAnswer, 2);
    if Result = 0 then
    begin
      FCalibrationWeight := BinToInt(FAnswer, 1, 2);
    end;
  end;
end;

function TScaleDriver.GetCalibrationStatus: Integer;
begin
  Result := SendCommand(#$73 + GetPassword);
  if Result = 0 then
  begin
    Result := CheckMinLength(FAnswer, 4);
    if Result = 0 then
    begin
      FChannelNumber := BinToInt(FAnswer, 1, 1);
      FCalibrationWeight := BinToInt(FAnswer, 2, 2);
      FFixedPointStatus := BinToInt(FAnswer, 4, 1);
    end;
  end;
end;

function TScaleDriver.GetMode: Integer;
begin
  Result := SendCommand(#$12);
  if Result = 0 then
  begin
    if Length(FAnswer) > 0 then
      FMode := Ord(FAnswer[1]);
  end;
end;

function TScaleDriver.GetChannelStatus: Integer;
begin
  Result := SendCommand(#$3A + GetPassword);
  if Result = 0 then
  begin
    if Length(FAnswer) < 9 then Exit;
    FWeightDeviceMode := BinToInt(FAnswer, 1, 2);
    FChannelON := (FWeightDeviceMode and $4) = $4;
    FWeight := BinToInt(FAnswer, 3, 4);
    FTare := BinToInt(FAnswer, 7, 2);
  end;
end;

function TScaleDriver.BreakCalibration: Integer;
begin
  Result := SendCommand(#$74 + GetPassword);
end;

function TScaleDriver.KeyEmulation: Integer;
begin
  Result := SendCommand(#$08 + GetPassword + Chr(FKey));
end;

procedure TScaleDriver.Set_BaudRate(Value: Integer);
begin
  if (Value>=0)and(Value<=6) then
    FBaudRate := Value;
end;

procedure TScaleDriver.Set_ComNumber(Value: Integer);
begin
  if (Value>=1)and(Value<=255) then
    FComNumber := Value;
end;

procedure TScaleDriver.Set_Key(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then
    FKey := Value;
end;

procedure TScaleDriver.Set_LockKeyboardON(Value: WordBool);
begin
  if Value then FKeyboardMode:=1 else FKeyboardMode:=0;
end;

procedure TScaleDriver.Set_Mode(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then
    FMode := Value;
end;

procedure TScaleDriver.Set_NewPassword(Value: Integer);
begin
  if (Value>=0)and(Value<=9999) then
    FNewPassword := Value;
end;

procedure TScaleDriver.Set_Password(Value: Integer);
begin
  if (Value>=0)and(Value<=9999) then
    FPassword := Value;
end;

procedure TScaleDriver.Set_Tare(Value: Double);
begin
  if (Value/exp(FDegrees[ActChannel])>=-32768)and(Value/exp(FDegrees[ActChannel])<=32768) then
     FTare := Round(Value/exp(FDegrees[ActChannel]));
end;

procedure TScaleDriver.Set_Timeout(Value: Integer);
begin
  FTimeOut := Value;
end;

procedure TScaleDriver.Set_WeightChannelMode(Value: Integer);
begin
  if (Value>=0)and(Value<=65535) then
    FWeightDeviceMode := Value;
end;

procedure TScaleDriver.Set_ChannelMaxWeight(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
     FChannel.MaxWeight:=Round(Value/exp(FChannel.Stepen));
end;

function TScaleDriver.SetExchangeParam: Integer;
var
  Command: string;
begin
  Command := #$14 + GetPassword + Chr(FPortNumber) + Chr(FBaudRate) + Chr(FTimeOut);
  Result := SendCommand(Command);
  if Result = 0 then
  begin
    FComm.BaudRate := FBaudRate;
    FComm.TimeOut := FTimeOut;
    FComm.OpenCom;
  end;
end;

function TScaleDriver.SetFixedPoint: Integer;
var
  Command: string;
begin
  Command := #$70 + GetPassword + Chr(FPointNumber) + IntToBin(FCalibrationWeight, 2);
  Result := SendCommand(Command);
end;

function TScaleDriver.SetMode: Integer;
var
  Command: string;
begin
  Command := #$7 + GetPassword + Chr(FMode);
  Result := SendCommand(Command);
end;

function TScaleDriver.SetPassword: Integer;
var
  Command: string;
begin
  Command := #$16 + GetPassword + GetPasswordData(FNewPassword);
  Result := SendCommand(Command);
end;

function TScaleDriver.SetTare: Integer;
var
  Command: string;
begin
  Command := #$31 + GetPassword;
  Result := SendCommand(Command);
end;

function TScaleDriver.SetTareValue: Integer;
var
  Command: string;
begin
  Command := #$32 + GetPassword + IntToBin(FTare, 2);
  Result := SendCommand(Command);
end;

function TScaleDriver.SetZero: Integer;
var
  Command: string;
begin
  Command := #$30 + GetPassword;
  Result := SendCommand(Command);
end;

function TScaleDriver.StartCalibration: Integer;
var
  Command: string;
begin
  Command := #$72 + GetPassword;
  Result := SendCommand(Command);
end;

function TScaleDriver.Get_FixedPointStatus: Integer;
begin
  Result := FFixedPointStatus;
end;

function TScaleDriver.LockKeyboard: Integer;
var
  Command: string;
begin
  Command := #$09 + GetPassword + Chr(FKeyboardMode);
  Result := SendCommand(Command);
end;

function TScaleDriver.Get_Input: WideString;
begin
  Result := FInput;
end;

function TScaleDriver.Get_Output: WideString;
begin
  Result := FOutput;
end;

function TScaleDriver.Get_LDCount: Integer;
begin
  Result := FLDCount;
end;

function TScaleDriver.Get_ADCValue: Integer;
begin
  Result := FADCValue;
end;

function TScaleDriver.GetADCValue: Integer;
var
  Command: string;
begin
  Command := #$75 + GetPassword;
  Result := SendCommand(Command);
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, 4);
  if Result <> 0 then Exit;
  FADCValue := BinToInt(FAnswer, 1, 4);
end;

function TScaleDriver.GetChannelsCount: Integer;
begin
  Result := SendCommand(#$E5);
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, 1);
  if Result <> 0 then Exit;
  FChannelsCount := Ord(FAnswer[1]);
end;

function TScaleDriver.GetChannelParam: Integer;
begin
  Result := SendCommand(#$E8 + Chr(FChannelNumber));
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, Sizeof(TChannel));
  if Result <> 0 then Exit;
  Move(FAnswer[1], FChannel, SizeOf(FChannel));
end;

function TScaleDriver.SetActiveChannel: Integer;
begin
  Result := SendCommand(#$E6 + GetPassword + Chr(FChannelNumber));
  if Result = 0 then
  begin
    ActChannel := FChannelNumber;
  end;
end;

function TScaleDriver.GetActiveChannel: Integer;
begin
  Result := SendCommand(#$EA);
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, 1);
  if Result <> 0 then Exit;
  FChannelNumber := Ord(FAnswer[1]);
end;

function TScaleDriver.SetChannelParam: Integer;
var
  Command: string;
begin
  SetLength(Command, Sizeof(FChannel));
  Move(FChannel, Command[1], Sizeof(FChannel));
  Command := #$E9 + GetPassword + Chr(FChannelNumber) + Command;
  Result := SendCommand(Command);
  if Result = 0 then
  begin
    FDegrees[FChannelNumber] := FChannel.Stepen;
  end;
end;

function TScaleDriver.SetChannelMode: Integer;
var
  Command: string;
const
  BoolToInt: array [Boolean] of Integer = (0, 1);
begin
  Command := #$E7 + GetPassword + Chr(BoolToInt[FChannelON]);
  Result := SendCommand(Command);
end;

function TScaleDriver.Reset: Integer;
var
  Command: string;
begin
  Command := #$F0 + GetPassword;
  Result := SendCommand(Command);
end;

function TScaleDriver.RestartChannel: Integer;
var
  Command: string;
begin
  Command := #$EF + GetPassword;
  Result := SendCommand(Command);
end;

function TScaleDriver.Get_ChannelDegree: Integer;
begin
  Result:=FChannel.Stepen;
end;

function TScaleDriver.Get_ChannelDiscreteness1: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness1;
end;

function TScaleDriver.Get_ChannelDiscreteness2: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness2;
end;

function TScaleDriver.Get_ChannelDiscreteness3: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness3;
end;

function TScaleDriver.Get_ChannelDiscreteness4: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Discreteness4;
end;

function TScaleDriver.Get_ChannelFlags: Integer;
begin
  Result:=FChannel.Flags;
end;

function TScaleDriver.Get_ChannelMaxTare: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.MaxTare;
end;

function TScaleDriver.Get_ChannelMinWeight: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.MinWeight;
end;

function TScaleDriver.Get_ChannelNumber: Integer;
begin
  Result:=FChannelNumber;
end;

function TScaleDriver.Get_ChannelON: WordBool;
begin
  Result:=FChannelON;
end;

function TScaleDriver.Get_ChannelPointsCount: Integer;
begin
  Result:=FChannel.PointsCount;
end;

function TScaleDriver.Get_ChannelRange1: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Range1;
end;

function TScaleDriver.Get_ChannelRange2: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Range2;
end;

function TScaleDriver.Get_ChannelRange3: Double;
begin
  Result:=exp(FChannel.Stepen)*FChannel.Range3;
end;

function TScaleDriver.Get_ChannelsCount: Integer;
begin
  Result:=FChannelsCount;
end;

function TScaleDriver.Get_CalibrationWeight: Double;
begin
  Result:=exp(FChannel.Stepen)*FCalibrationWeight;
end;

function TScaleDriver.Get_PointNumber: Integer;
begin
  Result:=FPointNumber;
end;

procedure TScaleDriver.Set_ChannelDegree(Value: Integer);
begin
  if (Value>=-128)and(Value<=127) then
    FChannel.Stepen := Value;
end;

procedure TScaleDriver.Set_ChannelDiscreteness1(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then
    FChannel.Discreteness1 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelDiscreteness2(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then
    FChannel.Discreteness2 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelDiscreteness3(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then
    FChannel.Discreteness3 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelDiscreteness4(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=255) then
    FChannel.Discreteness4 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelFlags(Value: Integer);
begin
  if (Value>=0)and(Value<=65535) then
    FChannel.Flags := Value;
end;

procedure TScaleDriver.Set_ChannelMaxTare(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
    FChannel.MaxTare := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelMinWeight(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
    FChannel.MinWeight := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelNumber(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then
    FChannelNumber := Value;
end;

procedure TScaleDriver.Set_ChannelON(Value: WordBool);
begin
  FChannelON:=Value;
end;

procedure TScaleDriver.Set_ChannelPointsCount(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then
    FChannelsCount := Value;
end;

procedure TScaleDriver.Set_ChannelRange1(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
    FChannel.Range1 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelRange2(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
    FChannel.Range2 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_ChannelRange3(Value: Double);
begin
  if (Value>=0)and(Value/exp(FChannel.Stepen)<=65535) then
    FChannel.Range3 := Round(Value/exp(FChannel.Stepen));
end;

procedure TScaleDriver.Set_CalibrationWeight(Value: Double);
begin
  if (Value>=0)and(Value/exp(FDegrees[ActChannel])<=65535) then
    FCalibrationWeight := Round(Value/exp(FDegrees[ActChannel]));
end;

procedure TScaleDriver.Set_PointNumber(Value: Integer);
begin
  if (Value>=0)and(Value<=255) then
    FPointNumber := Value;
end;

function TScaleDriver.exp(AValue: Shortint): double;
var i: integer;
begin
  Result:=1;
  if AValue>0 then
    for i:=1 to AValue do Result:=Result*10;
  if AValue<0 then
    for i:=AValue to -1 do Result:=Result/10;
end;

function TScaleDriver.TestClr: Integer;
begin
  Result := SendCommand(#$F8);
end;

function TScaleDriver.TestGet: Integer;
begin
  Result := SendCommand(#$F1);
  if Result <> 0 then Exit;
  FTestData := FAnswer;
end;

function TScaleDriver.Get_TestData: WideString;
begin
  Result := FTestData;
end;

function TScaleDriver.GetVoltage: Integer;
begin
  Result := SendCommand(#$F3 + GetPassword);
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, 8);
  if Result <> 0 then Exit;
  FVoltage5 := BinToInt(FAnswer, 1, 2);
  FVoltage12 := BinToInt(FAnswer, 3, 2);
  FVoltageX := BinToInt(FAnswer, 5, 2);
  FVoltageFlags := Ord(FAnswer[7]);
  FVoltageX := Ord(FAnswer[8]);
end;

function TScaleDriver.Get_Voltage12: Integer;
begin
  Result := FVoltage12;
end;

function TScaleDriver.Get_Voltage5: Integer;
begin
  Result := FVoltage5;
end;

function TScaleDriver.Get_VoltageFlags: Integer;
begin
  Result := FVoltageFlags;
end;

function TScaleDriver.Get_VoltageX: Integer;
begin
  Result := FVoltageX;
end;

function TScaleDriver.Get_VoltageX1: Integer;
begin
  Result := FVoltageX1;
end;

function TScaleDriver.GetChannelStatusEx: Integer;
var
  Command: string;
begin
  Command := #$11 + GetPassword;
  Result := SendCommand(Command);
  if Result = 0 then
  begin
    //CheckDataLength(Answer, 18); { !!! }
    FWeightDeviceMode := BinToInt(FAnswer, 1, 2);
    FChannelON := (FWeightDeviceMode and $4) = $4;
    FWeight := BinToInt(FAnswer, 3, 4);
    FTare := BinToInt(FAnswer, 7, 2);
    FGoodType := BinToInt(FAnswer, 10, 1);
    FQuantity := BinToInt(FAnswer, 11, 1);
    FPrice := BinToInt(FAnswer, 12, 3);
    FCost := BinToInt(FAnswer, 15, 3);
    FLastKey := BinToInt(FAnswer, 18, 1);
  end;
end;

function TScaleDriver.Get_Cost: Currency;
begin
  Result := FCost/100.0;
end;

function TScaleDriver.Get_GoodType: Integer;
begin
  Result := FGoodType;
end;

function TScaleDriver.Get_LastKey: Integer;
begin
  Result := FLastKey
end;

function TScaleDriver.Get_Price: Currency;
begin
  Result := FPrice/100.0;
end;

function TScaleDriver.Get_Quantity: Integer;
begin
  Result := FQuantity;
end;

function TScaleDriver.SetGoodData: Integer;
var
  Command: string;
begin
  Command := #$33 + GetPassword + Chr(FGoodType) + Chr(FQuantity) +
    IntToBin(FPrice, 3);
  Result := SendCommand(Command);
end;

procedure TScaleDriver.Set_GoodType(Value: Integer);
begin
  if Value in [0..1] then
    FGoodType := Value;
end;

procedure TScaleDriver.Set_LastKey(Value: Integer);
begin
  if Value in [0..255] then FLastKey:=Value
end;

procedure TScaleDriver.Set_Price(Value: Currency);
begin
  if (Value >= 0) and (Value < 10000) then
    FPrice := round(Value*100);
end;

procedure TScaleDriver.Set_Quantity(Value: Integer);
begin
  if Value in [0..99] then
    FQuantity := Value;
end;

function TScaleDriver.Get_CalibrationsCount: Integer;
begin
  Result := FChannel.CalibrationsCount;
end;

function TScaleDriver.Get_DeviceCRC: Integer;
begin
  Result := FDeviceCRC;
end;

function TScaleDriver.GetDeviceCRC: Integer;
begin
  Result := SendCommand(#$F2);
  if Result <> 0 then Exit;
  Result := CheckMinLength(FAnswer, 2);
  if Result <> 0 then Exit;
  FDeviceCRC := BinToInt(FAnswer, 1, 2);
end;

function TScaleDriver.Get_PortNumber: Integer;
begin
  Result := FPortNumber;
end;

procedure TScaleDriver.Set_PortNumber(Value: Integer);
begin
  if (Value>=16)and(Value<=240) then
    FPortNumber := Value;
end;

function TScaleDriver.ClearResult: Integer;
begin
  FError := 0;
  FErrorDescription := _('Ошибок нет');
  Result := FError;
end;

function TScaleDriver.CheckMinLength(const Data: string; Min: Integer): Integer;
begin
  Result := ClearResult;
  if Length(Data) < Min then
  begin
    Result := -8;
    FError := -8;
  end;
end;

function GetCRC(const Data: string): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(Data) do
    Result := Result xor Ord(Data[i]);
end;

function TScaleDriver.SendCommand(const Command: string): Integer;
var
  Frame: string;
begin
  Frame := Chr(Length(command)) + Command;
  Frame := Chr(STX) + Frame + Chr(GetCrc(Frame));
  FError := FComm.Send(Frame, 1000);
  FInput := FComm.Input;
  FOutput := FComm.Output;
  if FError = 0 then
  begin
    Result := CheckMinLength(Frame, 3);
    if Result <> 0 then Exit;

    FError := Ord(Frame[3]);
    FErrorDescription := Get_ResultCodeDescription;
    FAnswer := Copy(Frame, 4, Length(Frame)-3);
  end;
  Result := FError;
end;


end.
