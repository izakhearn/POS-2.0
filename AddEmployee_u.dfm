object frmAddEmployee: TfrmAddEmployee
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Add Employee'
  ClientHeight = 299
  ClientWidth = 408
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
  object lbledtPassword: TLabeledEdit
    Left = 216
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    PasswordChar = '*'
    TabOrder = 0
  end
  object lbledtName: TLabeledEdit
    Left = 72
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 1
  end
  object lbledtSurname: TLabeledEdit
    Left = 216
    Top = 96
    Width = 121
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Surname'
    TabOrder = 2
  end
  object lbledtPhone: TLabeledEdit
    Left = 216
    Top = 136
    Width = 121
    Height = 21
    EditLabel.Width = 70
    EditLabel.Height = 13
    EditLabel.Caption = 'Phone Number'
    NumbersOnly = True
    TabOrder = 3
  end
  object lbledtEmail: TLabeledEdit
    Left = 72
    Top = 136
    Width = 121
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'E-Mail'
    TabOrder = 4
  end
  object btnSubmit: TButton
    Left = 168
    Top = 208
    Width = 75
    Height = 21
    Caption = '&Submit'
    TabOrder = 5
    OnClick = btnSubmitClick
  end
  object lbledtUsername: TLabeledEdit
    Left = 72
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Username'
    TabOrder = 6
  end
  object chkAdmin: TCheckBox
    Left = 168
    Top = 163
    Width = 97
    Height = 31
    Caption = '    Admin'
    TabOrder = 7
  end
  object qryAddEmployee: TADOQuery
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Employees')
    Left = 328
    Top = 256
  end
  object tblAddEmployee: TADOTable
    Active = True
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Employees'
    Left = 248
    Top = 232
  end
end
