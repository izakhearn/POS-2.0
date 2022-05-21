unit clsStockManagement_u;

interface

uses
  System.SysUtils, System.Variants, System.Classes, DM_u, Data.DB,
  Data.Win.ADODB, Vcl.Dialogs,clsLogging;

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
  var
  objLog : TLog;

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
    fAmountAvailable := FieldByName('ProductAmountAvailable').AsInteger;
    // UPDATE THE TABLE NOW
    with tblStock do
    begin
      Locate('Barcode', fBarcode, []);
      Edit;
      FieldByName('ProductAmountAvailable').AsInteger := fAmountAvailable +
        iAmountAdd;
      Post;
      ShowMessage('Stock Added');
    end;
  end;

   objLog:= TLog.Create;
   objLog.WriteLog('INFO','Adding Stock : Successful');
   objLog.WriteLog('INFO','Added '+IntToStr(iAmountAdd)+' To Product : '+fBarcode);
   objLog.Free;
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
    fTemp := FieldByName('ProductName').AsString;
    fTemp := fTemp + ',' + FieldByName('ProductSellPrice').AsString;
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
    Result := FieldByName('ProductName').AsString;
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
    Result := FieldByName('ProductSellPrice').AsFloat;
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
    Result := FieldByName('ProductAmountAvailable').AsInteger;
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
    fAmountAvailable := FieldByName('ProductAmountAvailable').AsInteger;
    with tblStock do
    begin
      Locate('Barcode', fBarcode, []);
      Edit;
      FieldByName('ProductAmountAvailable').AsInteger := fAmountAvailable -
        iAmountRemove;
      Post;
      //ShowMessage('Stock Corrected');
    end;
  end;

   objLog:= TLog.Create;
   objLog.WriteLog('INFO','Adding Stock : Successful');
   objLog.WriteLog('INFO','Added '+IntToStr(iAmountRemove)+' To Product : '+fBarcode);
   objLog.Free;
end;

end.
