object frmGradEnter: TfrmGradEnter
  Left = 192
  Top = 116
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Вход в режим градуировки'
  ClientHeight = 196
  ClientWidth = 389
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 361
    Height = 105
    AutoSize = False
    Caption = 
      'Для входа в режим градуировки  необходимо  перевести градуировоч' +
      'ный переключатель весов в положение "ГРАДУИРОВКА" . Нажмите "ОК"' +
      '  для продолжения или "Отмена" для прекращения градуировки.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Button1: TButton
    Left = 152
    Top = 160
    Width = 97
    Height = 25
    Caption = 'ОК'
    ModalResult = 4
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 272
    Top = 160
    Width = 97
    Height = 25
    Caption = 'Отмена'
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 16
    Top = 160
    Width = 73
    Height = 21
    Color = clBtnFace
    MaxLength = 6
    PasswordChar = '*'
    TabOrder = 2
  end
end
