object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 167
  Width = 199
  object conMain: TADOConnection
    ConnectionString = 
      #39'Driver={MySQL ODBC 5.2 Driver};Server=localhost;Database=posl;U' +
      'ser=root;'
    LoginPrompt = False
    Mode = cmReadWrite
    Left = 16
    Top = 24
  end
end
