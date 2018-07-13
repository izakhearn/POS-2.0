object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 167
  Width = 199
  object conMain: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;User ID=Admin;Data Source=C:\U' +
      'sers\Izak Hearn\Desktop\PAT 2018\Database.accdb;Mode=ReadWrite;P' +
      'ersist Security Info=False;Jet OLEDB:System database="";Jet OLED' +
      'B:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engi' +
      'ne Type=6;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Par' +
      'tial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:N' +
      'ew Database Password="";Jet OLEDB:Create System Database=False;J' +
      'et OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on C' +
      'ompact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet ' +
      'OLEDB:SFP=False;Jet OLEDB:Support Complex Data=False;'
    LoginPrompt = False
    Mode = cmReadWrite
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 16
    Top = 24
  end
end
