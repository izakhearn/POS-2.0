object frmDBInfo: TfrmDBInfo
  Left = 0
  Top = 0
  Caption = 'Database Connection Info'
  ClientHeight = 176
  ClientWidth = 275
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object edtDatabaseName: TLabeledEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 76
    EditLabel.Height = 13
    EditLabel.Caption = 'Database Name'
    TabOrder = 0
  end
  object edtServerAddress: TLabeledEdit
    Left = 143
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 84
    EditLabel.Height = 13
    EditLabel.Caption = 'Database Server '
    TabOrder = 1
  end
  object edtDBUsername: TLabeledEdit
    Left = 16
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 97
    EditLabel.Height = 13
    EditLabel.Caption = 'Database Username'
    TabOrder = 2
  end
  object edtDBPassword: TLabeledEdit
    Left = 143
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 95
    EditLabel.Height = 13
    EditLabel.Caption = 'Database Password'
    TabOrder = 3
  end
  object btnSaveDB: TButton
    Left = 56
    Top = 120
    Width = 171
    Height = 25
    Caption = 'Save Database Connection'
    TabOrder = 4
    OnClick = btnSaveDBClick
  end
end
