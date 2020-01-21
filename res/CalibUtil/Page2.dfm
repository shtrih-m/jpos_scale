object frmPage2: TfrmPage2
  Tag = 1
  Left = 40
  Top = 370
  Width = 447
  Height = 361
  Caption = 'frmPage2'
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
    Width = 425
    Height = 60
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 
      '  Связь установлена. Выберите из списка весовой канал, который н' +
      'еобходимо градуировать.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 16
    Top = 301
    Width = 411
    Height = 26
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 
      'Для продолжения нажмите кнопку "Далее", для возврата к предыдуще' +
      'му шагу - "Назад".'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 25
    Top = 69
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = 'Устройство:'
  end
  object Label3: TLabel
    Left = 96
    Top = 67
    Width = 29
    Height = 16
    Caption = '       '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 8
    Top = 88
    Width = 145
    Height = 209
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Memo1: TMemo
    Left = 160
    Top = 88
    Width = 273
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 424
    Top = 304
    Width = 9
    Height = 9
    Caption = 'Button1'
    TabOrder = 2
    Visible = False
  end
end
