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
  Vcl.ComCtrls, System.JSON, Bcrypt, Vcl.Menus, REST.Types;

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
    procedure btnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure TerminateApplication;
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
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
begin
  sPassword := '';
  sUsername := '';
  with qryLogin do
  begin
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
  if (TBCrypt.CheckPassword(edtPassword.Text, sPassword, bVerify) = True) and
    (edtUsername.Text = sUsername) then
  begin
    edtUsername.Clear;
    edtPassword.Clear;
    edtUsername.SetFocus;
    Hide;
    MessageDlg('Log In Successful', mtInformation, [mbOK], 0);
    if iAdmin = 1 then
    begin
      frmAdmin.Show;
    end
    else
    begin
      frmSales.ObjEmployeeInfo := ObjEmployeeInfo;
      frmSales.Show;
    end;

  end
  else
  begin
    MessageDlg('Username or Password Incorrect', mtError, [mbOK], 0);
    edtPassword.Clear;
    edtPassword.SetFocus;
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
var
  sLicenseKey, sStatus, sHashed, sDate, sOld, sDateTemp, sNameCompany: string;
  sTemp: UnicodeString;
  dActivationDate, dExpirationDate: TDateTime;
  jResponse: TJSONValue;
  I, iErrorCode, iPos, iDays: Integer;
  fLicenseFile: TextFile;
  rValidFor: tRegistry;

begin

  qryLogin.Active := True;
 { try
    if FileExists(GetEnvironmentVariable('appdata') +
      '/POS 2.0/QbsLFY6T2XRtMuA6i5jU') = True then
    begin
      rValidFor := tRegistry.Create;
      rValidFor.OpenKey('Software\IWD\POS2.0\RegInfo', True);

      dActivationDate := rValidFor.ReadDate('Value');
      iDays := rValidFor.ReadInteger('Days');
      rValidFor.Free;
      if (DaysBetween(dActivationDate, Now) <= iDays) then
      begin
        if (iDays - DaysBetween(dActivationDate, Now) < 10) then
        begin
          MessageDlg('Your License Expires in ' +
            IntToStr(iDays - DaysBetween(dActivationDate, Now)) + ' Days',
            mtInformation, [mbOK], 0);
        end;
        Exit;
      end
      else
      begin
        rValidFor := tRegistry.Create;
        rValidFor.OpenKey('Software\IWD\POS2.0\RegInfo', True);
        sLicenseKey := rValidFor.ReadString('LicKey');
        sNameCompany := rValidFor.ReadString('RegTo');
        RESTRequestLicenseCheck.Params.ParameterByName('license_key').Value :=
          sLicenseKey;
        RESTRequestLicenseCheck.Params.ParameterByName('slm_action').Value :=
          'slm_deactivate';
        RESTRequestLicenseCheck.Params.ParameterByName('registered_domain')
          .Value := sNameCompany;
        RESTRequestLicenseCheck.Execute;
        DeleteFile(GetEnvironmentVariable('appdata') +
          '/POS 2.0/QbsLFY6T2XRtMuA6i5jU');
        rValidFor.Free;
      end;

    end;
    sLicenseKey := InputBox('License Key', 'Please enter your license key', '');
    sNameCompany := InputBox('Name of Registar',
      'Please enter your or the company name', '');
    if (Length(sLicenseKey) <> 13) or (sLicenseKey = '') then
    begin
      MessageDlg('License Key Invalid', mtError, [mbOK], 0);
      Application.Terminate;
      Exit;
    end;
    if (Length(sNameCompany) <= 1) or (sNameCompany = '') then
    begin
      MessageDlg('Name Inavlid', mtError, [mbOK], 0);
      Application.Terminate;
      Exit;
    end;
    AssignFile(fLicenseFile, GetEnvironmentVariable('appdata') +
      '/POS 2.0/QbsLFY6T2XRtMuA6i5jU');
    RESTRequestLicenseCheck.Params.ParameterByName('license_key').Value :=
      sLicenseKey;
    RESTRequestLicenseCheck.Params.ParameterByName('registered_domain').Value :=
      sNameCompany;
    RESTRequestLicenseCheck.Params.ParameterByName('slm_action').Value :=
      'slm_activate';
    RESTRequestLicenseCheck.Execute;
    jResponse := RESTResponseLicenseCheck.JSONValue;
    sStatus := jResponse.GetValue<string>('result');
    if sStatus = 'error' then
    begin
      MessageDlg(jResponse.GetValue<string>('message'), mtError, [mbOK], 0);
      Application.Terminate;
      Exit;

    end;
    if sStatus = 'success' then
    begin
      sHashed := THashSHA2.GetHashString(sLicenseKey);
      for I := 1 to Length(sHashed) do
      begin
        case sHashed[I] of
          'b':
            sTemp := sTemp + 'f';
          '5':
            sTemp := sTemp + '5';
          'd':
            sTemp := sTemp + 'q';
          '9':
            sTemp := sTemp + '6';
          '2':
            sTemp := sTemp + 'z';
          'c':
            sTemp := sTemp + 'a';
          '3':
            sTemp := sTemp + 'g';
          '7':
            sTemp := sTemp + 'y';
          'a':
            sTemp := sTemp + 'p';
        end;
      end;
      for I := 1 to 10 do
      begin
        sTemp := sHashed + sTemp + sHashed + sTemp + sTemp;
      end;
      if FileExists(GetEnvironmentVariable('appdata' +
        '/POS 2.0/QbsLFY6T2XRtMuA6i5jU')) <> True then
      begin
        RESTRequestLicenseCheck.Params.ParameterByName('license_key').Value :=
          sLicenseKey;
        RESTRequestLicenseCheck.Params.ParameterByName('slm_action').Value :=
          'slm_check';
        RESTRequestLicenseCheck.Execute;
        jResponse := RESTResponseLicenseCheck.JSONValue;
        Rewrite(fLicenseFile);
        Writeln(fLicenseFile, sTemp);
        CloseFile(fLicenseFile);
        rValidFor := tRegistry.Create;
        rValidFor.OpenKey('Software\IWD\POS2.0\RegInfo', True);
        sDate := jResponse.GetValue<string>('date_renewed');
        for I := 1 to Length(sDate) do
        begin

          iPos := Pos('-', sDate);
          if iPos <> 0 then
          begin
            Delete(sDate, iPos, 1);
            Insert('/', sDate, iPos);
          end;
        end;
        sDateTemp := sDate;
        sDate := Copy(sDateTemp, 6, 3);
        sDate := sDate + Copy(sDateTemp, 9, 2);
        sDate := sDate + '/' + Copy(sDateTemp, 1, 4);
        dActivationDate := StrToDate(sDate);
        rValidFor.WriteDate('Value', dActivationDate);
        sDate := jResponse.GetValue<string>('date_expiry');
        for I := 1 to Length(sDate) do
        begin

          iPos := Pos('-', sDate);
          if iPos <> 0 then
          begin
            Delete(sDate, iPos, 1);
            Insert('/', sDate, iPos);
          end;
        end;
        sDateTemp := sDate;
        sDate := Copy(sDateTemp, 6, 3);
        sDate := sDate + Copy(sDateTemp, 9, 2);
        sDate := sDate + '/' + Copy(sDateTemp, 1, 4);
        dExpirationDate := StrToDate(sDate);
        rValidFor.WriteInteger('Days', DaysBetween(dActivationDate,
          dExpirationDate));
        rValidFor.WriteString('LicKey', sLicenseKey);
        rValidFor.WriteString('RegTo', sNameCompany);
      end;
    end;

  except
    MessageDlg
      ('License Activation Failed. Please Check your internet connection.',
      mtError, [mbOK], 0);
    Application.Terminate;
  end; }
end;

procedure TfrmLogin.TerminateApplication;
begin
  Application.Terminate;
end;

end.
