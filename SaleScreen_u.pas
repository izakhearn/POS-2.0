unit SaleScreen_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DM_u,
  Data.DB, Data.Win.ADODB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, clsEmployeeInfo,
  clsStockManagement_u, clsPrintSlip, Vcl.Menus,clsGiftCard;

type
  TfrmSales = class(TForm)
    edtBarcode: TEdit;
    sgdSales: TStringGrid;
    qrySales: TADOQuery;
    tblStock: TADOTable;
    lblSubTotal: TLabel;
    lblVat: TLabel;
    lblTotal: TLabel;
    btnEndSale: TBitBtn;
    btnCancelSale: TBitBtn;
    mmHead: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Actions1: TMenuItem;
    Logout1: TMenuItem;
    btnCheckCardBal: TBitBtn;
    procedure edtBarcodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelSaleClick(Sender: TObject);
    procedure btnEndSaleClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
    procedure btnCheckCardBalClick(Sender: TObject);

  private
    { Private declarations }
    arrItemsScanned: array [1 .. 100000] of string;
    iAmountItems, iAmountItemsDisplayed: Integer;
    rTotal, rVAT, rSubTotal, rAmountPaid: Real;
    ObjEmployeeInfoUse: TEmployeeInfo;
    objStock: TStockManagment;
    objPrint: TPrintSlip;
    objGiftCard: TGiftCard;
  public
    property ObjEmployeeInfo: TEmployeeInfo read ObjEmployeeInfoUse
      write ObjEmployeeInfoUse;
    { Public declarations }
  end;

var
  frmSales: TfrmSales;

implementation

uses
  Login_u;
{$R *.dfm}

procedure TfrmSales.About1Click(Sender: TObject);
begin
  DataModule1.ShowAbout;
end;

procedure TfrmSales.btnCancelSaleClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 1 to iAmountItems do
  begin
    sgdSales.Cells[0, I] := '';
    sgdSales.Cells[1, I] := '';
    sgdSales.Cells[2, I] := '';
  end;
  iAmountItems := 0;
  iAmountItemsDisplayed := 0;
  rTotal := 0;
  rSubTotal := 0;
  rVAT := 0;
  lblVat.Caption := 'VAT 15%' + #13 + '';
  lblTotal.Caption := 'Total' + #13 + '';
  lblSubTotal.Caption := 'Sub Total' + #13 + '';
  sgdSales.RowCount := 2;
  I := 0;
  for I := 1 to 10000 do
    arrItemsScanned[I] := '';
  sgdSales.Cells[0, 0] := 'Name';
  sgdSales.Cells[1, 0] := 'Price';
  sgdSales.Cells[2, 0] := 'Quantity';
  edtBarcode.Text := '';
  edtBarcode.SetFocus;
end;

procedure TfrmSales.btnCheckCardBalClick(Sender: TObject);
var
  sTemp : string;
  rTemp : Real;
begin
  sTemp := InputBox('Scan Gift Card','Please Scan Card Now.','');
 objGiftCard:= TGiftCard.Create(sTemp);
 rTemp := objGiftCard.GetCurrBal;
  MessageDlg('The Cards current balance is :'+FloatToStrF(rTemp,ffCurrency,10,2),mtConfirmation,[mbOK],0);
  objGiftCard.Free;
end;

procedure TfrmSales.btnEndSaleClick(Sender: TObject);
var
  sTemp, sUserAppDataDir,sCardNumber: string;
  iTransactionID, iLoop, iLoop2: Integer;
  bCardSuccessfull : Boolean;
  TransactionFile: TextFile;
  I,iCardPayment: Integer;
begin
  objStock := TStockManagment.Create;
  sUserAppDataDir := GetEnvironmentVariable('APPDATA');
   iCardPayment:= MessageDlg('Is the user Paying with a gift card?',mtWarning,[mbYes,mbNo],0);
   if iCardPayment = mrYes then
   begin
    sCardNumber:= InputBox('Please Scan Card','Please Scan Card Barcode Now','');
    objGiftCard:= TGiftCard.Create(sCardNumber);
    bCardSuccessfull:= objGiftCard.CompletePayment(rTotal);
    sTemp:= FloatToStrF(rTotal,ffGeneral,10,2);
    if bCardSuccessfull = False then
    begin
      MessageDlg('Transaction Voided',mtError,[mbOK],0);
      btnCancelSale.Click;
      Exit;
    end;
   end
   else
   begin
   sCardNumber:= 'COD';
  sTemp := InputBox('Amount Paid', 'Enter Amount Paid', '');
  if sTemp = '' then
  begin
    ShowMessage('The value entered can not be accepted. Please Try Again');
    Exit;
  end;
  rAmountPaid := StrToFloat(sTemp);
  if (rTotal > rAmountPaid) then
  begin
    ShowMessage
      ('The value entred is smaller than the total cost of the Sale. Please Try Again');
    Exit;
  end;
  end;
  rAmountPaid := StrToFloat(sTemp);
  ShowMessage('Change ' + FloatToStrF(rAmountPaid - rTotal, ffCurrency, 10, 2));
  with qrySales do
  begin
    SQL.Text :=
      'INSERT INTO Transactions (EmployeeID,TotalCost,AmountPaid,AmountItems,DateWhen,GiftCardNum) VALUES (:EmployeeID,:AmountCost,:AmountPaid,:AmountItems,NOW(),:CardNum)';
    Parameters.ParamByName('EmployeeID').Value := ObjEmployeeInfo.GetID;
    Parameters.ParamByName('AmountPaid').Value := rAmountPaid;
    Parameters.ParamByName('AmountItems').Value := iAmountItems;
    Parameters.ParamByName('AmountCost').Value := rTotal;
    Parameters.ParamByName('CardNum').Value := sCardNumber;
    ExecSQL;
    SQL.Text := 'Select * FROM Transactions ORDER BY ID DESC ';
    ExecSQL;
    Open;
    iTransactionID := FieldByName('ID').AsInteger;
  end;
  AssignFile(TransactionFile, sUserAppDataDir + '\POS 2.0\Transactions\' +
    IntToStr(iTransactionID));
  Rewrite(TransactionFile);
  with sgdSales do
  begin
    Writeln(TransactionFile, ColCount);
    Writeln(TransactionFile, RowCount);
    for iLoop := 0 to ColCount do
      for iLoop2 := 0 to RowCount do
      begin
        Writeln(TransactionFile, Cells[iLoop, iLoop2]);
      end;
    CloseFile(TransactionFile);
  end;
  for I := 1 to iAmountItems do
  begin
    objStock.RemoveStock(arrItemsScanned[I], 1);
  end;
  {objPrint := TPrintSlip.Create(sgdSales, FloatToStrF(rTotal, ffCurrency, 10,
    2), FloatToStrF(rAmountPaid, ffCurrency, 10, 2),
    FloatToStrF(rAmountPaid - rTotal, ffCurrency, 10, 2),
    FloatToStrF(rVAT, ffCurrency, 10, 2), 'POS 2.0' + #13 +
    ' Transaction Time : ' + DateTimeToStr(Now) + #13 + 'Transaction #' +
    IntToStr(iTransactionID));
  objPrint.StartPrint;
  objPrint.Free;}
  for I := 1 to 100000 do
    arrItemsScanned[I] := '';
  for I := 1 to iAmountItems do
  begin
    sgdSales.Cells[0, I] := '';
    sgdSales.Cells[1, I] := '';
    sgdSales.Cells[2, I] := '';
  end;
  sgdSales.RowCount := 3;
  sgdSales.Cells[0, 0] := 'Name';
  sgdSales.Cells[1, 0] := 'Price';
  sgdSales.Cells[2, 0] := 'Quantity';
  edtBarcode.Text := '';
  edtBarcode.SetFocus;
  iAmountItems := 0;
  iAmountItemsDisplayed := 0;
  rTotal := 0;
  rSubTotal := 0;
  rVAT := 0;
  lblVat.Caption := 'VAT 15%' + #13 + '';
  lblTotal.Caption := 'Total' + #13 + '';
  lblSubTotal.Caption := 'Sub Total' + #13 + '';
  objStock.Free;
end;

procedure TfrmSales.edtBarcodeKeyPress(Sender: TObject; var Key: Char);
var
  sProductName, sBarcode: string;
  rProductPrice: Real;
  I, iQuantity: Integer;
  bItemScanned: Boolean;

begin
  if Ord(Key) = VK_RETURN then
  begin
    Key := #0;
    sBarcode := edtBarcode.Text;
    bItemScanned := False;
    sProductName := '';
    rProductPrice := 0;
    if (tblStock.Locate('Barcode', sBarcode, [])) = True then
    begin
      with qrySales do
      begin
        SQL.Text := 'SELECT * FROM Stock WHERE Barcode=:barcode';
        Parameters.ParamByName('barcode').Value := sBarcode;
        ExecSQL;
        Open;
        sProductName := FieldByName('ProductName').AsString;
        rProductPrice := FieldByName('ProductSellPrice').AsFloat;
      end;
      arrItemsScanned[iAmountItems + 1] := sBarcode;
      if bItemScanned = False then
      begin
        for I := 1 to iAmountItems do
        begin
          if arrItemsScanned[I] = sBarcode then
          begin
            if sgdSales.Cells[0, I] = sProductName then
            begin
              iQuantity := StrToInt(sgdSales.Cells[2, I]) + 1;
              sgdSales.Cells[2, I] := IntToStr(iQuantity);
              bItemScanned := True;
            end;
          end;

        end;
      end;
      if bItemScanned = True then
      begin
        rTotal := rTotal + rProductPrice;
        rSubTotal := rTotal - (rTotal * 15 / 100);
        rVAT := rTotal * 15 / 100;
        lblVat.Caption := 'VAT 15%' + #13 + FloatToStrF(rVAT,
          ffCurrency, 10, 2);
        lblTotal.Caption := 'Total ' + #13 + FloatToStrF(rTotal,
          ffCurrency, 10, 2);
        lblSubTotal.Caption := 'Sub Total' + #13 + FloatToStrF(rSubTotal,
          ffCurrency, 10, 2);
        edtBarcode.Text := '';
        bItemScanned := False;
        iAmountItems := iAmountItems + 1;
        Exit;
      end;
      iAmountItemsDisplayed := iAmountItemsDisplayed + 1;
      sgdSales.RowCount := sgdSales.RowCount + 1;
      sgdSales.Cells[0, iAmountItemsDisplayed] := sProductName;
      sgdSales.Cells[1, iAmountItemsDisplayed] :=
        FloatToStrF(rProductPrice, ffCurrency, 10, 2);
      sgdSales.Cells[2, iAmountItemsDisplayed] := '1';
      sgdSales.Row := sgdSales.RowCount - 1;
      rTotal := rTotal + rProductPrice;
      rSubTotal := rTotal - (rTotal * 15 / 100);
      rVAT := rTotal * 15 / 100;
      lblVat.Caption := 'VAT 15%' + #13 + FloatToStrF(rVAT, ffCurrency, 10, 2);
      lblTotal.Caption := 'Total ' + #13 + FloatToStrF(rTotal,
        ffCurrency, 10, 2);
      lblSubTotal.Caption := 'Sub Total' + #13 + FloatToStrF(rSubTotal,
        ffCurrency, 10, 2);
      edtBarcode.Text := '';
      bItemScanned := False;
      iAmountItems := iAmountItems + 1;

    end
    else
    begin
      ShowMessage('Barcode not found');
      edtBarcode.Text := '';
    end;

  end;
end;

procedure TfrmSales.Exit1Click(Sender: TObject);
begin
  DataModule1.CloseApplication;
end;

procedure TfrmSales.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLogin.Show;
  ObjEmployeeInfo.Free;
end;

procedure TfrmSales.FormShow(Sender: TObject);
var
  I: Integer;
begin
  for I := 1 to iAmountItems do
  begin
    sgdSales.Cells[0, I] := '';
    sgdSales.Cells[1, I] := '';
    sgdSales.Cells[2, I] := '';
  end;
  iAmountItems := 0;
  rTotal := 0;
  rSubTotal := 0;
  rVAT := 0;
  lblVat.Caption := 'VAT 15%' + #13 + '';
  lblTotal.Caption := 'Total' + #13 + '';
  lblSubTotal.Caption := 'Sub Total' + #13 + '';
  sgdSales.RowCount := 2;
  I := 0;
  for I := 1 to 10000 do
    arrItemsScanned[I] := '';
  sgdSales.Cells[0, 0] := 'Name';
  sgdSales.Cells[1, 0] := 'Price';
  sgdSales.Cells[2, 0] := 'Quantity';
  edtBarcode.Text := '';
  edtBarcode.SetFocus;
  iAmountItemsDisplayed := 0;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
  tblStock.Active:= True;
end;

procedure TfrmSales.Logout1Click(Sender: TObject);
begin
  Hide;

  DataModule1.Logout;
end;

end.
