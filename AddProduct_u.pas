unit AddProduct_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.Win.ADODB, Data.DB,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmAddProduct = class(TForm)
    btnAddProduct: TBitBtn;
    btnCancel: TBitBtn;
    lbledtBarcode: TLabeledEdit;
    lbledtProductName: TLabeledEdit;
    lbledtProductCost: TLabeledEdit;
    lbledtProductSell: TLabeledEdit;
    lbledtProductAmount: TLabeledEdit;
    qryAddProduct: TADOQuery;
    tblAddProduct: TADOTable;
    procedure btnAddProductClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddProduct: TfrmAddProduct;

implementation

uses
  ProductManager_u;
{$R *.dfm}

procedure TfrmAddProduct.btnAddProductClick(Sender: TObject);
begin
  if (lbledtBarcode.Text = '') OR (lbledtProductCost.Text = '') OR
    (lbledtProductName.Text = '') OR (lbledtProductSell.Text = '') OR
    (lbledtProductAmount.Text = '') then
  begin
    ShowMessage('Please fill in all the fields');
    Exit;
  end;

  if tblAddProduct.Locate('Barcode', lbledtBarcode.Text, []) = True then
  begin
    ShowMessage('Product with That Barcode Already Exists');
    Exit;
  end;
  with qryAddProduct do
  begin
    SQL.Text :=
      'INSERT INTO Stock ([Barcode],[Product-Name],[Product-Cost],[Product-Sell-Price],[Product-Amount-Available]) VALUES (:Barcode,:ProductName,:ProductCost,:ProductSell,:ProductAvailable)';
    Parameters.ParamByName('Barcode').Value := lbledtBarcode.Text;
    Parameters.ParamByName('ProductName').Value := lbledtProductName.Text;
    Parameters.ParamByName('ProductCost').Value := lbledtProductCost.Text;
    Parameters.ParamByName('ProductSell').Value := lbledtProductSell.Text;
    Parameters.ParamByName('ProductAvailable').Value :=
      lbledtProductAmount.Text;
    ExecSQL;
  end;
  ShowMessage('Product Added');
  Hide;
  lbledtBarcode.Text := '';
  lbledtProductCost.Text := '';
  lbledtProductName.Text := '';
  lbledtProductCost.Text := '';
  lbledtProductSell.Text := '';
  lbledtProductAmount.Text := '';
  with frmProductManager do
  begin
    qryProducts.Active := False;
    qryProducts.Active := True;
    dbgrdProductView.Columns[0].Width := 200;
    dbgrdProductView.Columns[1].Width := 270;
    dbgrdProductView.Columns[2].Width := 103;
    dbgrdProductView.Columns[3].Width := 103;
  end;
end;

procedure TfrmAddProduct.btnCancelClick(Sender: TObject);
begin
  Hide;
  lbledtBarcode.Text := '';
  lbledtProductCost.Text := '';
  lbledtProductName.Text := '';
  lbledtProductCost.Text := '';
  lbledtProductSell.Text := '';
  lbledtProductAmount.Text := '';
end;

procedure TfrmAddProduct.FormShow(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

end.
