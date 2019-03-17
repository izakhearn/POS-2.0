unit TransactionDetails_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.DB, Data.Win.ADODB,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmTransactionsDetails = class(TForm)
    sgdTransactionDetails: TStringGrid;
    lblTransactionID: TLabel;
    lblEmployeeID: TLabel;
    lblTotalCost: TLabel;
    lblAmountPaid: TLabel;
    lblAmountOfItems: TLabel;
    lblTransactionTime: TLabel;
    lblTime: TLabel;
    qryTransactionDetails: TADOQuery;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sTransactionID: string;
  end;

var
  frmTransactionsDetails: TfrmTransactionsDetails;

implementation

{$R *.dfm}

procedure TfrmTransactionsDetails.FormShow(Sender: TObject);
var
  sTemp, sWorkingDataDir: string;
  iRow, iCol, iTemp: Integer;
  TransactionFile: TextFile;
begin
  qryTransactionDetails.Active:= True;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
  sWorkingDataDir := GetEnvironmentVariable('APPDATA') +
    '\POS 2.0\Transactions\';
  sgdTransactionDetails.Show;
  lblTotalCost.Caption := 'Total Cost           : ';
  lblEmployeeID.Caption := 'Employees ID     : ';
  lblTransactionID.Caption := 'Transaction ID    : ';
  lblAmountPaid.Caption := 'Amount Paid       : ';
  lblAmountOfItems.Caption := 'Amount of Items : ';
  with qryTransactionDetails do
  begin
    SQL.Text := 'SELECT * FROM Transactions WHERE ID=:id';
    Parameters.ParamByName('id').Value := sTransactionID;
    ExecSQL;
    Open;
    lblTime.Caption := FieldByName('DateWhen').AsString;
    lblTotalCost.Caption := lblTotalCost.Caption + '' +
      FieldByName('TotalCost').AsString;
    lblEmployeeID.Caption := lblEmployeeID.Caption + '' +
      FieldByName('EmployeeID').AsString;
    lblTransactionID.Caption := lblTransactionID.Caption + '' + sTransactionID;
    lblAmountPaid.Caption := lblAmountPaid.Caption + '' +
      FloatToStrF(FieldByName('AmountPaid').AsFloat, ffCurrency, 10, 2);
    lblAmountOfItems.Caption := lblAmountOfItems.Caption + '' +
      FieldByName('AmountItems').AsString;
  end;
  AssignFile(TransactionFile, sWorkingDataDir + sTransactionID);
  try
    Reset(TransactionFile);
  except
    ShowMessage('Transaction File Not Found. It Could Have Been Deleted');
    sgdTransactionDetails.Hide;
    Exit;
  end;

  Reset(TransactionFile);
  with sgdTransactionDetails do
  begin
    Readln(TransactionFile, sTemp);
    ColCount := StrToInt(sTemp);
    Readln(TransactionFile, sTemp);
    RowCount := StrToInt(sTemp);
    for iCol := 0 to ColCount do
      for iRow := 0 to RowCount do
      begin
        Readln(TransactionFile, sTemp);
        Cells[iCol, iRow] := sTemp;
      end;
  end;
  CloseFile(TransactionFile);

end;

end.
