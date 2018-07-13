unit clsStockManagement_u;

interface

uses
  System.SysUtils, System.Variants, System.Classes, DM_u, Data.DB,
  Data.Win.ADODB, Vcl.Dialogs;

type
  TStockManagment = class(TObject)
  private
    fBarcode: string;
    qryStock: TADOQuery;
    tblStock: TADOTable;
    Self2: TComponent;
    { private declarations }

  public
    { public declarations }
    constructor Create;
    function GetProductInfo(sBarcode: string): string;
    function GetProductName(sBarcode: string): string;
    function GetProductPrice(sBarcode: string): Real;
    function GetStockAvalible(sBarcode: string): Integer;
    procedure RemoveStock(sBarcode: string; iAmountRemove: Integer);
    procedure AddStock(sBarcode: string; iAmountAdd: Integer);

  end;

implementation

{ TStockManagment }
constructor TStockManagment.Create;
begin
  qryStock := TADOQuery.Create(Self2);
  qryStock.Connection := DataModule1.conMain;
  tblStock := TADOTable.Create(Self2);
  tblStock.Connection := DataModule1.conMain;
  tblStock.TableName := 'Stock';
  tblStock.Active := True;
end;

procedure TStockManagment.AddStock(sBarcode: string; iAmountAdd: Integer);
var
  fAmountAvailable: Integer;
begin
  fBarcode := sBarcode;
  with qryStock do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := fBarcode;
    ExecSQL;
    Open;
    fAmountAvailable := FieldByName('Product-Amount-Available').AsInteger;
    // UPDATE THE TABLE NOW
    with tblStock do
    begin
      Locate('Barcode', fBarcode, []);
      Edit;
      FieldByName('Product-Amount-Available').AsInteger := fAmountAvailable +
        iAmountAdd;
      Post;
      ShowMessage('Stock Added');
    end;
  end;
end;

function TStockManagment.GetProductInfo(sBarcode: string): string;
var
  fTemp: string;
begin
  fBarcode := sBarcode;
  with qryStock do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := fBarcode;
    ExecSQL;
    Open;
    fTemp := FieldByName('Product-Name').AsString;
    fTemp := fTemp + ',' + FieldByName('Product-Sell-Price').AsString;
  end;
  Result := fTemp;
end;

function TStockManagment.GetProductName(sBarcode: string): string;
begin
  fBarcode := sBarcode;
  with qryStock do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := fBarcode;
    ExecSQL;
    Open;
    Result := FieldByName('Product-Name').AsString;
  end;
end;

function TStockManagment.GetProductPrice(sBarcode: string): Real;
begin
  fBarcode := sBarcode;
  with qryStock do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := fBarcode;
    ExecSQL;
    Open;
    Result := FieldByName('Product-Sell-Price').AsFloat;
  end;
end;

function TStockManagment.GetStockAvalible(sBarcode: string): Integer;
begin
  fBarcode := sBarcode;
  with qryStock do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := fBarcode;
    ExecSQL;
    Open;
    Result := FieldByName('Product-Amount-Available').AsInteger;
  end;
end;

procedure TStockManagment.RemoveStock(sBarcode: string; iAmountRemove: Integer);
var
  fAmountAvailable: Integer;
begin
  fBarcode := sBarcode;
  with qryStock do
  begin
    SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
    Parameters.ParamByName('barcode').Value := fBarcode;
    ExecSQL;
    Open;
    with tblStock do
    begin
      Locate('Barcode', fBarcode, []);
      Edit;
      FieldByName('Product-Amount-Available').AsInteger := fAmountAvailable -
        iAmountRemove;
      Post;
      ShowMessage('Stock Corrected');
    end;
  end;
end;

end.