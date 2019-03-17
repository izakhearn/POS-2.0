unit AddEmployee_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, DM_u,
  Data.DB, Data.Win.ADODB, Bcrypt;

type
  TfrmAddEmployee = class(TForm)
    lbledtPassword: TLabeledEdit;
    lbledtName: TLabeledEdit;
    lbledtSurname: TLabeledEdit;
    lbledtPhone: TLabeledEdit;
    lbledtEmail: TLabeledEdit;
    btnSubmit: TButton;
    lbledtUsername: TLabeledEdit;
    chkAdmin: TCheckBox;
    qryAddEmployee: TADOQuery;
    tblAddEmployee: TADOTable;
    procedure btnSubmitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddEmployee: TfrmAddEmployee;

implementation

uses
  EmployeeManager_u;
{$R *.dfm}

procedure TfrmAddEmployee.btnSubmitClick(Sender: TObject);

begin
  if (lbledtName.Text = '') or (lbledtEmail.Text = '') or
    (lbledtPhone.Text = '') or (lbledtPassword.Text = '') or
    (lbledtSurname.Text = '') or (lbledtUsername.Text = '') or
    (Length(lbledtPhone.Text) <> 10) then
  begin
    ShowMessage('Please make sure all fields are filled in correctly ');
    Exit;
  end;
  if tblAddEmployee.Locate('Username', lbledtUsername.Text, []) = True then
  begin
    ShowMessage('Username already in use. Please try another one');
    lbledtUsername.Clear;
    lbledtUsername.SetFocus;
    Exit;
  end;
  with qryAddEmployee do
  begin
    SQL.Text :=
      'INSERT INTO Employees (FullName,Surname,Email,CellPhone,Username,Password,Admin) VALUES (:FullName,:surname,:email,:cell,:username,:password,:admin)';
    Parameters.ParamByName('FullName').Value := lbledtName.Text;
    Parameters.ParamByName('surname').Value := lbledtSurname.Text;
    Parameters.ParamByName('email').Value := lbledtEmail.Text;
    Parameters.ParamByName('cell').Value := lbledtPhone.Text;
    Parameters.ParamByName('username').Value := lbledtUsername.Text;
    Parameters.ParamByName('password').Value :=
      TBCrypt.HashPassword(lbledtPassword.Text);
    Parameters.ParamByName('admin').Value := chkAdmin.Checked;
    ExecSQL;
  end;
  ShowMessage('Employee successfully added.');
  Hide;
  frmEmployeeManager.Show;

end;

procedure TfrmAddEmployee.FormShow(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
  qryAddEmployee.Active:= True;
  tblAddEmployee.Active:= True;
end;

end.
