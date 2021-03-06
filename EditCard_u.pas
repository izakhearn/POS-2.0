unit EditCard_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.Win.ADODB, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, DM_u, clsLogging;

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
  objLog : TLog;

implementation
  uses
  GiftCard_u;
{$R *.dfm}


// This function of here is for updating the Gift Card with the new infomation the user
// Has entered
procedure TfrmEditCard.btnUpdateCardClick(Sender: TObject);
begin
   try
   // Here we try and locate the record that matches the Gift Card number that we want to edit
   // If then goes and updates all the changed information to the database
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
        // Write to the application log that a gift card was updated.
        objLog:= TLog.Create;
        objLog.WriteLog('INFO','Updating Gift Card : Successfull');
        objLog.Free;
      end;
    except
    on E : Exception do
    begin
      // Write to the log that the gift card could not be updated and add the reason why
      objLog:= TLog.Create;
      objLog.WriteLog('ERROR','Updating Gift Card : Failed');
      objLog.WriteLog('ERROR','Reason For Failure : See Message Below');
      objLog.WriteLog('ERROR',E.ClassName+' : '+E.Message);
      objLog.Free;
    end;

   end;

end;


// When this form is first activated it goes and fecthes the Gifc Card we are going to edit
procedure TfrmEditCard.FormShow(Sender: TObject);
begin
  qryEditCard.Active:= True;
  tblEditCard.Active:= True;
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
