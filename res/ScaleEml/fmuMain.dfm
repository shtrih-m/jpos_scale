object fmMain: TfmMain
  Left = 394
  Top = 181
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1069#1084#1091#1083#1103#1090#1086#1088' '#1074#1077#1089#1086#1074
  ClientHeight = 160
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object gbSerialParams: TGroupBox
    Left = 8
    Top = 8
    Width = 241
    Height = 113
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1089#1074#1103#1079#1080
    TabOrder = 0
    object lblBaudRate: TLabel
      Left = 16
      Top = 48
      Width = 51
      Height = 13
      Caption = #1057#1082#1086#1088#1086#1089#1090#1100':'
    end
    object lblSerialPort: TLabel
      Left = 16
      Top = 24
      Width = 28
      Height = 13
      Caption = #1055#1086#1088#1090':'
    end
    object lblTimeout: TLabel
      Left = 16
      Top = 72
      Width = 46
      Height = 13
      Caption = #1058#1072#1081#1084#1072#1091#1090':'
    end
    object cbBaudRate: TComboBox
      Left = 120
      Top = 48
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '2400'
        '4800'
        '9600'
        '19200'
        '38400'
        '57600'
        '115200')
    end
    object cbSerialPort: TComboBox
      Left = 120
      Top = 24
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10'
        'COM11'
        'COM12'
        'COM13'
        'COM14'
        'COM15'
        'COM16'
        'COM17'
        'COM18'
        'COM19'
        'COM20'
        'COM21'
        'COM22'
        'COM23'
        'COM24'
        'COM25'
        'COM26'
        'COM27'
        'COM28'
        'COM29'
        'COM30'
        'COM31'
        'COM32')
    end
    object seTimeout: TSpinEdit
      Left = 120
      Top = 72
      Width = 113
      Height = 22
      MaxLength = 3
      MaxValue = 255
      MinValue = 0
      TabOrder = 2
      Value = 50
    end
  end
  object btnEnableDevice: TButton
    Left = 256
    Top = 16
    Width = 81
    Height = 25
    Caption = #1042#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 2
    OnClick = btnEnableDeviceClick
  end
  object btnClose: TButton
    Left = 256
    Top = 128
    Width = 81
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 4
    OnClick = btnCloseClick
  end
  object btnDisableDevice: TButton
    Left = 256
    Top = 48
    Width = 81
    Height = 25
    Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100
    TabOrder = 3
    OnClick = btnDisableDeviceClick
  end
  object edtStatus: TEdit
    Left = 8
    Top = 128
    Width = 241
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
end
