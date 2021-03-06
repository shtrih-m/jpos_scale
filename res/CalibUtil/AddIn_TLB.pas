unit AddIn_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88  $
// File generated on 19.07.2004 16:53:49 from Type Library described below.

// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
// ************************************************************************ //
// Type Lib: D:\Projects\������� ������\�������\DrvSM.tlb (1)
// IID\LCID: {6766F2F6-9D9B-4866-99CA-478665D4DE2E}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\System32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  AddInMajorVersion = 1;
  AddInMinorVersion = 0;

  LIBID_AddIn: TGUID = '{6766F2F6-9D9B-4866-99CA-478665D4DE2E}';

  IID_IDrvSM: TGUID = '{FC7240A4-FBD7-48BE-B802-3FE6038A8102}';
  CLASS_DrvSM: TGUID = '{B432A339-3F9D-46C0-BBBE-02DA74469C9B}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IDrvSM = interface;
  IDrvSMDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  DrvSM = IDrvSM;


// *********************************************************************//
// Interface: IDrvSM
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FC7240A4-FBD7-48BE-B802-3FE6038A8102}
// *********************************************************************//
  IDrvSM = interface(IDispatch)
    ['{FC7240A4-FBD7-48BE-B802-3FE6038A8102}']
    function  Connect: Integer; safecall;
    function  Disconnect: Integer; safecall;
    function  ShowProperties: Integer; safecall;
    function  AddLD: Integer; safecall;
    function  DeleteLD: Integer; safecall;
    function  EnumLD: Integer; safecall;
    function  GetActiveLD: Integer; safecall;
    function  GetCountLD: Integer; safecall;
    function  GetParamLD: Integer; safecall;
    function  SetActiveLD: Integer; safecall;
    function  SetParamLD: Integer; safecall;
    function  Get_Connected: WordBool; safecall;
    function  Get_ResultCode: Integer; safecall;
    function  Get_ResultCodeDescription: WideString; safecall;
    function  Get_FileVersionLS: Integer; safecall;
    function  Get_FileVersionMS: Integer; safecall;
    function  Get_LDBaudRate: Integer; safecall;
    procedure Set_LDBaudRate(Value: Integer); safecall;
    function  Get_LDTimeout: Integer; safecall;
    procedure Set_LDTimeout(Value: Integer); safecall;
    function  Get_LDComNumber: Integer; safecall;
    procedure Set_LDComNumber(Value: Integer); safecall;
    function  Get_LDName: WideString; safecall;
    procedure Set_LDName(const Value: WideString); safecall;
    function  Get_LDNumber: Integer; safecall;
    procedure Set_LDNumber(Value: Integer); safecall;
    function  Get_LDIndex: Integer; safecall;
    procedure Set_LDIndex(Value: Integer); safecall;
    function  GetDeviceMetrics: Integer; safecall;
    function  Get_UCodePage: Integer; safecall;
    function  Get_UDescription: WideString; safecall;
    function  Get_UMajorProtocolVersion: Integer; safecall;
    function  Get_UMinorProtocolVersion: Integer; safecall;
    function  Get_UMajorType: Integer; safecall;
    function  Get_UMinorType: Integer; safecall;
    function  Get_UModel: Integer; safecall;
    function  SetMode: Integer; safecall;
    function  KeyEmulation: Integer; safecall;
    function  GetMode: Integer; safecall;
    function  SetExchangeParam: Integer; safecall;
    function  GetExchangeParam: Integer; safecall;
    function  SetPassword: Integer; safecall;
    function  SetZero: Integer; safecall;
    function  SetTare: Integer; safecall;
    function  SetTareValue: Integer; safecall;
    function  GetChannelStatus: Integer; safecall;
    function  SetFixedPoint: Integer; safecall;
    function  GetFixedPoint: Integer; safecall;
    function  StartCalibration: Integer; safecall;
    function  GetCalibrationStatus: Integer; safecall;
    function  BreakCalibration: Integer; safecall;
    procedure Set_Key(Param1: Integer); safecall;
    function  Get_LockKeyboardON: WordBool; safecall;
    procedure Set_LockKeyboardON(Value: WordBool); safecall;
    function  Get_Mode: Integer; safecall;
    procedure Set_Mode(Value: Integer); safecall;
    function  Get_Timeout: Integer; safecall;
    procedure Set_Timeout(Value: Integer); safecall;
    function  Get_BaudRate: Integer; safecall;
    procedure Set_BaudRate(Value: Integer); safecall;
    function  Get_ComNumber: Integer; safecall;
    procedure Set_ComNumber(Value: Integer); safecall;
    function  Get_Password: Integer; safecall;
    procedure Set_Password(Value: Integer); safecall;
    procedure Set_NewPassword(Param1: Integer); safecall;
    function  Get_WeightChannelMode: Integer; safecall;
    procedure Set_WeightChannelMode(Value: Integer); safecall;
    function  Get_Tare: Double; safecall;
    procedure Set_Tare(Value: Double); safecall;
    function  Get_Weight: Double; safecall;
    function  Get_ChannelMaxWeight: Double; safecall;
    procedure Set_ChannelMaxWeight(Value: Double); safecall;
    function  Get_FixedPointStatus: Integer; safecall;
    function  LockKeyboard: Integer; safecall;
    function  Get_Input: WideString; safecall;
    function  Get_Output: WideString; safecall;
    function  Get_LDCount: Integer; safecall;
    function  GetADCValue: Integer; safecall;
    function  Get_ADCValue: Integer; safecall;
    function  GetChannelsCount: Integer; safecall;
    function  SetActiveChannel: Integer; safecall;
    function  SetChannelMode: Integer; safecall;
    function  GetChannelParam: Integer; safecall;
    function  SetChannelParam: Integer; safecall;
    function  RestartChannel: Integer; safecall;
    function  Reset: Integer; safecall;
    function  GetActiveChannel: Integer; safecall;
    function  Get_CalibrationWeight: Double; safecall;
    procedure Set_CalibrationWeight(Value: Double); safecall;
    function  Get_PointNumber: Integer; safecall;
    procedure Set_PointNumber(Value: Integer); safecall;
    function  Get_ChannelNumber: Integer; safecall;
    procedure Set_ChannelNumber(Value: Integer); safecall;
    function  Get_ChannelON: WordBool; safecall;
    procedure Set_ChannelON(Value: WordBool); safecall;
    function  Get_ChannelsCount: Integer; safecall;
    function  Get_ChannelDegree: Integer; safecall;
    procedure Set_ChannelDegree(Value: Integer); safecall;
    function  Get_ChannelFlags: Integer; safecall;
    procedure Set_ChannelFlags(Value: Integer); safecall;
    function  Get_ChannelMinWeight: Double; safecall;
    procedure Set_ChannelMinWeight(Value: Double); safecall;
    function  Get_ChannelMaxTare: Double; safecall;
    procedure Set_ChannelMaxTare(Value: Double); safecall;
    function  Get_ChannelRange1: Double; safecall;
    procedure Set_ChannelRange1(Value: Double); safecall;
    function  Get_ChannelRange2: Double; safecall;
    procedure Set_ChannelRange2(Value: Double); safecall;
    function  Get_ChannelRange3: Double; safecall;
    procedure Set_ChannelRange3(Value: Double); safecall;
    function  Get_ChannelDiscreteness1: Double; safecall;
    procedure Set_ChannelDiscreteness1(Value: Double); safecall;
    function  Get_ChannelDiscreteness2: Double; safecall;
    procedure Set_ChannelDiscreteness2(Value: Double); safecall;
    function  Get_ChannelDiscreteness3: Double; safecall;
    procedure Set_ChannelDiscreteness3(Value: Double); safecall;
    function  Get_ChannelDiscreteness4: Double; safecall;
    procedure Set_ChannelDiscreteness4(Value: Double); safecall;
    function  Get_ChannelPointsCount: Integer; safecall;
    procedure Set_ChannelPointsCount(Value: Integer); safecall;
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
// DispIntf:  IDrvSMDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FC7240A4-FBD7-48BE-B802-3FE6038A8102}
// *********************************************************************//
  IDrvSMDisp = dispinterface
    ['{FC7240A4-FBD7-48BE-B802-3FE6038A8102}']
    function  Connect: Integer; dispid 1;
    function  Disconnect: Integer; dispid 2;
    function  ShowProperties: Integer; dispid 3;
    function  AddLD: Integer; dispid 4;
    function  DeleteLD: Integer; dispid 5;
    function  EnumLD: Integer; dispid 6;
    function  GetActiveLD: Integer; dispid 7;
    function  GetCountLD: Integer; dispid 8;
    function  GetParamLD: Integer; dispid 9;
    function  SetActiveLD: Integer; dispid 10;
    function  SetParamLD: Integer; dispid 11;
    property Connected: WordBool readonly dispid 12;
    property ResultCode: Integer readonly dispid 13;
    property ResultCodeDescription: WideString readonly dispid 14;
    property FileVersionLS: Integer readonly dispid 15;
    property FileVersionMS: Integer readonly dispid 16;
    property LDBaudRate: Integer dispid 17;
    property LDTimeout: Integer dispid 18;
    property LDComNumber: Integer dispid 19;
    property LDName: WideString dispid 20;
    property LDNumber: Integer dispid 21;
    property LDIndex: Integer dispid 22;
    function  GetDeviceMetrics: Integer; dispid 23;
    property UCodePage: Integer readonly dispid 24;
    property UDescription: WideString readonly dispid 25;
    property UMajorProtocolVersion: Integer readonly dispid 26;
    property UMinorProtocolVersion: Integer readonly dispid 27;
    property UMajorType: Integer readonly dispid 28;
    property UMinorType: Integer readonly dispid 29;
    property UModel: Integer readonly dispid 30;
    function  SetMode: Integer; dispid 32;
    function  KeyEmulation: Integer; dispid 33;
    function  GetMode: Integer; dispid 34;
    function  SetExchangeParam: Integer; dispid 35;
    function  GetExchangeParam: Integer; dispid 36;
    function  SetPassword: Integer; dispid 37;
    function  SetZero: Integer; dispid 38;
    function  SetTare: Integer; dispid 39;
    function  SetTareValue: Integer; dispid 40;
    function  GetChannelStatus: Integer; dispid 41;
    function  SetFixedPoint: Integer; dispid 45;
    function  GetFixedPoint: Integer; dispid 46;
    function  StartCalibration: Integer; dispid 47;
    function  GetCalibrationStatus: Integer; dispid 48;
    function  BreakCalibration: Integer; dispid 49;
    property Key: Integer writeonly dispid 51;
    property LockKeyboardON: WordBool dispid 52;
    property Mode: Integer dispid 54;
    property Timeout: Integer dispid 55;
    property BaudRate: Integer dispid 56;
    property ComNumber: Integer dispid 57;
    property Password: Integer dispid 59;
    property NewPassword: Integer writeonly dispid 60;
    property WeightChannelMode: Integer dispid 62;
    property Tare: Double dispid 63;
    property Weight: Double readonly dispid 64;
    property ChannelMaxWeight: Double dispid 65;
    property FixedPointStatus: Integer readonly dispid 61;
    function  LockKeyboard: Integer; dispid 69;
    property Input: WideString readonly dispid 70;
    property Output: WideString readonly dispid 71;
    property LDCount: Integer readonly dispid 73;
    function  GetADCValue: Integer; dispid 50;
    property ADCValue: Integer readonly dispid 72;
    function  GetChannelsCount: Integer; dispid 75;
    function  SetActiveChannel: Integer; dispid 76;
    function  SetChannelMode: Integer; dispid 77;
    function  GetChannelParam: Integer; dispid 78;
    function  SetChannelParam: Integer; dispid 79;
    function  RestartChannel: Integer; dispid 80;
    function  Reset: Integer; dispid 81;
    function  GetActiveChannel: Integer; dispid 82;
    property CalibrationWeight: Double dispid 74;
    property PointNumber: Integer dispid 83;
    property ChannelNumber: Integer dispid 84;
    property ChannelON: WordBool dispid 85;
    property ChannelsCount: Integer readonly dispid 87;
    property ChannelDegree: Integer dispid 88;
    property ChannelFlags: Integer dispid 89;
    property ChannelMinWeight: Double dispid 90;
    property ChannelMaxTare: Double dispid 92;
    property ChannelRange1: Double dispid 93;
    property ChannelRange2: Double dispid 96;
    property ChannelRange3: Double dispid 97;
    property ChannelDiscreteness1: Double dispid 98;
    property ChannelDiscreteness2: Double dispid 99;
    property ChannelDiscreteness3: Double dispid 100;
    property ChannelDiscreteness4: Double dispid 101;
    property ChannelPointsCount: Integer dispid 102;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TDrvSM
// Help String      : TDrvSM Object
// Default Interface: IDrvSM
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
  TDrvSM = class(TOleControl)
  private
    FIntf: IDrvSM;
    function  GetControlInterface: IDrvSM;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function  Connect: Integer;
    function  Disconnect: Integer;
    function  ShowProperties: Integer;
    function  AddLD: Integer;
    function  DeleteLD: Integer;
    function  EnumLD: Integer;
    function  GetActiveLD: Integer;
    function  GetCountLD: Integer;
    function  GetParamLD: Integer;
    function  SetActiveLD: Integer;
    function  SetParamLD: Integer;
    function  GetDeviceMetrics: Integer;
    function  SetMode: Integer;
    function  KeyEmulation: Integer;
    function  GetMode: Integer;
    function  SetExchangeParam: Integer;
    function  GetExchangeParam: Integer;
    function  SetPassword: Integer;
    function  SetZero: Integer;
    function  SetTare: Integer;
    function  SetTareValue: Integer;
    function  GetChannelStatus: Integer;
    function  SetFixedPoint: Integer;
    function  GetFixedPoint: Integer;
    function  StartCalibration: Integer;
    function  GetCalibrationStatus: Integer;
    function  BreakCalibration: Integer;
    function  LockKeyboard: Integer;
    function  GetADCValue: Integer;
    function  GetChannelsCount: Integer;
    function  SetActiveChannel: Integer;
    function  SetChannelMode: Integer;
    function  GetChannelParam: Integer;
    function  SetChannelParam: Integer;
    function  RestartChannel: Integer;
    function  Reset: Integer;
    function  GetActiveChannel: Integer;
    property  ControlInterface: IDrvSM read GetControlInterface;
    property  DefaultInterface: IDrvSM read GetControlInterface;
    property Connected: WordBool index 12 read GetWordBoolProp;
    property ResultCode: Integer index 13 read GetIntegerProp;
    property ResultCodeDescription: WideString index 14 read GetWideStringProp;
    property FileVersionLS: Integer index 15 read GetIntegerProp;
    property FileVersionMS: Integer index 16 read GetIntegerProp;
    property UCodePage: Integer index 24 read GetIntegerProp;
    property UDescription: WideString index 25 read GetWideStringProp;
    property UMajorProtocolVersion: Integer index 26 read GetIntegerProp;
    property UMinorProtocolVersion: Integer index 27 read GetIntegerProp;
    property UMajorType: Integer index 28 read GetIntegerProp;
    property UMinorType: Integer index 29 read GetIntegerProp;
    property UModel: Integer index 30 read GetIntegerProp;
    property Key: Integer index 51 write SetIntegerProp;
    property NewPassword: Integer index 60 write SetIntegerProp;
    property Weight: Double index 64 read GetDoubleProp;
    property FixedPointStatus: Integer index 61 read GetIntegerProp;
    property Input: WideString index 70 read GetWideStringProp;
    property Output: WideString index 71 read GetWideStringProp;
    property LDCount: Integer index 73 read GetIntegerProp;
    property ADCValue: Integer index 72 read GetIntegerProp;
    property ChannelsCount: Integer index 87 read GetIntegerProp;
  published
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property LDBaudRate: Integer index 17 read GetIntegerProp write SetIntegerProp stored False;
    property LDTimeout: Integer index 18 read GetIntegerProp write SetIntegerProp stored False;
    property LDComNumber: Integer index 19 read GetIntegerProp write SetIntegerProp stored False;
    property LDName: WideString index 20 read GetWideStringProp write SetWideStringProp stored False;
    property LDNumber: Integer index 21 read GetIntegerProp write SetIntegerProp stored False;
    property LDIndex: Integer index 22 read GetIntegerProp write SetIntegerProp stored False;
    property LockKeyboardON: WordBool index 52 read GetWordBoolProp write SetWordBoolProp stored False;
    property Mode: Integer index 54 read GetIntegerProp write SetIntegerProp stored False;
    property Timeout: Integer index 55 read GetIntegerProp write SetIntegerProp stored False;
    property BaudRate: Integer index 56 read GetIntegerProp write SetIntegerProp stored False;
    property ComNumber: Integer index 57 read GetIntegerProp write SetIntegerProp stored False;
    property Password: Integer index 59 read GetIntegerProp write SetIntegerProp stored False;
    property WeightChannelMode: Integer index 62 read GetIntegerProp write SetIntegerProp stored False;
    property Tare: Double index 63 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelMaxWeight: Double index 65 read GetDoubleProp write SetDoubleProp stored False;
    property CalibrationWeight: Double index 74 read GetDoubleProp write SetDoubleProp stored False;
    property PointNumber: Integer index 83 read GetIntegerProp write SetIntegerProp stored False;
    property ChannelNumber: Integer index 84 read GetIntegerProp write SetIntegerProp stored False;
    property ChannelON: WordBool index 85 read GetWordBoolProp write SetWordBoolProp stored False;
    property ChannelDegree: Integer index 88 read GetIntegerProp write SetIntegerProp stored False;
    property ChannelFlags: Integer index 89 read GetIntegerProp write SetIntegerProp stored False;
    property ChannelMinWeight: Double index 90 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelMaxTare: Double index 92 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelRange1: Double index 93 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelRange2: Double index 96 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelRange3: Double index 97 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelDiscreteness1: Double index 98 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelDiscreteness2: Double index 99 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelDiscreteness3: Double index 100 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelDiscreteness4: Double index 101 read GetDoubleProp write SetDoubleProp stored False;
    property ChannelPointsCount: Integer index 102 read GetIntegerProp write SetIntegerProp stored False;
  end;

procedure Register;

implementation

uses ComObj;

procedure TDrvSM.InitControlData;
const
  CLicenseKey: array[0..38] of Word = ( $007B, $0042, $0034, $0033, $0032, $0041, $0033, $0033, $0039, $002D, $0033
    , $0046, $0039, $0044, $002D, $0034, $0036, $0043, $0030, $002D, $0042
    , $0042, $0042, $0045, $002D, $0030, $0032, $0044, $0041, $0037, $0034
    , $0034, $0036, $0039, $0043, $0039, $0042, $007D, $0000);
  CControlData: TControlData2 = (
    ClassID: '{B432A339-3F9D-46C0-BBBE-02DA74469C9B}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: @CLicenseKey;
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TDrvSM.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IDrvSM;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TDrvSM.GetControlInterface: IDrvSM;
begin
  CreateControl;
  Result := FIntf;
end;

function  TDrvSM.Connect: Integer;
begin
  Result := DefaultInterface.Connect;
end;

function  TDrvSM.Disconnect: Integer;
begin
  Result := DefaultInterface.Disconnect;
end;

function  TDrvSM.ShowProperties: Integer;
begin
  Result := DefaultInterface.ShowProperties;
end;

function  TDrvSM.AddLD: Integer;
begin
  Result := DefaultInterface.AddLD;
end;

function  TDrvSM.DeleteLD: Integer;
begin
  Result := DefaultInterface.DeleteLD;
end;

function  TDrvSM.EnumLD: Integer;
begin
  Result := DefaultInterface.EnumLD;
end;

function  TDrvSM.GetActiveLD: Integer;
begin
  Result := DefaultInterface.GetActiveLD;
end;

function  TDrvSM.GetCountLD: Integer;
begin
  Result := DefaultInterface.GetCountLD;
end;

function  TDrvSM.GetParamLD: Integer;
begin
  Result := DefaultInterface.GetParamLD;
end;

function  TDrvSM.SetActiveLD: Integer;
begin
  Result := DefaultInterface.SetActiveLD;
end;

function  TDrvSM.SetParamLD: Integer;
begin
  Result := DefaultInterface.SetParamLD;
end;

function  TDrvSM.GetDeviceMetrics: Integer;
begin
  Result := DefaultInterface.GetDeviceMetrics;
end;

function  TDrvSM.SetMode: Integer;
begin
  Result := DefaultInterface.SetMode;
end;

function  TDrvSM.KeyEmulation: Integer;
begin
  Result := DefaultInterface.KeyEmulation;
end;

function  TDrvSM.GetMode: Integer;
begin
  Result := DefaultInterface.GetMode;
end;

function  TDrvSM.SetExchangeParam: Integer;
begin
  Result := DefaultInterface.SetExchangeParam;
end;

function  TDrvSM.GetExchangeParam: Integer;
begin
  Result := DefaultInterface.GetExchangeParam;
end;

function  TDrvSM.SetPassword: Integer;
begin
  Result := DefaultInterface.SetPassword;
end;

function  TDrvSM.SetZero: Integer;
begin
  Result := DefaultInterface.SetZero;
end;

function  TDrvSM.SetTare: Integer;
begin
  Result := DefaultInterface.SetTare;
end;

function  TDrvSM.SetTareValue: Integer;
begin
  Result := DefaultInterface.SetTareValue;
end;

function  TDrvSM.GetChannelStatus: Integer;
begin
  Result := DefaultInterface.GetChannelStatus;
end;

function  TDrvSM.SetFixedPoint: Integer;
begin
  Result := DefaultInterface.SetFixedPoint;
end;

function  TDrvSM.GetFixedPoint: Integer;
begin
  Result := DefaultInterface.GetFixedPoint;
end;

function  TDrvSM.StartCalibration: Integer;
begin
  Result := DefaultInterface.StartCalibration;
end;

function  TDrvSM.GetCalibrationStatus: Integer;
begin
  Result := DefaultInterface.GetCalibrationStatus;
end;

function  TDrvSM.BreakCalibration: Integer;
begin
  Result := DefaultInterface.BreakCalibration;
end;

function  TDrvSM.LockKeyboard: Integer;
begin
  Result := DefaultInterface.LockKeyboard;
end;

function  TDrvSM.GetADCValue: Integer;
begin
  Result := DefaultInterface.GetADCValue;
end;

function  TDrvSM.GetChannelsCount: Integer;
begin
  Result := DefaultInterface.GetChannelsCount;
end;

function  TDrvSM.SetActiveChannel: Integer;
begin
  Result := DefaultInterface.SetActiveChannel;
end;

function  TDrvSM.SetChannelMode: Integer;
begin
  Result := DefaultInterface.SetChannelMode;
end;

function  TDrvSM.GetChannelParam: Integer;
begin
  Result := DefaultInterface.GetChannelParam;
end;

function  TDrvSM.SetChannelParam: Integer;
begin
  Result := DefaultInterface.SetChannelParam;
end;

function  TDrvSM.RestartChannel: Integer;
begin
  Result := DefaultInterface.RestartChannel;
end;

function  TDrvSM.Reset: Integer;
begin
  Result := DefaultInterface.Reset;
end;

function  TDrvSM.GetActiveChannel: Integer;
begin
  Result := DefaultInterface.GetActiveChannel;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TDrvSM]);
end;

end.
