unit Admin_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Winapi.ShellAPI, Vcl.Menus,DM_u;

type
  TfrmAdmin = class(TForm)
    lblChooseOption: TLabel;
    btnViewTransactions: TButton;
    btnViewStock: TButton;
    btnManageProducts: TBitBtn;
    btnEmployeeManager: TBitBtn;
    btnViewReports: TBitBtn;
    mmHead: TMainMenu;
    File1: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Actions1: TMenuItem;
    Logout1: TMenuItem;
    procedure btnViewTransactionsClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEmployeeManagerClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnViewStockClick(Sender: TObject);
    procedure btnManageProductsClick(Sender: TObject);
    procedure btnViewReportsClick(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Logout1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAdmin: TfrmAdmin;

implementation

uses
  Login_u, Transactions_u, EmployeeManager_u, StockManager_u, ProductManager_u;
{$R *.dfm}

procedure TfrmAdmin.About1Click(Sender: TObject);
begin
 DM_u.DataModule1.ShowAbout;
end;


procedure TfrmAdmin.btnEmployeeManagerClick(Sender: TObject);
begin
  frmEmployeeManager.Show;
end;

procedure TfrmAdmin.btnManageProductsClick(Sender: TObject);
begin
  frmProductManager.Show;
  Hide;
end;

procedure TfrmAdmin.btnViewReportsClick(Sender: TObject);
begin
  MessageDlg('Reports will be opended in your default web browser',
    mtInformation, [mbOK], 0);
  ShellExecute(self.WindowHandle, 'open', 'http://localhost:8080/', nil, nil,
    SW_SHOWNORMAL);
end;

procedure TfrmAdmin.btnViewStockClick(Sender: TObject);
begin
  Hide;
  frmStockManager.Show;
end;

procedure TfrmAdmin.btnViewTransactionsClick(Sender: TObject);
begin
  Hide;
  frmTransactions.Show;
end;

procedure TfrmAdmin.Exit1Click(Sender: TObject);
begin
 DM_u.DataModule1.CloseApplication;
end;

procedure TfrmAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLogin.Show;
end;

procedure TfrmAdmin.FormShow(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TfrmAdmin.Logout1Click(Sender: TObject);
begin
 Hide;
 DM_u.DataModule1.Logout;
end;

end.
