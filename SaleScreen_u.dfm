object frmSales: TfrmSales
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Sales'
  ClientHeight = 615
  ClientWidth = 1121
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmHead
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSubTotal: TLabel
    Left = 752
    Top = 64
    Width = 114
    Height = 60
    Caption = 'Sub Total '#13#10'R0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblVat: TLabel
    Left = 753
    Top = 152
    Width = 113
    Height = 60
    Caption = 'VAT 15 %'#13#10'R 0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTotal: TLabel
    Left = 753
    Top = 234
    Width = 74
    Height = 60
    Caption = 'Total'#13#10'R 0.00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object edtBarcode: TEdit
    Left = 8
    Top = 8
    Width = 1089
    Height = 38
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 0
    TextHint = 'Barcode'
    OnKeyPress = edtBarcodeKeyPress
  end
  object sgdSales: TStringGrid
    Left = 8
    Top = 64
    Width = 609
    Height = 537
    BevelWidth = 3
    ColCount = 3
    DefaultColWidth = 200
    DrawingStyle = gdsGradient
    FixedCols = 0
    RowCount = 3
    GradientEndColor = clSilver
    GridLineWidth = 2
    ScrollBars = ssVertical
    TabOrder = 1
    ColWidths = (
      200
      200
      200)
    RowHeights = (
      24
      24
      24)
  end
  object btnEndSale: TBitBtn
    Left = 752
    Top = 536
    Width = 249
    Height = 65
    Caption = 'End Sale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnEndSaleClick
  end
  object btnCancelSale: TBitBtn
    Left = 753
    Top = 448
    Width = 248
    Height = 65
    Caption = 'Cancel Sale'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnCancelSaleClick
  end
  object qrySales: TADOQuery
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Stock')
    Left = 65440
    Top = 560
  end
  object tblStock: TADOTable
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Stock'
    Left = 640
    Top = 536
  end
  object mmHead: TMainMenu
    Left = 680
    Top = 536
    object File1: TMenuItem
      Caption = 'File'
      object About1: TMenuItem
        Caption = 'About'
        OnClick = About1Click
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Actions1: TMenuItem
      Caption = 'Actions'
      object Logout1: TMenuItem
        Caption = 'Logout'
        OnClick = Logout1Click
      end
    end
  end
end
