object frmTransactionsDetails: TfrmTransactionsDetails
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Transaction Details'
  ClientHeight = 579
  ClientWidth = 1126
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTransactionID: TLabel
    Left = 8
    Top = 32
    Width = 274
    Height = 40
    Caption = 'Transaction ID    : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblEmployeeID: TLabel
    Left = 8
    Top = 96
    Width = 279
    Height = 40
    Caption = 'Employee'#39's ID     : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTotalCost: TLabel
    Left = 8
    Top = 160
    Width = 279
    Height = 40
    Caption = 'Total Cost           : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblAmountPaid: TLabel
    Left = 8
    Top = 232
    Width = 276
    Height = 40
    Caption = 'Amount Paid       : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblAmountOfItems: TLabel
    Left = 8
    Top = 296
    Width = 277
    Height = 40
    Caption = 'Amount of Items : '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTransactionTime: TLabel
    Left = 8
    Top = 368
    Width = 289
    Height = 40
    Caption = 'Time of Transaction'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblTime: TLabel
    Left = 8
    Top = 432
    Width = 10
    Height = 40
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object sgdTransactionDetails: TStringGrid
    Left = 509
    Top = 8
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
    TabOrder = 0
    ColWidths = (
      200
      200
      200)
    RowHeights = (
      24
      24
      24)
  end
  object qryTransactionDetails: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *  FROM Transactions')
    Left = 272
    Top = 512
  end
end
