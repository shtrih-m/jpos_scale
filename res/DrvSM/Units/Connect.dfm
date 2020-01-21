object frmConnect: TfrmConnect
  Left = 382
  Top = 120
  Width = 421
  Height = 238
  Caption = 'ВМ100'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = PropertyPageShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 176
    Top = 8
    Width = 233
    Height = 89
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 184
    Top = 40
    Width = 48
    Height = 13
    Caption = 'Скорость'
  end
  object Label1: TLabel
    Left = 184
    Top = 16
    Width = 34
    Height = 13
    Caption = 'Номер'
  end
  object Label3: TLabel
    Left = 184
    Top = 0
    Width = 98
    Height = 13
    Caption = 'Параметры RS-232'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 8
    Width = 161
    Height = 41
    Shape = bsFrame
  end
  object Label4: TLabel
    Left = 16
    Top = 0
    Width = 120
    Height = 13
    Caption = 'Логические устройства'
  end
  object Label5: TLabel
    Left = 272
    Top = 144
    Width = 38
    Height = 13
    Caption = 'Пароль'
  end
  object Label7: TLabel
    Left = 184
    Top = 64
    Width = 43
    Height = 13
    Caption = 'Таймаут'
  end
  object Button8: TButton
    Left = 240
    Top = 112
    Width = 169
    Height = 25
    Caption = 'О драйвере'
    TabOrder = 6
    OnClick = Button8Click
  end
  object btnFind: TButton
    Left = 112
    Top = 144
    Width = 121
    Height = 25
    Caption = 'Поиск оборудования'
    TabOrder = 8
    OnClick = btnFindClick
  end
  object btnConnect: TButton
    Left = 8
    Top = 144
    Width = 97
    Height = 25
    Caption = 'Проверка связи'
    TabOrder = 7
    OnClick = btnConnectClick
  end
  object btnSetBaudRate: TButton
    Left = 8
    Top = 112
    Width = 225
    Height = 25
    Caption = 'Установить скорость'
    TabOrder = 5
    OnClick = btnSetBaudRateClick
  end
  object cbBaudRate: TComboBox
    Left = 328
    Top = 40
    Width = 73
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 3
    Items.Strings = (
      '2400'
      '4800'
      '9600'
      '19200'
      '38400'
      '57600'
      '115200')
  end
  object cbComNumber: TComboBox
    Left = 328
    Top = 16
    Width = 73
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'Com1'
      'Com2'
      'Com3'
      'Com4'
      'Com5'
      'Com6'
      'Com7'
      'Com8'
      'Com9'
      'Com10'
      'Com11'
      'Com12'
      'Com13'
      'Com14'
      'Com15'
      'Com16'
      'Com17'
      'Com18'
      'Com19'
      'Com20'
      'Com21'
      'Com22'
      'Com23'
      'Com24'
      'Com25'
      'Com26'
      'Com27'
      'Com28'
      'Com29'
      'Com30'
      'Com31'
      'Com32')
  end
  object btnEditLD: TButton
    Left = 136
    Top = 16
    Width = 25
    Height = 22
    Caption = '...'
    TabOrder = 1
    OnClick = btnEditLDClick
  end
  object cbLD: TComboBox
    Left = 16
    Top = 16
    Width = 113
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = cbLDChange
  end
  object edError: TEdit
    Left = 8
    Top = 176
    Width = 401
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 10
  end
  object seTimeOut: TSpinEdit
    Left = 328
    Top = 64
    Width = 73
    Height = 22
    MaxLength = 3
    MaxValue = 255
    MinValue = 0
    TabOrder = 4
    Value = 50
  end
  object Edit1: TEdit
    Left = 328
    Top = 144
    Width = 81
    Height = 21
    MaxLength = 4
    PasswordChar = '*'
    TabOrder = 9
    OnExit = Edit1Exit
    OnKeyPress = Edit1KeyPress
  end
end
