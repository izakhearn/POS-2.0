object frmLog: TfrmLog
  Left = 0
  Top = 0
  Caption = 'Live Log View'
  ClientHeight = 493
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmoLogView: TMemo
    Left = 0
    Top = 0
    Width = 601
    Height = 489
    Lines.Strings = (
      'mmoLogView')
    ReadOnly = True
    TabOrder = 0
  end
  object tmrUpdateLog: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = tmrUpdateLogTimer
    Left = 464
    Top = 432
  end
  object tmrScroll: TTimer
    Enabled = False
    Interval = 1
    OnTimer = tmrScrollTimer
    Left = 352
    Top = 216
  end
end
