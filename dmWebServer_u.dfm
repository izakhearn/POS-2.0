object dmHttpServer: TdmHttpServer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 157
  Width = 187
  object httpserverMain: TIdHTTPServer
    Active = True
    Bindings = <>
    DefaultPort = 8080
    OnCommandGet = httpserverMainCommandGet
    Left = 48
    Top = 64
  end
end
