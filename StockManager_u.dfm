object frmStockManager: TfrmStockManager
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Stock Manager'
  ClientHeight = 599
  ClientWidth = 1291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblFilter: TLabel
    Left = 1048
    Top = 240
    Width = 73
    Height = 40
    Caption = 'Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblShowProducts: TLabel
    Left = 879
    Top = 296
    Width = 299
    Height = 20
    Caption = 'Show only product with stock underneath '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object dbgrdStockView: TDBGrid
    Left = 8
    Top = 40
    Width = 849
    Height = 551
    DataSource = dsStock
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnAddStock: TBitBtn
    Left = 879
    Top = 40
    Width = 394
    Height = 41
    Caption = 'Add Stock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnAddStockClick
  end
  object btnCorrectStock: TBitBtn
    Left = 879
    Top = 104
    Width = 394
    Height = 41
    Caption = 'Stock Correction'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnCorrectStockClick
  end
  object btnViewAvailableStock: TBitBtn
    Left = 879
    Top = 168
    Width = 394
    Height = 41
    Caption = 'View Available Stock For Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnViewAvailableStockClick
  end
  object seFilterByAmount: TSpinEdit
    Left = 1184
    Top = 296
    Width = 89
    Height = 22
    MaxValue = 1000
    MinValue = 1
    TabOrder = 4
    Value = 1
  end
  object btnResetFilter: TBitBtn
    Left = 879
    Top = 407
    Width = 394
    Height = 41
    Caption = 'Reset Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnResetFilterClick
  end
  object btnFilter: TBitBtn
    Left = 879
    Top = 344
    Width = 394
    Height = 41
    Caption = 'Apply Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnFilterClick
  end
  object btnExportStock: TBitBtn
    Left = 879
    Top = 463
    Width = 394
    Height = 41
    Caption = 'Export Stock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btnExportStockClick
  end
  object btnGenerateReport: TBitBtn
    Left = 879
    Top = 519
    Width = 394
    Height = 41
    Caption = 'Generate Report'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = btnGenerateReportClick
  end
  object dsStock: TDataSource
    DataSet = qryStockFilter
    Left = 896
    Top = 488
  end
  object qryStockFilter: TADOQuery
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'Select [Barcode],[Product-Name],[Product-Amount-Available] from ' +
        'Stock')
    Left = 992
    Top = 488
  end
end
