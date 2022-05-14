unit StockManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Data.Win.ADODB, Vcl.StdCtrls, Vcl.Buttons, clsStockManagement_u, Vcl.ToolWin,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, clsExport;

type
  TfrmStockManager = class(TForm)
    dsStock: TDataSource;
    dbgrdStockView: TDBGrid;
    btnAddStock: TBitBtn;
    btnCorrectStock: TBitBtn;
    btnViewAvailableStock: TBitBtn;
    qryStockFilter: TADOQuery;
    seFilterByAmount: TSpinEdit;
    lblFilter: TLabel;
    lblShowProducts: TLabel;
    btnResetFilter: TBitBtn;
    btnFilter: TBitBtn;
    btnExportStock: TBitBtn;
    btnGenerateReport: TBitBtn;
    lblFilterActive: TLabel;
    procedure btnViewAvailableStockClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFilterClick(Sender: TObject);
    procedure btnCorrectStockClick(Sender: TObject);
    procedure btnResetFilterClick(Sender: TObject);
    procedure btnAddStockClick(Sender: TObject);
    procedure btnExportStockClick(Sender: TObject);
    procedure btnGenerateReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    objStock: TStockManagment;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStockManager: TfrmStockManager;

implementation
uses
  Admin_u;
{$R *.dfm}

procedure TfrmStockManager.btnAddStockClick(Sender: TObject);
var
  sBarcode: string;
  iAdd: Integer;
begin
  sBarcode := InputBox('Product Barcode', 'Scan Product Barcode', '');
  if (sBarcode = '') or (Length(sBarcode) < 13) or (Length(sBarcode) > 17) then
  begin
    MessageDlg('Barcode Invalid. Please try again', mtError, [mbOK], 0);
    Exit;
  end;
  try
    iAdd := StrToInt(InputBox('Add Stock',
      'How much stock must be added', '0'));
  except
    MessageDlg('The Value Entred can not be used. Please try again', mtError,
      [mbOK], 0);
  end;
  objStock := TStockManagment.Create;
  objStock.AddStock(sBarcode, iAdd);
  MessageDlg('Stock Added Succsessfully', mtInformation, [mbOK], 0);
  dsStock.Enabled := False;
  qryStockFilter.Active := False;
  qryStockFilter.Active := True;
  dsStock.Enabled := True;
  dbgrdStockView.Columns[0].Width := 230;
  dbgrdStockView.Columns[1].Width := 300;
  dbgrdStockView.Columns[2].Width := 275;
end;

procedure TfrmStockManager.btnCorrectStockClick(Sender: TObject);
var
  sBarcode: string;
  iRemove: Integer;
begin
  sBarcode := InputBox('Product Barcode', 'Scan Product Barcode', '');
  if (sBarcode = '') or (Length(sBarcode) < 13) or (Length(sBarcode) > 17) then
  begin
    MessageDlg('Barcode Invalid. Please try again', mtError, [mbOK], 0);
    Exit;
  end;

  try
    iRemove := StrToInt(InputBox('Stock Correction',
      'Enter amount to correct stock by', '0'));
  except
    MessageDlg('The Value Entred can not be used. Please try again', mtError,
      [mbOK], 0);
  end;
  objStock := TStockManagment.Create;
  objStock.RemoveStock(sBarcode, iRemove);
  MessageDlg('Stock correction done', mtInformation, [mbOK], 0);
  dsStock.Enabled := False;
  qryStockFilter.Active := False;
  qryStockFilter.Active := True;
  dsStock.Enabled := True;
  dbgrdStockView.Columns[0].Width := 230;
  dbgrdStockView.Columns[1].Width := 300;
  dbgrdStockView.Columns[2].Width := 275;
end;

procedure TfrmStockManager.btnExportStockClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdStockView, 'FiltredStockExport');
  objExport.ExportToCSV;
  objExport.Free;
end;

procedure TfrmStockManager.btnFilterClick(Sender: TObject);
var
  iUnder: Integer;
begin
  lblFilterActive.Caption := 'Filter Currently Active';
  iUnder := StrToInt(seFilterByAmount.Text);
  with qryStockFilter do
  begin
    SQL.Text :=
      'SELECT Barcode,ProductName,ProductAmountAvailable FROM Stock WHERE ProductAmountAvailable <= :FilterAmount';
    Parameters.ParamByName('FilterAmount').Value := iUnder;
    ExecSQL;
    Open;
  end;
  dsStock.Enabled := False;
  qryStockFilter.Active := False;
  qryStockFilter.Active := True;
  dsStock.Enabled := True;
  dbgrdStockView.Columns[0].Width := 230;
  dbgrdStockView.Columns[1].Width := 300;
  dbgrdStockView.Columns[2].Width := 275;

end;

procedure TfrmStockManager.btnGenerateReportClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdStockView, 'Stock');
  objExport.ExportToHTML('Stock');
  objExport.Free;
  MessageDlg('Report Generated', mtInformation, [mbOK], 0);
end;

procedure TfrmStockManager.btnResetFilterClick(Sender: TObject);
begin
  lblFilterActive.Caption := 'No Filter Active';
  with qryStockFilter do
  begin
    SQL.Text :=
      'SELECT Barcode,ProductName,ProductAmountAvailable FROM Stock';
    ExecSQL;
    Open;
  end;
  dsStock.Enabled := False;
  qryStockFilter.Active := False;
  qryStockFilter.Active := True;
  dsStock.Enabled := True;
  dbgrdStockView.Columns[0].Width := 230;
  dbgrdStockView.Columns[1].Width := 300;
  dbgrdStockView.Columns[2].Width := 275;
end;

procedure TfrmStockManager.btnViewAvailableStockClick(Sender: TObject);
var
  sBarcode: string;
begin
  sBarcode := InputBox('Barcode', 'Scan Product Barcode Now', '');
  objStock := TStockManagment.Create;
  ShowMessage(FloatToStrF(objStock.GetStockAvalible(sBarcode), ffGeneral, 10, 2)
    + ' Is available for ' + objStock.GetProductName(sBarcode));
  objStock.Free;
end;

procedure TfrmStockManager.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmAdmin.Show;
end;

procedure TfrmStockManager.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
  qryStockFilter.Active:= True;
end;

procedure TfrmStockManager.FormShow(Sender: TObject);
begin
 qryStockFilter.Active:= True;
end;



end.
