unit ScaleIntf;

interface

uses
  // CLX
  Classes, Variants;


const
  // TypeLibrary Major and minor versions
  AddInMajorVersion = 1;
  AddInMinorVersion = 0;

  LIBID_AddIn: TGUID = '{6766F2F6-9D9B-4866-99CA-478665D4DE2E}';

  IID_IDrvSM: TGUID = '{FC7240A4-FBD7-48BE-B802-3FE6038A8102}';
  IID_IDrvSM2: TGUID = '{A95C5A5D-8675-44F0-8F77-BB3582D6CCFA}';
  IID_IDrvSM3: TGUID = '{156E2FCB-D12E-40F5-8FE2-9DEE8E89B02C}';
  IID_IDrvSM4: TGUID = '{1F09EB6F-BFBA-4819-BEA3-2097C8A3CF6F}';
  IID_IDrvSM5: TGUID = '{9882A14B-B813-4419-8197-1BCF7AC1349C}';
  IID_IDrvSM6: TGUID = '{8974264A-4303-48BE-9207-FB3B847A0090}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IDrvSM = interface;
  IDrvSM2 = interface;
  IDrvSM3 = interface;
  IDrvSM4 = interface;
  IDrvSM5 = interface;
  IDrvSM6 = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  DrvSM = IDrvSM6;


// *********************************************************************//
// Interface: IDrvSM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FC7240A4-FBD7-48BE-B802-3FE6038A8102}
// *********************************************************************//
  IDrvSM = interface
    ['{FC7240A4-FBD7-48BE-B802-3FE6038A8102}']
    function Connect: Integer; 
    function Disconnect: Integer; 
    function ShowProperties: Integer; 
    function AddLD: Integer; 
    function DeleteLD: Integer; 
    function EnumLD: Integer; 
    function GetActiveLD: Integer; 
    function GetCountLD: Integer; 
    function GetParamLD: Integer; 
    function SetActiveLD: Integer; 
    function SetParamLD: Integer; 
    function Get_Connected: WordBool; 
    function Get_ResultCode: Integer; 
    function Get_ResultCodeDescription: WideString; 
    function Get_FileVersionLS: Integer; 
    function Get_FileVersionMS: Integer; 
    function Get_LDBaudRate: Integer; 
    procedure Set_LDBaudRate(Value: Integer); 
    function Get_LDTimeout: Integer; 
    procedure Set_LDTimeout(Value: Integer); 
    function Get_LDComNumber: Integer; 
    procedure Set_LDComNumber(Value: Integer); 
    function Get_LDName: WideString; 
    procedure Set_LDName(const Value: WideString); 
    function Get_LDNumber: Integer; 
    procedure Set_LDNumber(Value: Integer); 
    function Get_LDIndex: Integer; 
    procedure Set_LDIndex(Value: Integer); 
    function GetDeviceMetrics: Integer; 
    function Get_UCodePage: Integer; 
    function Get_UDescription: WideString; 
    function Get_UMajorProtocolVersion: Integer; 
    function Get_UMinorProtocolVersion: Integer; 
    function Get_UMajorType: Integer; 
    function Get_UMinorType: Integer; 
    function Get_UModel: Integer; 
    function SetMode: Integer; 
    function KeyEmulation: Integer; 
    function GetMode: Integer; 
    function SetExchangeParam: Integer; 
    function GetExchangeParam: Integer; 
    function SetPassword: Integer; 
    function SetZero: Integer; 
    function SetTare: Integer; 
    function SetTareValue: Integer; 
    function GetChannelStatus: Integer; 
    function SetFixedPoint: Integer; 
    function GetFixedPoint: Integer; 
    function StartCalibration: Integer; 
    function GetCalibrationStatus: Integer; 
    function BreakCalibration: Integer; 
    procedure Set_Key(Param1: Integer); 
    function Get_LockKeyboardON: WordBool; 
    procedure Set_LockKeyboardON(Value: WordBool); 
    function Get_Mode: Integer; 
    procedure Set_Mode(Value: Integer); 
    function Get_Timeout: Integer; 
    procedure Set_Timeout(Value: Integer); 
    function Get_BaudRate: Integer; 
    procedure Set_BaudRate(Value: Integer); 
    function Get_ComNumber: Integer; 
    procedure Set_ComNumber(Value: Integer); 
    function Get_Password: Integer; 
    procedure Set_Password(Value: Integer); 
    procedure Set_NewPassword(Param1: Integer); 
    function Get_WeightChannelMode: Integer; 
    procedure Set_WeightChannelMode(Value: Integer); 
    function Get_Tare: Double; 
    procedure Set_Tare(Value: Double); 
    function Get_Weight: Double; 
    function Get_ChannelMaxWeight: Double; 
    procedure Set_ChannelMaxWeight(Value: Double); 
    function Get_FixedPointStatus: Integer; 
    function LockKeyboard: Integer; 
    function Get_Input: WideString; 
    function Get_Output: WideString; 
    function Get_LDCount: Integer; 
    function GetADCValue: Integer; 
    function Get_ADCValue: Integer; 
    function GetChannelsCount: Integer; 
    function SetActiveChannel: Integer; 
    function SetChannelMode: Integer; 
    function GetChannelParam: Integer; 
    function SetChannelParam: Integer; 
    function RestartChannel: Integer; 
    function Reset: Integer; 
    function GetActiveChannel: Integer; 
    function Get_CalibrationWeight: Double; 
    procedure Set_CalibrationWeight(Value: Double); 
    function Get_PointNumber: Integer; 
    procedure Set_PointNumber(Value: Integer); 
    function Get_ChannelNumber: Integer; 
    procedure Set_ChannelNumber(Value: Integer); 
    function Get_ChannelON: WordBool; 
    procedure Set_ChannelON(Value: WordBool); 
    function Get_ChannelsCount: Integer; 
    function Get_ChannelDegree: Integer; 
    procedure Set_ChannelDegree(Value: Integer); 
    function Get_ChannelFlags: Integer; 
    procedure Set_ChannelFlags(Value: Integer); 
    function Get_ChannelMinWeight: Double; 
    procedure Set_ChannelMinWeight(Value: Double); 
    function Get_ChannelMaxTare: Double; 
    procedure Set_ChannelMaxTare(Value: Double); 
    function Get_ChannelRange1: Double; 
    procedure Set_ChannelRange1(Value: Double); 
    function Get_ChannelRange2: Double; 
    procedure Set_ChannelRange2(Value: Double); 
    function Get_ChannelRange3: Double; 
    procedure Set_ChannelRange3(Value: Double); 
    function Get_ChannelDiscreteness1: Double; 
    procedure Set_ChannelDiscreteness1(Value: Double); 
    function Get_ChannelDiscreteness2: Double; 
    procedure Set_ChannelDiscreteness2(Value: Double); 
    function Get_ChannelDiscreteness3: Double; 
    procedure Set_ChannelDiscreteness3(Value: Double); 
    function Get_ChannelDiscreteness4: Double; 
    procedure Set_ChannelDiscreteness4(Value: Double); 
    function Get_ChannelPointsCount: Integer; 
    procedure Set_ChannelPointsCount(Value: Integer); 
    property Connected: WordBool read Get_Connected;
    property ResultCode: Integer read Get_ResultCode;
    property ResultCodeDescription: WideString read Get_ResultCodeDescription;
    property FileVersionLS: Integer read Get_FileVersionLS;
    property FileVersionMS: Integer read Get_FileVersionMS;
    property LDBaudRate: Integer read Get_LDBaudRate write Set_LDBaudRate;
    property LDTimeout: Integer read Get_LDTimeout write Set_LDTimeout;
    property LDComNumber: Integer read Get_LDComNumber write Set_LDComNumber;
    property LDName: WideString read Get_LDName write Set_LDName;
    property LDNumber: Integer read Get_LDNumber write Set_LDNumber;
    property LDIndex: Integer read Get_LDIndex write Set_LDIndex;
    property UCodePage: Integer read Get_UCodePage;
    property UDescription: WideString read Get_UDescription;
    property UMajorProtocolVersion: Integer read Get_UMajorProtocolVersion;
    property UMinorProtocolVersion: Integer read Get_UMinorProtocolVersion;
    property UMajorType: Integer read Get_UMajorType;
    property UMinorType: Integer read Get_UMinorType;
    property UModel: Integer read Get_UModel;
    property Key: Integer write Set_Key;
    property LockKeyboardON: WordBool read Get_LockKeyboardON write Set_LockKeyboardON;
    property Mode: Integer read Get_Mode write Set_Mode;
    property Timeout: Integer read Get_Timeout write Set_Timeout;
    property BaudRate: Integer read Get_BaudRate write Set_BaudRate;
    property ComNumber: Integer read Get_ComNumber write Set_ComNumber;
    property Password: Integer read Get_Password write Set_Password;
    property NewPassword: Integer write Set_NewPassword;
    property WeightChannelMode: Integer read Get_WeightChannelMode write Set_WeightChannelMode;
    property Tare: Double read Get_Tare write Set_Tare;
    property Weight: Double read Get_Weight;
    property ChannelMaxWeight: Double read Get_ChannelMaxWeight write Set_ChannelMaxWeight;
    property FixedPointStatus: Integer read Get_FixedPointStatus;
    property Input: WideString read Get_Input;
    property Output: WideString read Get_Output;
    property LDCount: Integer read Get_LDCount;
    property ADCValue: Integer read Get_ADCValue;
    property CalibrationWeight: Double read Get_CalibrationWeight write Set_CalibrationWeight;
    property PointNumber: Integer read Get_PointNumber write Set_PointNumber;
    property ChannelNumber: Integer read Get_ChannelNumber write Set_ChannelNumber;
    property ChannelON: WordBool read Get_ChannelON write Set_ChannelON;
    property ChannelsCount: Integer read Get_ChannelsCount;
    property ChannelDegree: Integer read Get_ChannelDegree write Set_ChannelDegree;
    property ChannelFlags: Integer read Get_ChannelFlags write Set_ChannelFlags;
    property ChannelMinWeight: Double read Get_ChannelMinWeight write Set_ChannelMinWeight;
    property ChannelMaxTare: Double read Get_ChannelMaxTare write Set_ChannelMaxTare;
    property ChannelRange1: Double read Get_ChannelRange1 write Set_ChannelRange1;
    property ChannelRange2: Double read Get_ChannelRange2 write Set_ChannelRange2;
    property ChannelRange3: Double read Get_ChannelRange3 write Set_ChannelRange3;
    property ChannelDiscreteness1: Double read Get_ChannelDiscreteness1 write Set_ChannelDiscreteness1;
    property ChannelDiscreteness2: Double read Get_ChannelDiscreteness2 write Set_ChannelDiscreteness2;
    property ChannelDiscreteness3: Double read Get_ChannelDiscreteness3 write Set_ChannelDiscreteness3;
    property ChannelDiscreteness4: Double read Get_ChannelDiscreteness4 write Set_ChannelDiscreteness4;
    property ChannelPointsCount: Integer read Get_ChannelPointsCount write Set_ChannelPointsCount;
  end;


// *********************************************************************//
// Interface: IDrvSM2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A95C5A5D-8675-44F0-8F77-BB3582D6CCFA}
// *********************************************************************//
  IDrvSM2 = interface(IDrvSM)
    ['{A95C5A5D-8675-44F0-8F77-BB3582D6CCFA}']
    function TestGet: Integer; 
    function TestClr: Integer; 
    function Get_TestData: WideString; 
    property TestData: WideString read Get_TestData;
  end;

// *********************************************************************//
// Interface: IDrvSM3
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {156E2FCB-D12E-40F5-8FE2-9DEE8E89B02C}
// *********************************************************************//
  IDrvSM3 = interface(IDrvSM2)
    ['{156E2FCB-D12E-40F5-8FE2-9DEE8E89B02C}']
    function GetVoltage: Integer; 
    function Get_Voltage5: Integer; 
    function Get_Voltage12: Integer; 
    function Get_VoltageX: Integer; 
    function Get_VoltageFlags: Integer; 
    function Get_VoltageX1: Integer; 
    property Voltage5: Integer read Get_Voltage5;
    property Voltage12: Integer read Get_Voltage12;
    property VoltageX: Integer read Get_VoltageX;
    property VoltageFlags: Integer read Get_VoltageFlags;
    property VoltageX1: Integer read Get_VoltageX1;
  end;

// *********************************************************************//
// Interface: IDrvSM4
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {1F09EB6F-BFBA-4819-BEA3-2097C8A3CF6F}
// *********************************************************************//
  IDrvSM4 = interface(IDrvSM3)
    ['{1F09EB6F-BFBA-4819-BEA3-2097C8A3CF6F}']
    function GetChannelStatusEx: Integer; 
    function Get_Price: Currency; 
    procedure Set_Price(Value: Currency); 
    function Get_Cost: Currency; 
    function Get_GoodType: Integer; 
    procedure Set_GoodType(Value: Integer); 
    function Get_LastKey: Integer; 
    procedure Set_LastKey(Value: Integer); 
    function SetGoodData: Integer; 
    function Get_Quantity: Integer; 
    procedure Set_Quantity(Value: Integer); 
    property Price: Currency read Get_Price write Set_Price;
    property Cost: Currency read Get_Cost;
    property GoodType: Integer read Get_GoodType write Set_GoodType;
    property LastKey: Integer read Get_LastKey write Set_LastKey;
    property Quantity: Integer read Get_Quantity write Set_Quantity;
  end;

// *********************************************************************//
// Interface: IDrvSM5
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {9882A14B-B813-4419-8197-1BCF7AC1349C}
// *********************************************************************//
  IDrvSM5 = interface(IDrvSM4)
    ['{9882A14B-B813-4419-8197-1BCF7AC1349C}']
    function GetDeviceCRC: Integer; 
    function Get_DeviceCRC: Integer; 
    function Get_CalibrationsCount: Integer; 
    property DeviceCRC: Integer read Get_DeviceCRC;
    property CalibrationsCount: Integer read Get_CalibrationsCount;
  end;

// *********************************************************************//
// Interface: IDrvSM6
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8974264A-4303-48BE-9207-FB3B847A0090}
// *********************************************************************//
  IDrvSM6 = interface(IDrvSM5)
    ['{8974264A-4303-48BE-9207-FB3B847A0090}']
    function Get_PortNumber: Integer; 
    procedure Set_PortNumber(Value: Integer);
    property PortNumber: Integer read Get_PortNumber write Set_PortNumber;
  end;

implementation


end.
