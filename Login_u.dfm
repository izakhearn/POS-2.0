object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Login'
  ClientHeight = 133
  ClientWidth = 263
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnLogin: TBitBtn
    Left = 8
    Top = 67
    Width = 243
    Height = 59
    Caption = 'Login'
    Constraints.MaxHeight = 100
    Constraints.MaxWidth = 486
    Constraints.MinHeight = 59
    Constraints.MinWidth = 243
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 40
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = btnLoginClick
  end
  object edtUsername: TEdit
    Left = 72
    Top = 0
    Width = 121
    Height = 21
    Constraints.MaxHeight = 35
    Constraints.MaxWidth = 242
    Constraints.MinHeight = 21
    Constraints.MinWidth = 121
    TabOrder = 1
    TextHint = 'Username'
  end
  object edtPassword: TEdit
    Left = 72
    Top = 40
    Width = 121
    Height = 21
    Constraints.MaxHeight = 35
    Constraints.MaxWidth = 242
    Constraints.MinHeight = 21
    Constraints.MinWidth = 121
    PasswordChar = '*'
    TabOrder = 2
    TextHint = 'Password'
    OnKeyPress = edtPasswordKeyPress
  end
  object qryLogin: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Employees')
    Left = 224
    Top = 56
  end
  object RESTClientLicenseCheck: TRESTClient
    BaseURL = 'http://izakwebdesigns.co.za/wp-json'
    Params = <>
    HandleRedirects = True
    Left = 456
    Top = 48
  end
  object RESTRequestLicenseCheck: TRESTRequest
    Accept = 'application/json'
    AcceptCharset = 'UTF-8'
    Client = RESTClientLicenseCheck
    Params = <
      item
        name = 'secret_key'
        Value = '5afdbc47037ee9.17105930'
      end
      item
        name = 'slm_action'
        Value = 'slm_activate'
      end
      item
        name = 'license_key'
        Value = '0'
      end
      item
        name = 'registered_domain'
        Value = ' '
      end>
    Response = RESTResponseLicenseCheck
    SynchronizedEvents = False
    Left = 448
    Top = 128
  end
  object RESTResponseLicenseCheck: TRESTResponse
    Left = 600
    Top = 128
  end
  object mmHead: TMainMenu
    Left = 40
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
  end
end
