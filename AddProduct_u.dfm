object frmAddProduct: TfrmAddProduct
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Add Porduct'
  ClientHeight = 380
  ClientWidth = 521
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddProduct: TBitBtn
    Left = 16
    Top = 289
    Width = 225
    Height = 65
    Caption = 'Add Product'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnAddProductClick
  end
  object btnCancel: TBitBtn
    Left = 280
    Top = 289
    Width = 225
    Height = 65
    Caption = 'Cancel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object lbledtBarcode: TLabeledEdit
    Left = 16
    Top = 40
    Width = 225
    Height = 33
    EditLabel.Width = 155
    EditLabel.Height = 25
    EditLabel.Caption = 'Product Barcode'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = 25
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object lbledtProductName: TLabeledEdit
    Left = 280
    Top = 40
    Width = 225
    Height = 33
    EditLabel.Width = 133
    EditLabel.Height = 25
    EditLabel.Caption = 'Product Name'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = 25
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object lbledtProductCost: TLabeledEdit
    Left = 16
    Top = 120
    Width = 225
    Height = 33
    EditLabel.Width = 172
    EditLabel.Height = 25
    EditLabel.Caption = 'Product Cost Price'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = 25
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object lbledtProductSell: TLabeledEdit
    Left = 280
    Top = 120
    Width = 225
    Height = 33
    EditLabel.Width = 165
    EditLabel.Height = 25
    EditLabel.Caption = 'Product Sell Price'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = 25
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object lbledtProductAmount: TLabeledEdit
    Left = 152
    Top = 200
    Width = 225
    Height = 33
    EditLabel.Width = 210
    EditLabel.Height = 25
    EditLabel.Caption = 'Product Starting Stock'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = 25
    EditLabel.Font.Name = 'Tahoma'
    EditLabel.Font.Style = []
    EditLabel.ParentFont = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object qryAddProduct: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * From Stock')
    Left = 24
    Top = 200
  end
  object tblAddProduct: TADOTable
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Stock'
    Left = 104
    Top = 208
  end
end
