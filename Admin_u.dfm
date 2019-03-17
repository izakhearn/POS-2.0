object frmAdmin: TfrmAdmin
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Admin'
  ClientHeight = 561
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mmHead
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblChooseOption: TLabel
    Left = 8
    Top = 8
    Width = 586
    Height = 40
    Caption = 'Please click on the action you wish to do'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object btnViewTransactions: TButton
    Left = 136
    Top = 54
    Width = 297
    Height = 75
    Caption = 'View Transactions'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnViewTransactionsClick
  end
  object btnViewStock: TButton
    Left = 136
    Top = 135
    Width = 297
    Height = 75
    Caption = 'View Stock'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnViewStockClick
  end
  object btnManageProducts: TBitBtn
    Left = 136
    Top = 216
    Width = 297
    Height = 75
    Caption = 'Product Manager'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnManageProductsClick
  end
  object btnEmployeeManager: TBitBtn
    Left = 136
    Top = 297
    Width = 297
    Height = 75
    Caption = 'Employee Manager'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnEmployeeManagerClick
  end
  object btnViewReports: TBitBtn
    Left = 136
    Top = 459
    Width = 297
    Height = 75
    Caption = 'View Reports'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = btnViewReportsClick
  end
  object btnGiftCards: TBitBtn
    Left = 136
    Top = 378
    Width = 297
    Height = 75
    Caption = 'Gift Cards'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = btnGiftCardsClick
  end
  object mmHead: TMainMenu
    Left = 32
    Top = 48
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
