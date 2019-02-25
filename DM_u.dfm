object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 167
  Width = 199
  object conMain: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;User ID=Admin;Data Source=C:\U' +
      'sers\Izak Hearn\Desktop\pos-2.0\Setup Files\Database.accdb;Mode=' +
      'ReadWrite;Persist Security Info=False;Jet OLEDB:System database=' +
      '"";Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet' +
      ' OLEDB:Engine Type=6;Jet OLEDB:Database Locking Mode=1;Jet OLEDB' +
      ':Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;' +
      'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Datab' +
      'ase=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy ' +
      'Locale on Compact=False;Jet OLEDB:Compact Without Replica Repair' +
      '=False;Jet OLEDB:SFP=False;Jet OLEDB:Support Complex Data=False'
    LoginPrompt = False
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 16
    Top = 24
  end
end
