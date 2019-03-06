program POS;

uses
  Vcl.Forms,
  DM_u in 'DM_u.pas' {DataModule1: TDataModule},
  Login_u in 'Login_u.pas' {frmLogin},
  SaleScreen_u in 'SaleScreen_u.pas' {frmSales},
  clsEmployeeInfo in 'clsEmployeeInfo.pas',
  Vcl.Themes,
  Vcl.Styles,
  Admin_u in 'Admin_u.pas' {frmAdmin},
  Transactions_u in 'Transactions_u.pas' {frmTransactions},
  TransactionDetails_u in 'TransactionDetails_u.pas' {frmTransactionsDetails},
  AddProduct_u in 'AddProduct_u.pas' {frmAddProduct},
  EmployeeManager_u in 'EmployeeManager_u.pas' {frmEmployeeManager},
  EditEmployeeInfo_u in 'EditEmployeeInfo_u.pas' {frmEditEmployeeInfo},
  AddEmployee_u in 'AddEmployee_u.pas' {frmAddEmployee},
  clsStockManagement_u in 'clsStockManagement_u.pas',
  StockManager_u in 'StockManager_u.pas' {frmStockManager},
  ProductManager_u in 'ProductManager_u.pas' {frmProductManager},
  EditProduct_u in 'EditProduct_u.pas' {frmEditProduct},
  clsPrintSlip in 'clsPrintSlip.pas',
  clsExport in 'clsExport.pas',
  dmWebServer_u in 'dmWebServer_u.pas' {dmHttpServer: TDataModule},
  About_u in 'About_u.pas' {AboutBox},
  GiftCard_u in 'GiftCard_u.pas' {frmGiftCards},
  AddCard_u in 'AddCard_u.pas' {frmAddCard},
  EditCard_u in 'EditCard_u.pas' {frmEditCard};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'POS 2.0';
  TStyleManager.TrySetStyle('Windows10 SlateGray');
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmSales, frmSales);
  Application.CreateForm(TfrmAdmin, frmAdmin);
  Application.CreateForm(TfrmTransactions, frmTransactions);
  Application.CreateForm(TfrmTransactionsDetails, frmTransactionsDetails);
  Application.CreateForm(TfrmAddProduct, frmAddProduct);
  Application.CreateForm(TfrmEmployeeManager, frmEmployeeManager);
  Application.CreateForm(TfrmEditEmployeeInfo, frmEditEmployeeInfo);
  Application.CreateForm(TfrmAddEmployee, frmAddEmployee);
  Application.CreateForm(TfrmStockManager, frmStockManager);
  Application.CreateForm(TfrmProductManager, frmProductManager);
  Application.CreateForm(TfrmEditProduct, frmEditProduct);
  Application.CreateForm(TdmHttpServer, dmHttpServer);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfrmGiftCards, frmGiftCards);
  Application.CreateForm(TfrmAddCard, frmAddCard);
  Application.CreateForm(TfrmEditCard, frmEditCard);
  Application.Run;

end.
