unit AddCard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DM_u, Data.Win.ADODB,
  Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmAddCard = class(TForm)
    lbledtCardNumber: TLabeledEdit;
    lbledtOwnerName: TLabeledEdit;
    lbledtCardOwnerSurname: TLabeledEdit;
    lbledtStartingBal: TLabeledEdit;
    btnCreateCard: TButton;
    qryAddCard: TADOQuery;
    tblAddCard: TADOTable;
    procedure btnCreateCardClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddCard: TfrmAddCard;

implementation
  uses
  GiftCard_u;
{$R *.dfm}

procedure TfrmAddCard.btnCreateCardClick(Sender: TObject);
begin
if (lbledtCardNumber.Text = '') or (lbledtOwnerName.Text = '') or
    (lbledtCardOwnerSurname.Text = '') or (lbledtStartingBal.Text = '')
 then
  begin
    ShowMessage('Please make sure all fields are filled in correctly ');
    Exit;
  end;
  if tblAddCard.Locate('GiftCardNum', lbledtCardNumber.Text, []) = True then
  begin
    ShowMessage('Card Number already in use. Please try another one');
    lbledtCardNumber.Clear;
    lbledtCardNumber.SetFocus;
    Exit;
  end;
  with qryAddCard do
  begin
    SQL.Text :=
      'INSERT INTO GiftCard ([GiftCardNum],[OwnerName],[OwnerSurname],[CardBalance]) VALUES (:CardNum,:OName,:OSurname,:CBal)';
    Parameters.ParamByName('CardNum').Value := lbledtCardNumber.Text;
    Parameters.ParamByName('OName').Value := lbledtOwnerName.Text;
    Parameters.ParamByName('OSurname').Value := lbledtCardOwnerSurname.Text;
    Parameters.ParamByName('CBal').Value := lbledtStartingBal.Text;
    ExecSQL;
  end;
  ShowMessage('Card successfully created.');
  Hide;
end;

procedure TfrmAddCard.FormShow(Sender: TObject);
begin
 qryAddCard.Active:= True;
 tblAddCard.Active:= True;
end;

end.
