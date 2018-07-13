unit EditEmployeeInfo_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, ExtCtrls, ComCtrls, DM_u, Bcrypt;

type
  TfrmEditEmployeeInfo = class(TForm)
    lblEditUser: TLabel;
    lbledtPassword: TLabeledEdit;
    lbledtName: TLabeledEdit;
    lbledtSurname: TLabeledEdit;
    lbledtPhone: TLabeledEdit;
    lbledtEmail: TLabeledEdit;
    btnSubmit: TButton;
    qryEditEmployee: TADOQuery;
    lbledtUsername: TLabeledEdit;
    chkAdmin: TCheckBox;
    tblEmployeeInfo: TADOTable;
    procedure FormActivate(Sender: TObject);
    procedure btnSubmitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditEmployeeInfo: TfrmEditEmployeeInfo;

implementation

uses
  EmployeeManager_u;

{$R *.dfm}

procedure TfrmEditEmployeeInfo.btnSubmitClick(Sender: TObject);
begin
  with tblEmployeeInfo do
  begin
    Locate('ID', frmEmployeeManager.iID, []);
    Edit;
    FieldByName('Username').AsString := lbledtUsername.Text;
    FieldByName('Password').AsString :=
      TBCrypt.HashPassword(lbledtPassword.Text);
    FieldByName('Full-Name').AsString := lbledtName.Text;
    FieldByName('Surname').AsString := lbledtSurname.Text;
    FieldByName('Cell-Phone').AsString := lbledtPhone.Text;
    FieldByName('Email').AsString := lbledtEmail.Text;
    FieldByName('Admin').AsBoolean := chkAdmin.Checked;
    Post;
    ShowMessage('Updating Done');
    Hide;
  end;
end;

procedure TfrmEditEmployeeInfo.FormActivate(Sender: TObject);
begin
  lblEditUser.Caption := 'Currently Employee with the ID of : ' +
    IntToStr(frmEmployeeManager.iID);
  with qryEditEmployee do
  begin
    SQL.Text := ' select * from Employees where ID=:id';
    Parameters.ParamByName('id').Value := frmEmployeeManager.iID;
    ExecSQL;
    Open;
    lbledtUsername.Text := FieldByName('Username').AsString;
    lbledtPassword.Text := FieldByName('Password').AsString;
    lbledtName.Text := FieldByName('Full-Name').AsString;
    lbledtSurname.Text := FieldByName('Surname').AsString;
    lbledtPhone.Text := FieldByName('Cell-Phone').AsString;
    lbledtEmail.Text := FieldByName('Email').AsString;
    chkAdmin.Checked := FieldByName('Admin').AsBoolean;
  end;

end;

procedure TfrmEditEmployeeInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmEmployeeManager.Show;
end;

procedure TfrmEditEmployeeInfo.FormShow(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

end.
