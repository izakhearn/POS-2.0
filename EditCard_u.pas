unit EditCard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Win.ADODB, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, DM_u;

type
  TfrmEditCard = class(TForm)
    lbledtCardNumber: TLabeledEdit;
    lbledtOwnerName: TLabeledEdit;
    lbledtCardOwnerSurname: TLabeledEdit;
    lbledtCardBal: TLabeledEdit;
    btnCreateCard: TButton;
    qryEditCard: TADOQuery;
    tblEditCard: TADOTable;
    procedure btnUpdateCardClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEditCard: TfrmEditCard;

implementation
  uses
  GiftCard_u;
{$R *.dfm}

procedure TfrmEditCard.btnUpdateCardClick(Sender: TObject);
begin

  with tblEditCard do
  begin
    Locate('GiftCardNum', frmGiftCards.sCardNum, []);
    Edit;
    FieldByName('GiftCardNum').AsString := lbledtCardNumber.Text;
    FieldByName('OwnerName').AsString := lbledtOwnerName.Text;
    FieldByName('OwnerSurname').AsString := lbledtCardOwnerSurname.Text;
    FieldByName('CardBalance').AsCurrency:= StrToFloat(lbledtCardBal.Text);
    Post;
    ShowMessage('Updating Done');
    Hide;
  end;
end;



procedure TfrmEditCard.FormShow(Sender: TObject);
begin
  with qryEditCard do
  begin
    SQL.Text := ' select * from GiftCard where GiftCardNum=:CardNum ';
    Parameters.ParamByName('CardNum').Value := frmGiftCards.sCardNum;
    ExecSQL;
    Open;
    lbledtCardNumber.Text := FieldByName('GiftCardNum').AsString;
    lbledtOwnerName.Text := FieldByName('OwnerName').AsString;
    lbledtCardOwnerSurname.Text := FieldByName('OwnerSurname').AsString;
    lbledtCardBal.Text := FieldByName('CardBalance').AsString;
  end;
end;

end.
