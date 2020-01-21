object fmMain: TfmMain
  Left = 382
  Top = 256
  Width = 439
  Height = 337
  Caption = #1058#1077#1089#1090' '#1074#1077#1089#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    431
    310)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 8
    Top = 8
    Width = 313
    Height = 297
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object btnStart: TButton
    Left = 328
    Top = 8
    Width = 97
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 328
    Top = 40
    Width = 97
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = btnStopClick
  end
  object btnClose: TButton
    Left = 328
    Top = 280
    Width = 97
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 5
    OnClick = btnCloseClick
  end
  object btnDriver: TButton
    Left = 328
    Top = 248
    Width = 97
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1088#1072#1081#1074#1077#1088
    TabOrder = 4
    OnClick = btnDriverClick
  end
  object btnClear: TButton
    Left = 328
    Top = 72
    Width = 97
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 3
    OnClick = btnClearClick
  end
  object btnReadChannel: TButton
    Left = 328
    Top = 216
    Width = 97
    Height = 25
    Caption = #1050#1072#1085#1072#1083#1099
    TabOrder = 6
    OnClick = btnReadChannelClick
  end
end
