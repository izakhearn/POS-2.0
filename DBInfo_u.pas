unit DBInfo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmDBInfo = class(TForm)
    edtDatabaseName: TLabeledEdit;
    edtServerAddress: TLabeledEdit;
    edtDBUsername: TLabeledEdit;
    edtDBPassword: TLabeledEdit;
    btnSaveDB: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaveDBClick(Sender: TObject);
  private
    { Private declarations }
      fDBInfo : TextFile;
  public
    { Public declarations }
  end;

var
  frmDBInfo: TfrmDBInfo;

implementation

{$R *.dfm}

procedure TfrmDBInfo.btnSaveDBClick(Sender: TObject);
var
 sTemp : string;
begin
  try
     Rewrite(fDBInfo) ;
     sTemp:= edtServerAddress.Text;
     Writeln(fDBInfo, sTemp);
     sTemp:= edtDatabaseName.Text;
     Writeln(fDBInfo, sTemp);
     sTemp:= edtDBUsername.Text;
     Writeln(fDBInfo, sTemp);
     sTemp:= edtDBPassword.Text;
     Writeln(fDBInfo, sTemp);
     CloseFile(fDBInfo);
  except
   on E : Exception do
       begin
        ShowMessage('An Error Occured writing to the database file');
       end;
  end;
  Hide;
end;

procedure TfrmDBInfo.FormShow(Sender: TObject);
var
  sTemp :string;
begin
  AssignFile(fDBInfo,GetEnvironmentVariable('APPDATA') + '\POS 2.0\DBInfo') ;

  if FileExists(GetEnvironmentVariable('APPDATA') + '\POS 2.0\DBInfo') then
  begin

  end;

  end;

end.
