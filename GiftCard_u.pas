unit GiftCard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,DM_u,Admin_u, Data.DB, Data.Win.ADODB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, EditCard_u,AddCard_u,clsExport;

type
  TfrmGiftCards = class(TForm)
    dbgrdGiftCardList: TDBGrid;
    dsGiftCard: TDataSource;
    qryGiftCard: TADOQuery;
    btnNewCard: TBitBtn;
    btnEditCard: TBitBtn;
    btnReloadCard: TBitBtn;
    tblCardBal: TADOTable;
    btnGenerateReport: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnNewCardClick(Sender: TObject);
    procedure btnEditCardClick(Sender: TObject);
    procedure btnReloadCardClick(Sender: TObject);
    procedure btnGenerateReportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sCardNum : string;
  end;

var
  frmGiftCards: TfrmGiftCards;

implementation

{$R *.dfm}

procedure TfrmGiftCards.btnEditCardClick(Sender: TObject);
begin
  sCardNum:= InputBox('Scan Card','Please Scan The Card You Wish To Edit','');
  frmEditCard.Show;
end;

procedure TfrmGiftCards.btnGenerateReportClick(Sender: TObject);
var
  objExport: TExport;
begin
  objExport := TExport.Create(dbgrdGiftCardList, 'Gift Card');
  objExport.ExportToHTML('GiftCard');
  objExport.Free;
  MessageDlg('Report Generated', mtInformation, [mbOK], 0);
end;

procedure TfrmGiftCards.btnNewCardClick(Sender: TObject);
begin
 frmAddCard.Show;
end;

procedure TfrmGiftCards.btnReloadCardClick(Sender: TObject);
var
  rBal,rTemp : Real;
begin
  with qryGiftCard do
  begin
    SQL.Text:= 'SELECT CardBalance FROM GiftCard WHERE GiftCardNum=:CardNum';
    sCardNum := InputBox('Scan Card','Please Scan The Card Now','');
    Parameters.ParamByName('CardNum').Value := sCardNum;
    ExecSQL;
    Open;
    rBal:= FieldByName('CardBalance').AsFloat;
    rTemp:= StrToFloat(InputBox('Add Cash To Card','The Current balance of the card is'+FloatToStrF(rBal,ffCurrency,10,2)+'. How much do you want to add?',''));
  end;
  with tblCardBal do
  begin
    Locate('GiftCardNum', frmGiftCards.sCardNum, []);
    Edit;
    FieldByName('CardBalance').AsCurrency := rBal+rTemp;
    Post;
    ShowMessage('Card Balance Sucessfully Updated');
  end;

  with qryGiftCard do
  begin
    SQL.Text := 'SELECT * FROM GiftCard';
    ExecSQL;
    Open;
  end;
  dbgrdGiftCardList.Columns[0].Width := 225;
  dbgrdGiftCardList.Columns[1].Width := 120;
  dbgrdGiftCardList.Columns[2].Width := 120;
  dbgrdGiftCardList.Columns[3].Width := 100;
  dbgrdGiftCardList.Columns[4].Width := 100;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TfrmGiftCards.FormActivate(Sender: TObject);
begin
 with qryGiftCard do
  begin
    SQL.Text := 'SELECT * FROM GiftCard';
    ExecSQL;
    Open;
  end;
  dbgrdGiftCardList.Columns[0].Width := 225;
  dbgrdGiftCardList.Columns[1].Width := 120;
  dbgrdGiftCardList.Columns[2].Width := 120;
  dbgrdGiftCardList.Columns[3].Width := 100;
  dbgrdGiftCardList.Columns[4].Width := 100;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TfrmGiftCards.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 frmAdmin.Show;
end;

procedure TfrmGiftCards.FormCreate(Sender: TObject);
begin
  dbgrdGiftCardList.Columns[0].Width := 225;
  dbgrdGiftCardList.Columns[1].Width := 120;
  dbgrdGiftCardList.Columns[2].Width := 120;
  dbgrdGiftCardList.Columns[3].Width := 100;
  dbgrdGiftCardList.Columns[4].Width := 100;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

procedure TfrmGiftCards.FormShow(Sender: TObject);
begin
 with qryGiftCard do
  begin
    SQL.Text := 'SELECT * FROM GiftCard';
    ExecSQL;
    Open;
  end;
  dbgrdGiftCardList.Columns[0].Width := 225;
  dbgrdGiftCardList.Columns[1].Width := 120;
  dbgrdGiftCardList.Columns[2].Width := 120;
  dbgrdGiftCardList.Columns[3].Width := 100;
  dbgrdGiftCardList.Columns[4].Width := 100;
  SetWindowLong(Handle, GWL_EXSTYLE, WS_EX_APPWINDOW);
end;

end.
