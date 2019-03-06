object frmGiftCards: TfrmGiftCards
  Left = 0
  Top = 0
  Caption = 'Gift Cards'
  ClientHeight = 492
  ClientWidth = 1017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdGiftCardList: TDBGrid
    Left = 8
    Top = 8
    Width = 689
    Height = 473
    DataSource = dsGiftCard
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnNewCard: TBitBtn
    Left = 712
    Top = 8
    Width = 297
    Height = 41
    Caption = 'Add New Card'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnNewCardClick
  end
  object btnEditCard: TBitBtn
    Left = 712
    Top = 63
    Width = 297
    Height = 41
    Caption = 'Edit Gift Card'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnEditCardClick
  end
  object btnReloadCard: TBitBtn
    Left = 712
    Top = 119
    Width = 297
    Height = 41
    Caption = 'Reload Card'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnReloadCardClick
  end
  object btnGenerateReport: TBitBtn
    Left = 712
    Top = 175
    Width = 297
    Height = 41
    Caption = 'Generate Report'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnGenerateReportClick
  end
  object dsGiftCard: TDataSource
    DataSet = qryGiftCard
    Left = 768
    Top = 432
  end
  object qryGiftCard: TADOQuery
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM GiftCard')
    Left = 824
    Top = 432
  end
  object tblCardBal: TADOTable
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'GiftCard'
    Left = 896
    Top = 432
  end
end
