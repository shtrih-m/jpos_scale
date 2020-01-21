object frmLD: TfrmLD
  Left = 477
  Top = 257
  BorderStyle = bsDialog
  Caption = 'Работа с логическими устройствами'
  ClientHeight = 298
  ClientWidth = 526
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    000000000000000000F000000000000000000000000000000F0F000000000000
    0000000000000000FF0FF0000000000000000000000000000FF00F0000000000
    0000000000000000F0FF0FF0000000000000000000000000FF0F0FF000000000
    00000000000000FF0F0000FF0000000000000000000000F00FF000FF00000000
    00000000000000F000FF000FF000000000000000000000F0000FF00FFF00000F
    0F000000000000FF000FF000FF0000F0F00FF0000000000F0000FF000F0000F0
    00F00FF0F00FF00FF0000FF00FFF000FFFF0FFF0F0F0F00FFF0000FF00FF0000
    000FFF0FF0F0FF00FFFF00FFF0FF000000FF0FFF0FF0FF00F00FF00FFF000000
    000F0FFF0FFF0FF0FF0FFF00FF0000000000F0F0FFFF0FF00FF0FFF00FFF0000
    0000000FFF00FFFF0FFF0FFF00F00000000000F00FF0F0FFF0FF00FF00000000
    00000F00FFF0FF00FF0FF00FF00000000000000F00FF0FF0FF0FFF00F0000000
    000000000FFFF0FF0FF0FF00000000000000000000F0F0FF0F000FF000000000
    00000000FFFFFF0FF0F0000000000000000000FFFFF00FF0F000000000000000
    000000FFF00000000000000000000000000000000F000000000000000000FFFF
    FFFFFFFFFDFFFFFFFDFFFFFFF8FFFFFFF07FFFFFF03FFFFFE03FFFFFE01FFFFF
    C00FFFFFC00FC1FF800781FF800300FF0003007F0001001E0001000000010000
    000080000000C0000000E0000000F0000000F8000000FC000000FE000000FF00
    0001FF000001FF800007FFC00007FFC0003FFF8001FFFF0003FFFF0003FF}
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 400
    Top = 104
    Width = 121
    Height = 2
  end
  object btnClose: TButton
    Left = 397
    Top = 112
    Width = 124
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Закрыть'
    ModalResult = 1
    TabOrder = 0
  end
  object lwLD: TListView
    Left = 8
    Top = 0
    Width = 385
    Height = 137
    Columns = <
      item
        Caption = 'Номер'
      end
      item
        Alignment = taCenter
        AutoSize = True
        Caption = 'Название'
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDblClick = lwLDDblClick
    OnSelectItem = lwLDSelectItem
  end
  object btnAddLD: TButton
    Left = 397
    Top = 8
    Width = 124
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Добавить'
    TabOrder = 2
    OnClick = btnAddLDClick
  end
  object btnDelLD: TButton
    Left = 397
    Top = 72
    Width = 124
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Удалить'
    TabOrder = 3
    OnClick = btnDelLDClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 144
    Width = 513
    Height = 121
    Caption = 'Параметры'
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 50
      Height = 13
      Caption = 'Название'
    end
    object Label2: TLabel
      Left = 8
      Top = 40
      Width = 47
      Height = 13
      Caption = 'Сом-порт'
    end
    object Label3: TLabel
      Left = 8
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Скорость'
    end
    object Label8: TLabel
      Left = 8
      Top = 88
      Width = 43
      Height = 13
      Caption = 'Таймаут'
    end
    object edName: TEdit
      Left = 72
      Top = 16
      Width = 257
      Height = 21
      TabOrder = 0
    end
    object cbCNLD: TComboBox
      Left = 72
      Top = 40
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        'Сом1'
        'Сом2'
        'Сом3'
        'Сом4'
        'Сом5'
        'Сом6'
        'Сом7'
        'Сом8'
        'Сом9'
        'Сом10'
        'Сом11'
        'Сом12'
        'Сом13'
        'Сом14'
        'Сом15'
        'Сом16'
        'Сом17'
        'Сом18'
        'Сом19'
        'Сом20'
        'Сом21'
        'Сом22'
        'Сом23'
        'Сом24'
        'Сом25'
        'Сом26'
        'Сом27'
        'Сом28'
        'Сом29'
        'Сом30'
        'Сом31'
        'Сом32')
    end
    object cbBDLD: TComboBox
      Left = 72
      Top = 64
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        '2400'
        '4800'
        '9600'
        '19200'
        '38400'
        '57600'
        '115200')
    end
    object seTimeout: TSpinEdit
      Left = 72
      Top = 88
      Width = 97
      Height = 22
      MaxLength = 3
      MaxValue = 255
      MinValue = 1
      TabOrder = 3
      Value = 1
      OnChange = seTimeoutChange
    end
    object Button2: TButton
      Left = 336
      Top = 16
      Width = 169
      Height = 23
      Caption = 'Получить текущие параметры'
      TabOrder = 4
      OnClick = Button2Click
    end
  end
  object edError: TEdit
    Left = 8
    Top = 272
    Width = 513
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 5
  end
  object Button1: TButton
    Left = 397
    Top = 40
    Width = 124
    Height = 25
    Caption = 'Изменить'
    TabOrder = 6
    OnClick = Button1Click
  end
end
