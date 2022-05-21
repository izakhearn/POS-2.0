unit clsGiftCard;

interface

  uses
  System.SysUtils, System.Variants, System.Classes, DM_u, Data.DB,
  Data.Win.ADODB, Vcl.Dialogs,clsLogging;

type

  TGiftCard = class(TObject)
    private
      { private declarations }
       fCardNum : string;
       fCurrentBal: Real;
       qryGiftCard: TADOQuery;
       tblGiftCard: TADOTable;
       Self2: TComponent;
    protected
      { protected declarations }

    public
      { public declarations }
      constructor Create (sCardNum : string);
      function GetCardNum  : string;
      function GetCurrBal  : Real;
      function CompletePayment(rAmountDue : Real): Boolean;
    published
      { published declarations }
      var
  objLog : TLog;
end;

implementation

{ TGiftCard }

function TGiftCard.CompletePayment(rAmountDue: Real) : Boolean;
begin
 if fCurrentBal - rAmountDue >= 0 then
 begin
   with tblGiftCard do
    begin
      Locate('GiftCardNum', fCardNum, []);
      Edit;
      FieldByName('CardBalance').AsCurrency := fCurrentBal - rAmountDue;
      Post;
      MessageDlg('Payment Successful',mtConfirmation,[mbOK],0);
    end;
    Result:= True;
 end
 else
 begin
   MessageDlg('Payment Failed due to Insufficient Funds. Funds Available :'+FloatToStrF(fCurrentBal,ffCurrency,10,2),mtConfirmation,[mbOK],0);
   Result:= False;
   objLog:= TLog.Create;
   objLog.WriteLog('INFO','Payment Status : Failed');
   objLog.WriteLog('INFO','Payment Failure Reason : Insufficient Funds');
   objLog.Free;
 end;
end;

constructor TGiftCard.Create(sCardNum : string);
begin
  qryGiftCard := TADOQuery.Create(Self2);
  qryGiftCard.Connection := DataModule1.conMain;
  tblGiftCard := TADOTable.Create(Self2);
  tblGiftCard.Connection := DataModule1.conMain;
  tblGiftCard.TableName := 'GiftCard';
  tblGiftCard.Active := True;
  fCardNum:= sCardNum;
  with qryGiftCard do
  begin
    SQL.Text:= 'SELECT * FROM GiftCard WHERE GiftCardNum=:CardNum';
    Parameters.ParamByName('CardNum').Value := fCardNum;
    ExecSQL;
    Open;
    fCurrentBal:= FieldByName('CardBalance').AsFloat;
    objLog:= TLog.Create;
   objLog.WriteLog('INFO','Creating New Gift Card ; Successful');
   objLog.Free;
  end;
end;

function TGiftCard.GetCardNum: string;
begin
 Result:= fCardNum;
end;

function TGiftCard.GetCurrBal: Real;
begin
 Result:= fCurrentBal;
end;

end.
