unit ProductManager_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB, clsExport;

type
  TfrmProductManager = class(TForm)
    qryProducts: TADOQuery;
    dsProducts: TDataSource;
    dbgrdProductView: TDBGrid;
    btnAddProduct: TBitBtn;
    btnEditProduct: TBitBtn;
    btnDeleteProduct: TBitBtn;
    tblDeleteProduct: TADOTable;
    btnExportProducts: TBitBtn;
    btnGeneratReport: TBitBtn;
    procedure btnAddProductClick(Sender: TObject);
    procedure btnEditProductClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteProductClick(Sender: TObject);
    procedure btnExportProductsClick(Sender: TObject);
    procedure btnGeneratReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProductManager: TfrmProductManager;

implementation

uses
  AddProduct_u, EditProduct_u, Admin_u;
{$R *.dfm}

procedure TfrmProductManager.btnAddProductClick(Sender: TObject);
begin
  frmAddProduct.Show;
end;

procedure TfrmProductManager.btnDeleteProductClick(Sender: TObject);
var
  iConfirmation: Integer;
  sTemp: string;
begin
  sTemp := InputBox('Product Barcode', 'Enter the barcode', '');
  iConfirmation := MessageDlg
    ('Are you sure you want to delete the Product with the Barcode of ' + sTemp,
    mtWarning, [mbYes, mbNo], 0);
  if iConfirmation = mrNo then
  begin
    Exit
  end;
  with tblDeleteProduct do
  begin
    Locate('Barcode', sTemp, []);
    Edit;
    Delete;
  end;
  ShowMessage('Product Succesfully Deleted.');
  qryProducts.Active := False;
  qryProducts.Active := True;
  dbgrdProductView.Columns[0].Width := 200;
  dbgrdProductView.Columns[1].Width := 270;
  dbgrdProductView.Columns[2].Width := 103;
  dbgrdProductView.Columns[3].Width := 103;
end;

procedure TfrmProductManager.btnEditProductClick(Sender: TObject);
begin
  frmEditProduct.sBarcode := InputBox('Barcode',
    'Please scan product barcode', '');
  if frmEditProduct.tblEditProduct.Locate('Barcode', frmEditProduct.sBarcode, []
    ) = False then
  begin
    MessageDlg('Product with that barcode could not be found', mtError,
      [mbOK], 0);
    Exit;
  end;
  frmEditProduct.Show;
end;

procedure TfrmProductManager.btnExportProductsClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdProductView, 'Products');
  objExport.ExportToCSV;
  objExport.Free;
end;

procedure TfrmProductManager.btnGeneratReportClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdProductView, 'Product');
  objExport.ExportToHTML('Product');
  objExport.Free;
  MessageDlg('Report Generated', mtInformation, [mbOK], 0);
end;

procedure TfrmProductManager.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmAdmin.Show;
end;

procedure TfrmProductManager.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TfrmProductManager.FormShow(Sender: TObject);
begin
qryProducts.Active:= False;
 dsProducts.Enabled:=False;
 tblDeleteProduct.Active:= False;
 qryProducts.Active:= True;
 dsProducts.Enabled:=True;
 tblDeleteProduct.Active:= True;
  dbgrdProductView.Columns[0].Width := 200;
  dbgrdProductView.Columns[1].Width := 270;
  dbgrdProductView.Columns[2].Width := 103;
  dbgrdProductView.Columns[3].Width := 103;
end;

end.
