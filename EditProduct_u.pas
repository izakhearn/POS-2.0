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

procedure TfrmEditProduct.btnCancelClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrmEditProduct.btnUpdateProductClick(Sender: TObject);
begin
  if (lbledtProductSell.Text = '') or (lbledtProductCost.Text = '') or
    (lbledtProductName.Text = '') then
  begin
    MessageDlg('Please fill in all fields', mtWarning, [mbOK], 0);
  end;
  with qryEditProduct do
  begin
    SQL.Text :=
      'UPDATE [Product-Name],[Product-Sell-Price],[Product-Cost] VALUES (:PrdouctName,:ProductSellPrice,:ProductCost) FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := sBarcode;
    Parameters.ParamByName('ProductName').Value := lbledtProductName.Text;
    Parameters.ParamByName('ProductCost').Value :=
      StrToFloat(lbledtProductCost.Text);
    Parameters.ParamByName('ProductSellPrice').Value :=
      StrToFloat(lbledtProductSell.Text);
    ExecSQL;
    Open;

  end;

end;

procedure TfrmEditProduct.FormShow(Sender: TObject);
begin
  lbledtBarcode.Text := sBarcode;
  with qryEditProduct do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := sBarcode;
    ExecSQL;
    Open;
    lbledtProductSell.Text := FieldByName('Product-Sell-Price').AsString;
    lbledtProductCost.Text := FieldByName('Product-Cost').AsString;
    lbledtProductName.Text := FieldByName('Product-Name').AsString;
  end;
end;

end.
