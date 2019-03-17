unit Transactions_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.DB, Data.Win.ADODB,
  Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, clsExport,
  Winapi.ShellAPI;

type
  TfrmTransactions = class(TForm)
    btnViewTransactionDetails: TBitBtn;
    dbgrdTransactions: TDBGrid;
    qryTransactions: TADOQuery;
    dsTransactions: TDataSource;
    lblTransactions: TLabel;
    qryEmployeeInfo: TADOQuery;
    btnLookupEmployee: TBitBtn;
    lblFilterBy: TLabel;
    dtpStart: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    lblTo: TLabel;
    btnFilter: TBitBtn;
    btnResetFilter: TBitBtn;
    tblTransactionDetails: TADOTable;
    btnExportTransactions: TBitBtn;
    btnGenerateReport: TBitBtn;
    procedure btnLookupEmployeeClick(Sender: TObject);
    procedure btnViewTransactionDetailsClick(Sender: TObject);
    procedure btnFilterClick(Sender: TObject);
    procedure btnResetFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExportTransactionsClick(Sender: TObject);
    procedure btnGenerateReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTransactions: TfrmTransactions;

implementation

uses
  TransactionDetails_u, Admin_u;
{$R *.dfm}

procedure TfrmTransactions.btnExportTransactionsClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdTransactions, 'Transactions');
  objExport.ExportToCSV;
  objExport.Free;
end;

procedure TfrmTransactions.btnFilterClick(Sender: TObject);
var
  sDateStart, sDateEnd: string;
begin
  sDateStart := DateToStr(dtpStart.DateTime);
  sDateEnd := DateToStr(dtpEnd.DateTime);
  with qryTransactions do
  begin
    SQL.Text :=
      'SELECT * FROM Transactions WHERE [DateWhen] BETWEEN :DateStart AND :DateEnd';
    Parameters.ParamByName('DateStart').Value := sDateStart;
    Parameters.ParamByName('DateEnd').Value := sDateEnd;
    ExecSQL;
    Open;
  end;
  dsTransactions.Enabled := False;
  dsTransactions.Enabled := True;
end;

procedure TfrmTransactions.btnGenerateReportClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdTransactions, 'Transactions');
  objExport.ExportToHTML('Transaction');
  objExport.Free;
  MessageDlg('Report Generated', mtInformation, [mbOK], 0);
end;

procedure TfrmTransactions.btnLookupEmployeeClick(Sender: TObject);
var
  iID: Integer;
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
  end;
  with qryEmployeeInfo do
  begin
    SQL.Text := 'SELECT * FROM Employees WHERE ID=:id';
    Parameters.ParamByName('id').Value := iID;
    ExecSQL;
    Open;
    sTemp := FieldByName('FullName').AsString + ' ' +
      FieldByName('Surname').AsString;
  end;

  ShowMessage('The Employee ID belongs to ' + sTemp);

end;

procedure TfrmTransactions.btnResetFilterClick(Sender: TObject);
begin
  with qryTransactions do
  begin
    SQL.Text := 'SELECT * FROM Transactions';
    ExecSQL;
    Open;
  end;
  dsTransactions.Enabled := False;
  dsTransactions.Enabled := True;
end;

procedure TfrmTransactions.btnViewTransactionDetailsClick(Sender: TObject);
var
  sTransactionID: string;
begin
  sTransactionID := InputBox('Transaction ID',
    'Please enter transaction ID', '');
  if tblTransactionDetails.Locate('ID', sTransactionID, []) = False then
  begin
    ShowMessage('Invalid Transaction ID');
    Exit;
  end;
  frmTransactionsDetails.sTransactionID := sTransactionID;
  frmTransactionsDetails.Show;
end;

procedure TfrmTransactions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmAdmin.Show;
end;

procedure TfrmTransactions.FormShow(Sender: TObject);
begin
  qryTransactions.Active := False;
  qryTransactions.Active := True;
  dsTransactions.Enabled := False;
  dsTransactions.Enabled := True;
  qryEmployeeInfo.Active:= False;
  qryEmployeeInfo.Active:= True;
  tblTransactionDetails.Active:=False;
  tblTransactionDetails.Active:=True;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

end.
