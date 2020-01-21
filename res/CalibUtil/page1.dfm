object frmPage1: TfrmPage1
  Left = 250
  Top = 97
  Width = 449
  Height = 358
  Caption = 'frmPage1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 418
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      '  Для начала процесса градуировки необходимо установить связь с ' +
      'весовой ячейкой.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 425
    Height = 73
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      '  Выберите номер СОМ-порта, скорость и пароль. Если параметры св' +
      'язи неизвестны нажмите кнопку "Настройка связи" для поиска устро' +
      'йства и установления соединения.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 16
    Top = 154
    Width = 53
    Height = 13
    Caption = 'СОМ- порт'
  end
  object Label4: TLabel
    Left = 16
    Top = 186
    Width = 48
    Height = 13
    Caption = 'Скорость'
  end
  object Bevel1: TBevel
    Left = 232
    Top = 152
    Width = 9
    Height = 89
    Shape = bsLeftLine
  end
  object Label5: TLabel
    Left = 16
    Top = 298
    Width = 409
    Height = 31
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 'Для продолжения нажмите кнопку "Далее".'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label6: TLabel
    Left = 16
    Top = 219
    Width = 38
    Height = 13
    Caption = 'Пароль'
  end
  object ComboBox1: TComboBox
    Left = 104
    Top = 152
    Width = 105
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    OnChange = ComboBox1Change
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
  object ComboBox2: TComboBox
    Left = 104
    Top = 184
    Width = 105
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox2Change
    Items.Strings = (
      '2400'
      '4800'
      '9600'
      '19200'
      '38400'
      '57600'
      '115200')
  end
  object Button1: TButton
    Left = 256
    Top = 152
    Width = 137
    Height = 25
    Caption = 'Настройка связи'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 104
    Top = 216
    Width = 105
    Height = 21
    MaxLength = 4
    PasswordChar = '*'
    TabOrder = 3
    Text = '0'
    OnChange = Edit1Change
    OnKeyPress = Edit1KeyPress
  end
end
