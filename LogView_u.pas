unit LogView_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmLog = class(TForm)
    mmoLogView: TMemo;
    tmrUpdateLog: TTimer;
    tmrScroll: TTimer;
    procedure tmrUpdateLogTimer(Sender: TObject);
    procedure tmrScrollTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLog: TfrmLog;

implementation

{$R *.dfm}

procedure TfrmLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 tmrScroll.Enabled:= False;
  tmrUpdateLog.Enabled:= False;;
end;

procedure TfrmLog.FormHide(Sender: TObject);
begin
  tmrScroll.Enabled:= False;
  tmrUpdateLog.Enabled:= False;
end;

procedure TfrmLog.FormShow(Sender: TObject);
begin
  tmrScroll.Enabled:= True;
  tmrUpdateLog.Enabled:= True;
   frmLog.SendToBack;
end;

procedure TfrmLog.tmrScrollTimer(Sender: TObject);
begin

    begin
       //mmoLogView.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
      mmoLogView.SelStart := Length(mmoLogView.Text);
      mmoLogView.Perform(EM_SCROLLCARET, 0, 0);
    end;
end;

procedure TfrmLog.tmrUpdateLogTimer(Sender: TObject);
begin
     begin
      mmoLogView.Lines.LoadFromFile(GetEnvironmentVariable('appdata') + '/POS 2.0/LOGS/' +
        FormatDateTime('dd-mm-yyyy',Now) + '.log');
     end;
end;

end.
