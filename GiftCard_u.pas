unit GiftCard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,DM_u,Admin_u, Data.DB, Data.Win.ADODB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmGiftCards = class(TForm)
    dbgrdGiftCardList: TDBGrid;
    dsGiftCard: TDataSource;
    qryGiftCard: TADOQuery;
    btnNewCard: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGiftCards: TfrmGiftCards;

implementation

{$R *.dfm}

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

end.
