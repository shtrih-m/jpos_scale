object frmPage2_5: TfrmPage2_5
  Tag = 2
  Left = 601
  Top = 377
  Width = 463
  Height = 344
  Caption = 'frmPage2_5'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 439
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = '  Выставление начального значения АЦП'
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
    Top = 168
    Width = 105
    Height = 16
    Anchors = [akLeft, akTop, akRight]
    Caption = '  Значение АЦП:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label4: TLabel
    Left = 8
    Top = 56
    Width = 439
    Height = 49
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Выставьте значение АЦП согласно документации на весовой модуль'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object Label5: TLabel
    Left = 16
    Top = 284
    Width = 423
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
  object Edit1: TEdit
    Left = 152
    Top = 168
    Width = 89
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
    Text = '0'
  end
  object Timer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerTimer
    Left = 352
    Top = 152
  end
end
