unit DM_u;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB, Winapi.Windows,
  About_u, Data.DBXMySQL, Data.SqlExpr, Vcl.Dialogs, Vcl.ExtCtrls,clsLogging;

type
  TDataModule1 = class(TDataModule)
    conMain: TADOConnection;
    Timer1: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure CloseApplication;
    procedure ShowAbout;
    procedure Logout;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    sWorkingDataDir, sDataBase, sUser, sPassword, sServerAddress: string;
  public
    { Public declarations }
    procedure ReconncectDB;
  end;

var
  DataModule1: TDataModule1;
  bFistConnect: Boolean;
  objLog : TLog;

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
  tDBConnectInfo: TextFile;
begin
  sWorkingDataDir := GetEnvironmentVariable('APPDATA') +
    '\POS 2.0\Transactions';
  // Check To see if the folder exists if its not there create it
  if DirectoryExists(sWorkingDataDir) = False then
  begin
    CreateDir(sWorkingDataDir);
  end;
  AssignFile(tDBConnectInfo, GetEnvironmentVariable('APPDATA') +
    '\POS 2.0\DBInfo');
  if FileExists(GetEnvironmentVariable('APPDATA') + '\POS 2.0\DBInfo') = False
  then
  begin
    sServerAddress := InputBox('Server Address',
      'Please enter your servers IP address', '');
    sDataBase := InputBox('Database name',
      'Please enter the name of your database', '');
    sUser := InputBox('Database User',
      'Please enter the database username', '');
    sPassword := InputBox('Database Password',
      'Please enter the database password', '');
    Rewrite(tDBConnectInfo);
    Writeln(tDBConnectInfo, sServerAddress);
    Writeln(tDBConnectInfo, sDataBase);
    Writeln(tDBConnectInfo, sUser);
    Writeln(tDBConnectInfo, sPassword);
    CloseFile(tDBConnectInfo);
  end
  else
  begin
    Reset(tDBConnectInfo);
    Readln(tDBConnectInfo, sServerAddress);
    Readln(tDBConnectInfo, sDataBase);
    Readln(tDBConnectInfo, sUser);
    Readln(tDBConnectInfo, sPassword);
    Close(tDBConnectInfo);
  end;

  Try

    if conMain.Connected then // already connected?
    begin
      MessageDlg('Already connected', mtInformation, [mbOK], 0);
      Exit;
    end;

    begin

      conMain.LoginPrompt := False; // dont ask for the login parameters
      conMain.ConnectionString := 'Driver={MySQL ODBC 5.1 Driver};Server=' +
        sServerAddress + ';Database=' + sDataBase + ';User=' + sUser +
        '; Password=' + sPassword + ';Option=3;';

      conMain.Connected := True; // open the connection
      //MessageDlg('Connected to databse "' + sDataBase + '".', mtInformation,
        //[mbOK], 0);

    objLog:= TLog.Create;
    objLog.WriteLog('INFO','Application Starting..');
    objLog.WriteLog('INFO','Connecting to Database at Address '+ sServerAddress + ' : Successfull');
    objLog.Free;
    end;

  Except
    On E: Exception do
    begin
      // Erase(tDBConnectInfo);
    objLog:= TLog.Create;
    objLog.WriteLog('INFO','Application Starting..');
    objLog.WriteLog('INFO','Connecting to Database at Address '+ sServerAddress + ' : Failed');
    objLog.WriteLog('ERROR',E.ClassName+' : '+E.Message);
    objLog.Free;
      MessageDlg('Cannot connect to databse "' + sDataBase + '"!.' + #13 + #10 +
        'Please report this problem (is MySql running? HELLO)', mtError, [mbOK], 0);
      CloseApplication;
    end;
  end;
end;

procedure TDataModule1.Logout;
begin
  Login_u.frmLogin.Show;
end;

procedure TDataModule1.ReconncectDB;
begin
  Try
    conMain.Connected := False;
    if conMain.Connected then // already connected?
    begin
      MessageDlg('Already connected', mtInformation, [mbOK], 0);
      Exit;
    end;

    begin

      conMain.LoginPrompt := False; // dont ask for the login parameters
      conMain.ConnectionString := 'Driver={MySQL ODBC 5.1 Driver};Server=' +
        sServerAddress + ';Database=' + sDataBase + ';User=' + sUser +
        '; Password=' + sPassword + ';Option=3;';

      conMain.Connected := True; // open the connection
      conMain.KeepConnection := True;
      //MessageDlg('Connected to databse "' + sDataBase + '".', mtInformation,
      //  [mbOK], 0);
    end;
    objLog := Tlog.Create;
    objLog.WriteLog('INFO','Reconnecting to Database at Address '+ sServerAddress +
    ' : Successfull');
    objLog.Free;
  Except
    On E: Exception do
    begin
      // Erase(tDBConnectInfo);
    objLog:= TLog.Create;
    objLog.WriteLog('INFO','Reconnecting to Database at Address '+ sServerAddress + ' : Failed');
    objLog.WriteLog('ERROR',E.ClassName+' : '+E.Message);
    objLog.Free;
    end;
  end;
end;

procedure TDataModule1.ShowAbout;
begin
  AboutBox.Show;
end;

procedure TDataModule1.Timer1Timer(Sender: TObject);
begin
 ReconncectDB;
end;

end.
