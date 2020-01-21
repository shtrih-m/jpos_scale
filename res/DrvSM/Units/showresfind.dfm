object frmFindDevice: TfrmFindDevice
  Left = 402
  Top = 114
  Width = 555
  Height = 463
  BorderIcons = []
  Caption = 'Поиск оборудования'
  Color = clBtnFace
  Constraints.MinHeight = 290
  Constraints.MinWidth = 330
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 379
    Width = 547
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button2: TButton
      Left = 282
      Top = 12
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Начать поиск'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 373
      Top = 12
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Прервать'
      Enabled = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object Animate1: TAnimate
      Left = 13
      Top = 8
      Width = 36
      Height = 33
      Active = False
      AutoSize = False
      CommonAVI = aviFindComputer
      StopFrame = 8
      Visible = False
    end
    object Button3: TButton
      Left = 461
      Top = 12
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Закрыть'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 547
    Height = 379
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'RS-232'
      object ListView1: TListView
        Left = 0
        Top = 0
        Width = 539
        Height = 351
        Align = alClient
        Columns = <
          item
            Caption = 'Номер Сом-порта'
            Width = 107
          end
          item
            Alignment = taCenter
            Caption = 'Cкорость'
            Width = 80
          end
          item
            AutoSize = True
            Caption = 'Название устройства'
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = ListView1DblClick
      end
    end
  end
end
