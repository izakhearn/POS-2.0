unit DM_u;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB, Winapi.Windows,
  About_u, Data.DBXMySQL, Data.SqlExpr,Vcl.Dialogs;

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
   sWorkingDataDir,sDataBase,sUser,sPassword,sServerAddress: string;
   tDBConnectInfo : TextFile;
begin
  sWorkingDataDir := GetEnvironmentVariable('APPDATA') +
    '\POS 2.0\Transactions';
  // Check To see if the folder exists if its not there create it
  if DirectoryExists(sWorkingDataDir) = False then
  begin
    CreateDir(sWorkingDataDir);
  end;
  AssignFile(tDBConnectInfo,GetEnvironmentVariable('APPDATA')+'\POS 2.0\DBInfo');
  if FileExists(GetEnvironmentVariable('APPDATA')+'\POS 2.0\DBInfo')= False then
  begin
    sServerAddress:= InputBox('Server Address','Please enter your servers IP address','');
    sDataBase := InputBox('Database name','Please enter the name of your database','');
    sUser := InputBox('Database User','Please enter the database username','');
    sPassword:= InputBox('Database Password','Please enter the database password','');
    Rewrite(tDBConnectInfo);
    Writeln(tDBConnectInfo,sServerAddress);
    Writeln(tDBConnectInfo,sDataBase);
    Writeln(tDBConnectInfo,sUser);
    Writeln(tDBConnectInfo,sPassword);
    CloseFile(tDBConnectInfo);
  end
  else
  begin
    Reset(tDBConnectInfo);
    Readln(tDBConnectInfo,sServerAddress);
    Readln(tDBConnectInfo,sDataBase);
    Readln(tDBConnectInfo,sUser);
    Readln(tDBConnectInfo,sPassword);
    Close(tDBConnectInfo);
  end;


   Try

    if conMain.Connected then  // already connected?
    begin
      MessageDlg('Already connected', mtInformation, [mbOK], 0);
      Exit;
    end;

    begin

      conMain.LoginPrompt:=False;//dont ask for the login parameters
      conMain.ConnectionString := 'Driver={MySQL ODBC 5.1 Driver};Server='+sServerAddress+';Database=' + sDatabase + ';User='+sUser+'; Password='+sPassword+';Option=3;';

      conMain.Connected := True; //open the connection

      MessageDlg('Connected to databse "' + sDataBase + '".', mtInformation, [mbOK], 0);
    end;

  Except
    On E: Exception do
    begin
      Erase(tDBConnectInfo);
      MessageDlg('Cannot connect to databse "' + sDataBase + '"!.' + #13 + #10 + 'Please report this problem (is MySql running?)', mtError, [mbOK], 0);
      CloseApplication;
    end;
  end;
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
