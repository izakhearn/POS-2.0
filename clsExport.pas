unit clsExport;

interface

uses
  Vcl.DBGrids, Vcl.Forms, Vcl.Grids, System.SysUtils, Vcl.Dialogs,
  System.Classes,clsLogging;

type
  TExport = class(TObject)
  private
    { private declarations }
    fGrid: TDBGrid;
    fStringGrid: TStringGrid;
    fFileName: string;
    csvExport: TextFile;
    fSave: TSaveDialog;
    Self2: TComponent;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(sGrid: TDBGrid; sFileName: string);
    procedure ExportToCSV;
    procedure ExportToHTML(sFrom: string);

  published
    { published declarations }
  end;

implementation

{ TExport }

constructor TExport.Create(sGrid: TDBGrid; sFileName: string);
var
  I: Integer;
begin
  fGrid := sGrid;
  fFileName := sFileName;
  fStringGrid := TStringGrid.Create(Self2);
  fStringGrid.RowCount := fGrid.DataSource.DataSet.RecordCount + 1;
  fStringGrid.ColCount := fGrid.FieldCount;
  for I := 0 to fGrid.FieldCount - 1 do
  begin
    fStringGrid.Cells[I, 0] := fGrid.Fields[I].DisplayName;
  end;
  fGrid.DataSource.DataSet.First;
  while not fGrid.DataSource.DataSet.Eof do
  begin
    for I := 0 to fGrid.FieldCount - 1 do
    begin
      fStringGrid.Cells[I, fGrid.DataSource.DataSet.RecNo] :=
        fGrid.DataSource.DataSet.Fields[I].AsString;
    end;
    fGrid.DataSource.DataSet.Next;
  end;
end;

procedure TExport.ExportToCSV;
var
  I: Integer;
  objLog: TLog;
begin
  fSave := TSaveDialog.Create(Self2);
  fSave.Title := 'Choose where to save exported file';
  fSave.InitialDir := GetHomePath;
  fSave.Filter := 'CSV File|*.csv';
  fSave.DefaultExt := 'csv';
  fSave.FilterIndex := 1;
  if fSave.Execute then
  begin
    fFileName := fSave.FileName;
    AssignFile(csvExport, fFileName);
    Rewrite(csvExport);
    for I := 0 to fStringGrid.RowCount - 1 do
    begin
      Writeln(csvExport, fStringGrid.Rows[I].CommaText);
    end;
    CloseFile(csvExport);
  end
  else
  begin
    MessageDlg('Exporting Cancelled', mtInformation, [mbOK], 0);
  end;
  fSave.Free;
  fStringGrid.Free;
  objLog:= TLog.Create;
  objLog.WriteLog('INFO','Exporting CSV File : Successful');
  objLog.Free;
end;

procedure TExport.ExportToHTML(sFrom: string);
var
  HTMLFile: TextFile;
  I, iTemp: Integer;
  rSum: Real;
  K: Integer;
  objLog : TLog;
begin
  AssignFile(HTMLFile, GetEnvironmentVariable('appdata') + '/POS 2.0/HTML/' +
    sFrom + '.html');
  Rewrite(HTMLFile);
  Writeln(HTMLFile,
    '<!DOCTYPE html><html><head><meta name="viewport" content="width=device-width, initial-scale=1">'
    + '<meta charset="utf-8">' +
    ' <title>POS 2.0 HTML REPORTS</title>'+
    ' <script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>' +
    '<link rel="stylesheet" type="text/css" href="https://printjs-4de6.kxcdn.com/print.min.css">'
    + ' <link rel="stylesheet" media="all" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css">'
    + '<script defer src="https://use.fontawesome.com/releases/v5.0.7/js/all.js"></script>'
    + '</head>');
  Writeln(HTMLFile,
    '<body><section class="section"><div id="print" class="container"><center><h1 class="title">POS 2.0 '
    + sFrom + ' Report</h1>' + '<p class="subtitle">Last Generated On ' +
    DateTimeToStr(Now) + '</p></center>');
  Writeln(HTMLFile,
    '<section class="section"><div class="container"><center><table class="table is-bordered is-striped is-narrow is-hoverable is-fullwidth">');
  Writeln(HTMLFile, '<thead>');
  Writeln(HTMLFile, '<tr class="is-selected">');
  for I := 0 to fStringGrid.ColCount - 1 do
  begin
    Writeln(HTMLFile, '<th>' + fStringGrid.Cells[I, 0] + '</th>');
  end;
  Writeln(HTMLFile, '</tr>');
  Writeln(HTMLFile, '</thead>');
  Writeln(HTMLFile, '<tbody>');
  for I := 1 to fStringGrid.RowCount - 1 do
  begin
    Writeln(HTMLFile, '<tr>');
    for K := 0 to fStringGrid.ColCount - 1 do
    begin
      Writeln(HTMLFile, '<th>' + fStringGrid.Cells[K, I] + '</th>');
    end;
    Writeln(HTMLFile, '</tr>');
  end;
  if sFrom = 'Transaction' then
  begin
    rSum := 0;
    Writeln(HTMLFile, '<tr>');
    Writeln(HTMLFile, '<th>Total :</th>');
    Writeln(HTMLFile, '<th> </th>');
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[2, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffCurrency, 100, 2) + '</th>');
    rSum := 0;
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[3, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffCurrency, 100, 2) + '</th>');
    rSum := 0;
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[4, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffFixed, 100, 0) + '</th>');
    Writeln(HTMLFile, '<th> </th>');
    Writeln(HTMLFile, '<th> </th>');
    Writeln(HTMLFile, '</tr>');

  end;
  if sFrom = 'Product' then
  begin
    rSum := 0;
    Writeln(HTMLFile, '<tr>');
    Writeln(HTMLFile, '<th>Total :</th>');
    Writeln(HTMLFile, '<th> </th>');
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[2, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffCurrency, 100, 2) + '</th>');
    rSum := 0;
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[3, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffCurrency, 100, 2) + '</th>');
    Writeln(HTMLFile, '</tr>');

  end;
  if sFrom = 'Stock' then
  begin
    rSum := 0;
    Writeln(HTMLFile, '<tr>');
    Writeln(HTMLFile, '<th>Total :</th>');
    Writeln(HTMLFile, '<th> </th>');
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[2, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffFixed, 100, 0) + '</th>');
    Writeln(HTMLFile, '</tr>');

  end;
  if sFrom = 'GiftCard' then
  begin
    rSum := 0;
    Writeln(HTMLFile, '<tr>');
    Writeln(HTMLFile, '<th>Total :</th>');
    Writeln(HTMLFile, '<th> </th>');
    Writeln(HTMLFile, '<th> </th>');
    for I := 1 to fStringGrid.RowCount - 1 do
    begin
      rSum := StrToFloat(fStringGrid.Cells[3, I]) + rSum;
    end;
    Writeln(HTMLFile, '<th>' + floattostrf(rSum, ffFixed, 100, 0) + '</th>');
    Writeln(HTMLFile, '</tr>');

  end;

  Writeln(HTMLFile, '</tbody>');
  Writeln(HTMLFile, '</table>');
  Writeln(HTMLFile, '<a onclick="printJS(' + #96 + 'print' + #96 + ',' + #96 +
    'html' + #96 +
    ')" class="button is-primary is-large is-rounded">Print Report</a>');
  Writeln(HTMLFile, '</center></div></section></body></html>');
  CloseFile(HTMLFile);
  objLog:= TLog.Create;
  objLog.WriteLog('INFO','Exporting HTML Report : Success');
  objLog.Free;
end;

end.
