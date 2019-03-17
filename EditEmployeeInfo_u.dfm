object frmEditEmployeeInfo: TfrmEditEmployeeInfo
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Edit Employee'
  ClientHeight = 285
  ClientWidth = 458
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblEditUser: TLabel
    Left = 8
    Top = 8
    Width = 8
    Height = 30
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbledtPassword: TLabeledEdit
    Left = 256
    Top = 88
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    PasswordChar = '*'
    TabOrder = 0
  end
  object lbledtName: TLabeledEdit
    Left = 112
    Top = 128
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 1
  end
  object lbledtSurname: TLabeledEdit
    Left = 256
    Top = 128
    Width = 121
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Surname'
    TabOrder = 2
  end
  object lbledtPhone: TLabeledEdit
    Left = 256
    Top = 168
    Width = 121
    Height = 21
    EditLabel.Width = 70
    EditLabel.Height = 13
    EditLabel.Caption = 'Phone Number'
    NumbersOnly = True
    TabOrder = 3
  end
  object lbledtEmail: TLabeledEdit
    Left = 112
    Top = 168
    Width = 121
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'E-Mail'
    TabOrder = 4
  end
  object btnSubmit: TButton
    Left = 208
    Top = 240
    Width = 75
    Height = 21
    Caption = '&Submit'
    TabOrder = 5
    OnClick = btnSubmitClick
  end
  object lbledtUsername: TLabeledEdit
    Left = 112
    Top = 88
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Username'
    TabOrder = 6
  end
  object chkAdmin: TCheckBox
    Left = 208
    Top = 195
    Width = 97
    Height = 31
    Caption = '    Admin'
    TabOrder = 7
  end
  object qryEditEmployee: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Employees')
    Left = 48
    Top = 232
  end
  object tblEmployeeInfo: TADOTable
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Employees'
    Left = 112
    Top = 232
  end
end
