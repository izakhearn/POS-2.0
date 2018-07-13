unit clsEmployeeInfo;

interface

type
  TEmployeeInfo = class(TObject)
  private
    fName, fNumber, fSurname, fEmail: string;
    fID: Integer;

  public
    constructor Create(sName: string; sSurname: string; sNumber: string;
      sEmail: string; iID: Integer);
    function GetID: Integer;
    function GetName: string;
    function GetSurname: string;
    function GetEmail: string;
    function GetNumber: string;

  end;

implementation

uses
  System.SysUtils;
{ TEmployeeInfo }

constructor TEmployeeInfo.Create(sName, sSurname, sNumber, sEmail: string;
  iID: Integer);
begin
  fName := sName;
  fSurname := sSurname;
  fEmail := sEmail;
  fNumber := sNumber;
  fID := iID;
end;

function TEmployeeInfo.GetEmail: string;
begin
  Result := fName;
end;

function TEmployeeInfo.GetID: Integer;
begin
  Result := fID;
end;

function TEmployeeInfo.GetName: string;
begin
  Result := fName;
end;

function TEmployeeInfo.GetNumber: string;
begin
  Result := fNumber;
end;

function TEmployeeInfo.GetSurname: string;
begin
  Result := fSurname;
end;

end.
