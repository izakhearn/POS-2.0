unit EditProduct_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Data.Win.ADODB, Data.DB, Vcl.ExtCtrls;

type
  TfrmEditProduct = class(TForm)
    lbledtBarcode: TLabeledEdit;
    tblEditProduct: TADOTable;
    qryEditProduct: TADOQuery;
    lbledtProductSell: TLabeledEdit;
    lbledtProductCost: TLabeledEdit;
    lbledtProductName: TLabeledEdit;
    btnCancel: TBitBtn;
    btnUpdateProduct: TBitBtn;
    procedure btnUpdateProductClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sBarcode: string;
  end;

var
  frmEditProduct: TfrmEditProduct;

implementation

{$R *.dfm}

uses ProductManager_u;

procedure TfrmEditProduct.btnCancelClick(Sender: TObject);
begin
  Hide;
end;

//This function will update a product mathcing the barcode that the user has provided.
// It will find the product using the barcode and update all information in the database
// That the user edited.
procedure TfrmEditProduct.btnUpdateProductClick(Sender: TObject);
begin
  if (lbledtProductSell.Text = '') or (lbledtProductCost.Text = '') or
    (lbledtProductName.Text = '') then
  begin
    MessageDlg('Please fill in all fields', mtWarning, [mbOK], 0);
  end;
  with {qryEditProduct} tblEditProduct do
  begin
    Locate('Barcode',sBarcode,[]) ;
    Edit;
    FieldByName('Barcode').AsString:= lbledtBarcode.Text;
    FieldByName('ProductName').AsString:= lbledtProductName.Text;
    FieldByName('ProductCost').AsFloat:= StrToFloat(lbledtProductCost.Text);
    FieldByName('ProductSellPrice').AsFloat:= StrToFloat(lbledtProductSell.Text);
    Post;
    Refresh;
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
  ShowMessage('Product Updated Successfully');
  Hide;

end;

// When this form is first called it pulls up the product infomation from the
// Database using the product barcode that was passed to from the unit that called it.
procedure TfrmEditProduct.FormShow(Sender: TObject);
begin
  qryEditProduct.Active:= True;
  tblEditProduct.Active:= True;
  lbledtBarcode.Text := sBarcode;
  with tblEditProduct do
  begin
    Locate('Barcode',sBarcode,[]);
    lbledtProductSell.Text:= FieldByName('ProductSellPrice').AsString;
    lbledtProductCost.Text:= FieldByName('ProductCost').AsString;
    lbledtProductName.Text:= FieldByName('ProductName').AsString;
  end;
end;

end.
