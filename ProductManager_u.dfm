object frmProductManager: TfrmProductManager
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Product Manager'
  ClientHeight = 537
  ClientWidth = 1125
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdProductView: TDBGrid
    Left = 8
    Top = 24
    Width = 753
    Height = 489
    DataSource = dsProducts
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnAddProduct: TBitBtn
    Left = 773
    Top = 24
    Width = 344
    Height = 41
    Caption = 'Add Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnAddProductClick
  end
  object btnEditProduct: TBitBtn
    Left = 773
    Top = 88
    Width = 344
    Height = 41
    Caption = 'Edit Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnEditProductClick
  end
  object btnDeleteProduct: TBitBtn
    Left = 773
    Top = 151
    Width = 344
    Height = 41
    Caption = 'Delete Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnDeleteProductClick
  end
  object btnExportProducts: TBitBtn
    Left = 773
    Top = 207
    Width = 344
    Height = 41
    Caption = 'Export All Products'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnExportProductsClick
  end
  object btnGeneratReport: TBitBtn
    Left = 773
    Top = 263
    Width = 344
    Height = 41
    Caption = 'Generate Report'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnGeneratReportClick
  end
  object qryProducts: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT Barcode,ProductName,ProductCost,ProductSellPrice FROM Sto' +
        'ck')
    Left = 776
    Top = 312
  end
  object dsProducts: TDataSource
    DataSet = qryProducts
    Left = 776
    Top = 368
  end
  object tblDeleteProduct: TADOTable
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Stock'
    Left = 776
    Top = 416
  end
end
