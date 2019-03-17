unit EmployeeManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.DB, Data.Win.ADODB,
  Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, clsExport;

type
  TfrmEmployeeManager = class(TForm)
    dbgrdEmployees: TDBGrid;
    qryEmployees: TADOQuery;
    dsEmployees: TDataSource;
    btnEditEmployee: TBitBtn;
    btnDeleteEmployee: TBitBtn;
    tblDeleteEmployee: TADOTable;
    btnAddEmployee: TBitBtn;
    btnGenerateReport: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnEditEmployeeClick(Sender: TObject);
    procedure btnDeleteEmployeeClick(Sender: TObject);
    procedure btnAddEmployeeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGenerateReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iID: Integer;
  end;

var
  frmEmployeeManager: TfrmEmployeeManager;

implementation

uses
  Admin_u, EditEmployeeInfo_u, AddEmployee_u;
{$R *.dfm}

procedure TfrmEmployeeManager.btnAddEmployeeClick(Sender: TObject);
begin
  Hide;
  frmAddEmployee.Show;
end;

procedure TfrmEmployeeManager.btnDeleteEmployeeClick(Sender: TObject);
var
  iDeleteID, iConfirmation: Integer;
  sTemp: string;
begin
  sTemp := InputBox('Employee ID', 'Enter the Employees ID', '');
  if sTemp = '' then
  begin
    ShowMessage('Please Retry');
    sTemp := InputBox('Employee ID', 'Enter the Employees ID', '');
    try
      iDeleteID := StrToInt(sTemp);
    except
      ShowMessage('Please make sure to only enter a number');
      Exit;
    end;
  end
  else
  begin
    try
      iDeleteID := StrToInt(sTemp);
    except
      ShowMessage('Please make sure to only enter a number');
      Exit;
    end;
    iConfirmation :=
      MessageDlg('Are you sure you want to delete the Employee with the ID of '
      + IntToStr(iDeleteID), mtWarning, [mbYes, mbNo], 0);
    if iConfirmation = mrNo then
    begin
      Exit
    end;
    with tblDeleteEmployee do
    begin
      Locate('ID', iDeleteID, []);
      Edit;
      Delete;
    end;
    ShowMessage('Employee Succesfully Deleted.');
    qryEmployees.Active := False;
    qryEmployees.Active := True;
    dbgrdEmployees.Columns[0].Width := 50;
    dbgrdEmployees.Columns[1].Width := 220;
    dbgrdEmployees.Columns[2].Width := 220;
  end;
end;

procedure TfrmEmployeeManager.btnEditEmployeeClick(Sender: TObject);
var
  sTemp: string;
begin
  sTemp := InputBox('Employee ID', 'Enter the Employees ID', '');
  if sTemp = '' then
  begin
    ShowMessage('Please Retry');
    sTemp := InputBox('Employee ID', 'Enter the Employees ID', '');
    try
      iID := StrToInt(sTemp);
    except
      ShowMessage('Please make sure to only enter a number');
      Exit;
    end;
  end
  else
  begin
    try
      iID := StrToInt(sTemp);
    except
      ShowMessage('Please make sure to only enter a number');
      Exit;
    end;
    frmEditEmployeeInfo.Show;
    Hide;
  end;
end;

procedure TfrmEmployeeManager.btnGenerateReportClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdEmployees, 'Employee');
  objExport.ExportToHTML('Employee');
  objExport.Free;
  MessageDlg('Report Generated', mtInformation, [mbOK], 0);
end;

procedure TfrmEmployeeManager.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TfrmEmployeeManager.FormShow(Sender: TObject);
begin
  qryEmployees.Active := False;
  dsEmployees.Enabled := False;
  qryEmployees.Active := True;
  dsEmployees.Enabled := True;
  tblDeleteEmployee.Active:=True;
  dbgrdEmployees.Columns[0].Width := 50;
  dbgrdEmployees.Columns[1].Width := 220;
  dbgrdEmployees.Columns[2].Width := 220;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW)
end;

end.
