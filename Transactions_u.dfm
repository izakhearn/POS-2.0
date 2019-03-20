object frmTransactions: TfrmTransactions
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Transactions'
  ClientHeight = 644
  ClientWidth = 1106
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTransactions: TLabel
    Left = 144
    Top = 5
    Width = 319
    Height = 50
    Caption = 'Past Transactions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 50
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblFilterBy: TLabel
    Left = 896
    Top = 219
    Width = 98
    Height = 30
    Caption = 'Filter By '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTo: TLabel
    Left = 911
    Top = 311
    Width = 29
    Height = 30
    Caption = 'To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnViewTransactionDetails: TBitBtn
    Left = 769
    Top = 56
    Width = 321
    Height = 41
    Caption = 'View Transaction Details'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnViewTransactionDetailsClick
  end
  object dbgrdTransactions: TDBGrid
    Left = 8
    Top = 61
    Width = 755
    Height = 580
    DataSource = dsTransactions
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnLookupEmployee: TBitBtn
    Left = 769
    Top = 103
    Width = 321
    Height = 41
    Caption = 'Look Up Employee by ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnLookupEmployeeClick
  end
  object dtpStart: TDateTimePicker
    Left = 769
    Top = 311
    Width = 104
    Height = 30
    Date = 43219.753119814820000000
    Time = 43219.753119814820000000
    TabOrder = 3
  end
  object dtpEnd: TDateTimePicker
    Left = 977
    Top = 311
    Width = 104
    Height = 30
    Date = 43219.753119814820000000
    Time = 43219.753119814820000000
    TabOrder = 4
  end
  object btnFilter: TBitBtn
    Left = 769
    Top = 368
    Width = 312
    Height = 41
    Caption = 'Apply Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnFilterClick
  end
  object btnResetFilter: TBitBtn
    Left = 769
    Top = 415
    Width = 312
    Height = 41
    Caption = 'Reset Filter'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = btnResetFilterClick
  end
  object btnExportTransactions: TBitBtn
    Left = 769
    Top = 462
    Width = 312
    Height = 41
    Caption = 'Export'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
    OnClick = btnExportTransactionsClick
  end
  object btnGenerateReport: TBitBtn
    Left = 769
    Top = 509
    Width = 312
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
  object qryTransactions: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *  FROM Transactions ORDER BY ID DESC ')
    Left = 912
    Top = 544
  end
  object dsTransactions: TDataSource
    DataSet = qryTransactions
    Left = 1008
    Top = 544
  end
  object qryEmployeeInfo: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Employees')
    Left = 816
    Top = 544
  end
  object tblTransactionDetails: TADOTable
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Transactions'
    Left = 816
    Top = 592
  end
end
