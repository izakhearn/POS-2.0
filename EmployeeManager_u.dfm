object frmEmployeeManager: TfrmEmployeeManager
  Left = 0
  Top = 0
  Caption = 'POS 2.0 Employee Manager'
  ClientHeight = 536
  ClientWidth = 915
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrdEmployees: TDBGrid
    Left = 8
    Top = 8
    Width = 537
    Height = 527
    DataSource = dsEmployees
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnEditEmployee: TBitBtn
    Left = 569
    Top = 8
    Width = 321
    Height = 41
    Caption = 'Edit Employee by ID'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = btnEditEmployeeClick
  end
  object btnDeleteEmployee: TBitBtn
    Left = 569
    Top = 119
    Width = 321
    Height = 41
    Caption = 'Delete Employee'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = btnDeleteEmployeeClick
  end
  object btnAddEmployee: TBitBtn
    Left = 569
    Top = 64
    Width = 321
    Height = 41
    Caption = 'Add Employee'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 30
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = btnAddEmployeeClick
  end
  object btnGenerateReport: TBitBtn
    Left = 569
    Top = 175
    Width = 321
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
  object qryEmployees: TADOQuery
    Connection = DataModule1.conMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT ID,  FullName, Surname FROM Employees')
    Left = 720
    Top = 464
  end
  object dsEmployees: TDataSource
    DataSet = qryEmployees
    Left = 640
    Top = 456
  end
  object tblDeleteEmployee: TADOTable
    Connection = DataModule1.conMain
    CursorType = ctStatic
    TableName = 'Employees'
    Left = 800
    Top = 464
  end
end
