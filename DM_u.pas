unit DM_u;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB, Winapi.Windows,
  About_u;

type
  TDataModule1 = class(TDataModule)
    conMain: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure CloseApplication;
    procedure ShowAbout;
    procedure Logout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

uses
  Login_u;
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TDataModule1.CloseApplication;
begin
  frmLogin.TerminateApplication;
end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
var
  sUserAppDataDir, sWorkingDataDir: string;
begin
  sWorkingDataDir := GetEnvironmentVariable('APPDATA') +
    '\POS 2.0\Transactions';
  // Check To see if the folder exists if its not there create it
  if DirectoryExists(sWorkingDataDir) = False then
  begin
    CreateDir(sWorkingDataDir);
  end;
  // Gets the user app data dir
  sUserAppDataDir := GetEnvironmentVariable('APPDATA');
  // Connects to the DB
  conMain.Connected := False;
  conMain.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;User ID=Admin;Data' + ' Source=' +
    sUserAppDataDir + '\POS 2.0\Database.accdb;Mode=ReadWrite;P' +
    'ersist Security Info=False;Jet OLEDB:System database="";Jet OLED' +
    'B:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engi' +
    'ne Type=6;Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Par' +
    'tial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:N' +
    'ew Database Password="";Jet OLEDB:Create System Database=False;J' +
    'et OLEDB:Encrypt Database=False;Jet OLEDB:Don'#39't Copy Locale on C' +
    'ompact=False;Jet OLEDB:Compact Without Replica Repair=False;Jet ' +
    'OLEDB:SFP=False;Jet OLEDB:Support Complex Data=False';
  conMain.Connected := True;
end;

procedure TDataModule1.Logout;
begin
  Login_u.frmLogin.Show;
end;

procedure TDataModule1.ShowAbout;
begin
  AboutBox.Show;
end;

end.
