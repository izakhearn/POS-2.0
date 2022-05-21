unit Login_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, DM_u,
  Data.DB, clsEmployeeInfo,
  Data.Win.ADODB, ShellApi, IPPeerClient, System.Hash, System.Win.Registry,
  System.DateUtils, System.StrUtils,

  REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, IdGlobal,
  Vcl.ComCtrls, System.JSON, Bcrypt, Vcl.Menus, REST.Types,clsLogging,LogView_u;

type
  TfrmLogin = class(TForm)
    btnLogin: TBitBtn;
    edtUsername: TEdit;
    edtPassword: TEdit;
    qryLogin: TADOQuery;
    RESTClientLicenseCheck: TRESTClient;
    RESTRequestLicenseCheck: TRESTRequest;
    RESTResponseLicenseCheck: TRESTResponse;
    mmHead: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Log1: TMenuItem;
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure TerminateApplication;
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Log1Click(Sender: TObject);
  private
    { Private declarations }
    ObjEmployeeInfo: TEmployeeInfo;

  public
    { Public declarations }

  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  SaleScreen_u, Admin_u;
{$R *.dfm}

procedure TfrmLogin.About1Click(Sender: TObject);
begin
  DM_u.DataModule1.ShowAbout;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  iAdmin: Integer;
  sUsername: string;
  sPassword: UnicodeString;
  bVerify: Boolean;
  MyClass: TComponent;
  objLog : TLog;
begin
  sPassword := '';
  sUsername := '';
  with qryLogin do
  begin
  try
          SQL.Text := 'SELECT * FROM Employees WHERE Username=:username';
    Parameters.ParamByName('username').Value := edtUsername.Text;
    ExecSQL;
    Open;
    iAdmin := FieldByName('Admin').AsInteger;
    sPassword := FieldByName('Password').AsString;
    sUsername := FieldByName('Username').AsString;
    ObjEmployeeInfo := TEmployeeInfo.Create(FieldByName('FullName').AsString,
      FieldByName('Surname').AsString, FieldByName('CellPhone').AsString,
      FieldByName('Email').AsString, FieldByName('ID').AsInteger);
  except
    DM_u.DataModule1.ReconncectDB;
  end;
  end;
  if (edtPassword.Text = '') or (edtUsername.Text = '') then
  begin
    MessageDlg('Please Fill in Your Username and Password', mtInformation,
      [mbOK], 0);
    edtUsername.SetFocus;
    Exit;
  end;
  if (edtPassword.Text = 'admin') and (LowerCase(edtUsername.Text) = 'admin')
  then
  begin
    MessageDlg
      ('Please change the default Username and Password to get rid of this message',
      mtWarning, [mbOK], 0);
  end;

  MyClass := TComponent.Create(Self);
  try
       if (TBCrypt.CheckPassword(edtPassword.Text, sPassword, bVerify) = True) and
    (edtUsername.Text = sUsername) then
  begin
    edtUsername.Clear;
    edtPassword.Clear;
    edtUsername.SetFocus;
    Hide;
    MessageDlg('Log In Successful', mtInformation, [mbOK], 0);
    objLog:= TLog.Create;
    objLog.WriteLog('INFO','Login Attempt : Success');
    objLog.WriteLog('INFO','User Logged In : '+sUsername);
    if iAdmin = 1 then
    begin
      frmAdmin.Show;
      objLog.WriteLog('INFO','User Is An Administator : True');
    end
    else
    begin
      objLog.WriteLog('INFO','User Is An Administrator :False');
      frmSales.ObjEmployeeInfo := ObjEmployeeInfo;
      frmSales.Show;
    end;
    objLog.Free;
  end
  else
  begin
  objLog:= TLog.Create;
    objLog.WriteLog('WARN','Login Attempt : Failed');
    objLog.WriteLog('WARN','Reason For Failure : Bad Username or Password');
    objLog.Free;
    MessageDlg('Username or Password Incorrect', mtError, [mbOK], 0);
    edtPassword.Clear;
    edtPassword.SetFocus;

  end;
  except
    on E: Exception do
    begin
    objLog:= TLog.Create;
    objLog.WriteLog('ERROR','Login Attempt : Failed');
    objLog.WriteLog('ERROR','Reason For Failure : See Message Below');
    objLog.WriteLog('ERROR',E.ClassName+' : '+E.Message);
    objLog.Free;
    end;
  end;


end;

procedure TfrmLogin.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Ord(Key) = VK_RETURN then
  begin
    btnLoginClick(Self);
  end;
end;

procedure TfrmLogin.Exit1Click(Sender: TObject);
begin
  DM_u.DataModule1.CloseApplication
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  edtUsername.SetFocus;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);

begin
  qryLogin.Active := True;
end;

procedure TfrmLogin.Log1Click(Sender: TObject);
begin
   LogView_u.frmLog.Show;
end;

procedure TfrmLogin.TerminateApplication;
var
objLog: TLog;
begin
  Application.Terminate;
end;

end.
