unit DM_u;

interface

uses
  System.SysUtils, System.Classes, Data.Win.ADODB, Data.DB, Winapi.Windows,
  About_u, Data.DBXMySQL, Data.SqlExpr, Vcl.Dialogs, Vcl.ExtCtrls,clsLogging,DBInfo_u;

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
    procedure InitialDBConnect;
  end;

var
  DataModule1: TDataModule1;
  bConnectAtStart: Boolean;
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

  // Check if the DBInfo file exists. This file is used to pull your database connection
  // info from. If the file does not exist we show a series of popup boxes that will ask
  // you for the infomation for the application to connect to the database
  if System.SysUtils.FileExists(GetEnvironmentVariable('APPDATA') + '\POS 2.0\DBInfo') = False
  then
  begin
    DBInfo_u.frmDBInfo.Show;
//    sServerAddress := InputBox('Server Address',
//      'Please enter your servers IP address', '');
//    sDataBase := InputBox('Database name',
//      'Please enter the name of your database', '');
//    sUser := InputBox('Database User',
//      'Please enter the database username', '');
//    sPassword := InputBox('Database Password',
//      'Please enter the database password', '');
//    Rewrite(tDBConnectInfo);
//    Writeln(tDBConnectInfo, sServerAddress);
//    Writeln(tDBConnectInfo, sDataBase);
//    Writeln(tDBConnectInfo, sUser);
//    Writeln(tDBConnectInfo, sPassword);
//    CloseFile(tDBConnectInfo);
      Exit;

  end
  else
  begin
    Reset(tDBConnectInfo);
    Readln(tDBConnectInfo, sServerAddress);
    Readln(tDBConnectInfo, sDataBase);
    Readln(tDBConnectInfo, sUser);
    Readln(tDBConnectInfo, sPassword);
    Close(tDBConnectInfo);
    bConnectAtStart := True;
  end;

  Try
    // Check if the database is already connect
    // We use this check as a sanity check just in case it should always return
    // false when the application starts
    if conMain.Connected then // already connected?
    begin
      //MessageDlg('Already connected', mtInformation, [mbOK], 0);
      Exit;
    end;
      conMain.LoginPrompt := False; // dont ask for the login parameters
      conMain.ConnectionString := 'Driver={MySQL ODBC 5.1 Driver};Server=' +
        sServerAddress + ';Database=' + sDataBase + ';User=' + sUser +
        '; Password=' + sPassword + ';Option=3;';
      conMain.Connected := True; // open the connection
      //Log the Application starting and connecting to database action
      objLog:= TLog.Create;
      objLog.WriteLog('INFO','Application Starting..');
      objLog.WriteLog('INFO','Connecting to Database at Address '+ sServerAddress + ' : Successfull');
      objLog.Free;
  Except
    On E: Exception do
    begin
      //Log Database connection issues on startup
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


//This function is used to reconnect the DB it can be called from other
// Units if an excption with a database occurs. There is a timer in the code
// That will also trigger this every min to ensure the database connection stays up.
procedure TDataModule1.ReconncectDB;
begin
  Try
    conMain.Connected := False;
    if conMain.Connected then // already connected?
    begin
      MessageDlg('Already connected', mtInformation, [mbOK], 0);
      Exit;
    end;
      conMain.LoginPrompt := False; // dont ask for the login parameters
      conMain.ConnectionString := 'Driver={MySQL ODBC 5.1 Driver};Server=' +
        sServerAddress + ';Database=' + sDataBase + ';User=' + sUser +
        '; Password=' + sPassword + ';Option=3;';
      conMain.Connected := True; // open the connection
      conMain.KeepConnection := True;
      //Log that the database reconnect was successfull
      objLog := Tlog.Create;
      objLog.WriteLog('INFO','Reconnecting to Database at Address '+ sServerAddress +
      ' : Successfull');
      objLog.Free;
  Except
    On E: Exception do
    begin
    //Log that the database reconnect has failed and include the error message in the logs
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

// Timer that will run the reconnect function on the database
// This is to ensure the database connection stays up or if it is down
// Reconnects the database to the application
procedure TDataModule1.Timer1Timer(Sender: TObject);
begin
  if bConnectAtStart = False then
  begin
   InitialDBConnect;
   Exit
  end;
  ReconncectDB;
end;

procedure TDataModule1.InitialDBConnect;
var
   tDBConnectInfo: Textfile;
begin
    AssignFile(tDBConnectInfo, GetEnvironmentVariable('APPDATA') +
    '\POS 2.0\DBInfo');
    Reset(tDBConnectInfo);
    Readln(tDBConnectInfo, sServerAddress);
    Readln(tDBConnectInfo, sDataBase);
    Readln(tDBConnectInfo, sUser);
    Readln(tDBConnectInfo, sPassword);
    Close(tDBConnectInfo);
    bConnectAtStart := True;
    ReconncectDB;
end;

end.
