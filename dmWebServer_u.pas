unit dmWebServer_u;

interface

uses
  System.SysUtils, System.Classes, IdHTTPServer, IdContext, IdCustomHTTPServer,
  IdBaseComponent, IdComponent, IdCustomTCPServer, System.StrUtils,
  Vcl.FileCtrl;

type
  TdmHttpServer = class(TDataModule)
    httpserverMain: TIdHTTPServer;
    procedure httpserverMainCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmHttpServer: TdmHttpServer;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TdmHttpServer.httpserverMainCommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  HTMLFileName, WorkingDir: string;
begin
  WorkingDir := GetEnvironmentVariable('appdata') + '/POS 2.0/HTML/';
  SetCurrentDir(WorkingDir);
  try
    if ARequestInfo.Document.StartsWith('/') then
    begin
      HTMLFileName := Copy(ARequestInfo.Document, 2, MaxInt);
      if HTMLFileName = '' then
      begin
        HTMLFileName := WorkingDir + 'index.html';
      end;
      AResponseInfo.ResponseNo := 200;
      AResponseInfo.ContentStream := TFileStream.Create(HTMLFileName,
        fmShareDenyWrite);
      AResponseInfo.ContentType := httpserverMain.MIMETable.GetFileMIMEType
        (HTMLFileName);
    end
    else
    begin
      AResponseInfo.ResponseNo := 404;
      AResponseInfo.ContentStream := TFileStream.Create(WorkingDir + '404.html',
        fmShareDenyWrite);
      AResponseInfo.ContentType := httpserverMain.MIMETable.GetFileMIMEType
        (GetEnvironmentVariable('appdata') + '/POS 2.0/HTML/404.html')
    end;
  except
    AResponseInfo.ResponseNo := 404;
    AResponseInfo.ContentStream := TFileStream.Create(WorkingDir + '404.html',
      fmShareDenyWrite);
    AResponseInfo.ContentType := httpserverMain.MIMETable.GetFileMIMEType
      (GetEnvironmentVariable('appdata') + '/POS 2.0/HTML/404.html')
  end;

end;

end.
