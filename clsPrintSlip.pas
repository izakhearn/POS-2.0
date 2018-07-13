unit clsPrintSlip;

interface

uses
  Vcl.Printers, Vcl.Grids, Vcl.Dialogs, System.SysUtils, System.Types,
  Vcl.Graphics;

type
  TPrintSlip = class(TObject)
  private
    { private declarations }
    fGrid: TStringGrid;
    fTotal, fTender, fChange, fVat, fPrinterName, fTitle: string;
  public
    { public declarations }
    constructor Create(sGrid: TStringGrid; sTotal: string; sTender: string;
      sChange: string; sVat: string; sTitle: string);
    procedure StartPrint;
  end;

implementation

{ TPrintSlip }

constructor TPrintSlip.Create(sGrid: TStringGrid;
  sTotal, sTender, sChange, sVat, sTitle: string);
begin
  if (Printer.Printers.Count > 0) then
  begin
    Printer.PrinterIndex := -1;
    fPrinterName := Printer.Printers[Printer.PrinterIndex];

  end
  else
  begin
    MessageDlg
      ('NO PRINTERS FOUND! Please install a printer for this function to work.',
      mtError, [mbOK], 0);
    Exit;
  end;
  fTitle := sTitle;
  fGrid := sGrid;
  fTotal := sTotal;
  fTender := sTender;
  fChange := sChange;
  fVat := sVat;
  fGrid.RowCount := fGrid.RowCount + 1;
  fGrid.Cells[0, fGrid.RowCount] := 'VAT 15% :';
  fGrid.Cells[2, fGrid.RowCount] := fVat;
  fGrid.RowCount := fGrid.RowCount + 1;
  fGrid.Cells[0, fGrid.RowCount] := 'Total :';
  fGrid.Cells[2, fGrid.RowCount] := fTotal;
  fGrid.RowCount := fGrid.RowCount + 1;
  fGrid.Cells[0, fGrid.RowCount] := 'Amount Tendered';
  fGrid.Cells[2, fGrid.RowCount] := fTender;
  fGrid.RowCount := fGrid.RowCount + 1;
  fGrid.Cells[0, fGrid.RowCount] := 'Change :';
  fGrid.Cells[2, fGrid.RowCount] := fChange;
end;

procedure TPrintSlip.StartPrint;
var
  X1, X2: Integer;
  Y1, Y2: Integer;
  TmpI: Integer;
  F: Integer;
  TR: TRect;
begin
  Printer.Title := fTitle;
  Printer.BeginDoc;
  Printer.Canvas.Pen.Color := 0;
  Printer.Canvas.Font.Name := 'Times New Roman';
  Printer.Canvas.Font.Size := 12;
  Printer.Canvas.Font.Style := [fsBold, fsUnderline];
  Printer.Canvas.TextOut(0, 100, Printer.Title);
  for F := 0 to fGrid.ColCount do
  begin
    X1 := 0;
    for TmpI := 0 to (F - 1) do
      X1 := X1 + 5 * (fGrid.ColWidths[TmpI]);
    Y1 := 300;
    X2 := 0;
    for TmpI := 0 to F do
      X2 := X2 + 5 * (fGrid.ColWidths[TmpI]);
    Y2 := 450;
    TR := Rect(X1, Y1, X2 - 30, Y2);
    Printer.Canvas.Font.Style := [fsBold];
    Printer.Canvas.Font.Size := 7;
    Printer.Canvas.TextRect(TR, X1 + 50, 350, fGrid.Cells[F, 0]);
    Printer.Canvas.Font.Style := [];
    for TmpI := 0 to fGrid.RowCount do
    begin
      Y1 := 150 * TmpI + 300;
      Y2 := 150 * (TmpI + 1) + 300;
      TR := Rect(X1, Y1, X2 - 30, Y2);
      Printer.Canvas.TextRect(TR, X1 + 50, Y1 + 50, fGrid.Cells[F, TmpI]);
    end;
  end;
  Printer.EndDoc;

end;

end.
