object frmAddCard: TfrmAddCard
  Left = 0
  Top = 0
  Caption = 'Add New Gift Card'
  ClientHeight = 254
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbledtCardNumber: TLabeledEdit
    Left = 24
    Top = 24
    Width = 257
    Height = 21
    EditLabel.Width = 63
    EditLabel.Height = 13
    EditLabel.Caption = 'Card Number'
    TabOrder = 0
    TextHint = 'Enter Card Number '
  end
  object lbledtOwnerName: TLabeledEdit
    Left = 24
    Top = 72
    Width = 257
    Height = 21
    EditLabel.Width = 92
    EditLabel.Height = 13
    EditLabel.Caption = 'Card Holders Name'
    TabOrder = 1
    TextHint = 'Enter Name of cardholder'
  end
  object lbledtCardOwnerSurname: TLabeledEdit
    Left = 24
    Top = 120
    Width = 257
    Height = 21
    EditLabel.Width = 107
    EditLabel.Height = 13
    EditLabel.Caption = 'Card Holders Surname'
    TabOrder = 2
    TextHint = 'Enter Surname Of Cardholder'
  end
  object lbledtStartingBal: TLabeledEdit
    Left = 24
    Top = 168
    Width = 257
    Height = 21
    EditLabel.Width = 111
    EditLabel.Height = 13
    EditLabel.Caption = 'Card'#39's Starting Balance'
    NumbersOnly = True
    TabOrder = 3
    TextHint = 'Enter Card'#39's starting balance'
  end
  object btnCreateCard: TButton
    Left = 24
    Top = 208
    Width = 257
    Height = 25
    Caption = 'Creare New Card'
    TabOrder = 4
    OnClick = btnCreateCardClick
  end
  object qryAddCard: TADOQuery
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *  FROM GiftCard')
    Left = 100
    Top = 240
  end
  object tblAddCard: TADOTable
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'GiftCard'
    Left = 32
    Top = 240
  end
end
