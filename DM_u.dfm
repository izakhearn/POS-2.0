object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 167
  Width = 199
  object conMain: TADOConnection
    CommandTimeout = 120
    ConnectionString = 
      #39'Driver={MySQL ODBC 5.2 Driver};Server=localhost;Database=posl;U' +
      'ser=root;'
    ConnectionTimeout = 60
    ConnectOptions = coAsyncConnect
    LoginPrompt = False
    Mode = cmReadWrite
    AfterDisconnect = conMainAfterDisconnect
    Left = 16
    Top = 24
  end
  object Timer1: TTimer
    Interval = 50000
    OnTimer = Timer1Timer
    Left = 88
    Top = 88
  end
end
