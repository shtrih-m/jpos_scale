object frmMain: TfrmMain
  Left = 484
  Top = 200
  BorderStyle = bsDialog
  Caption = #1064#1090#1088#1080#1093'-'#1052': '#1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1075#1088#1072#1076#1091#1080#1088#1086#1074#1082#1080' '#1074#1077#1089#1086#1074#1086#1081' '#1103#1095#1077#1081#1082#1080' '#1042#1052'-100'
  ClientHeight = 394
  ClientWidth = 501
  Color = clBtnFace
  Constraints.MinHeight = 350
  Constraints.MinWidth = 400
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    501
    394)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 407
    Top = 362
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1042#1099#1081#1090#1080
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 311
    Top = 362
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1044#1072#1083#1077#1077' >>'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 215
    Top = 362
    Width = 89
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '<< '#1053#1072#1079#1072#1076
    Enabled = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 501
    Height = 357
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 3
  end
end
