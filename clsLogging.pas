unit clsLogging;

interface


uses
System.SysUtils,System.Classes, Winapi.Windows;

type
  TLog = class(TObject)

private
 //sLogType,sLogInput : string;
 fLogFile : TextFile;


public
constructor Create;
procedure WriteLog(sLogType:string;sLogInput:string);

end;

 implementation

 constructor TLog.Create();
 begin
   AssignFile(fLogFile, GetEnvironmentVariable('appdata') + '/POS 2.0/LOGS/' +
    FormatDateTime('dd-mm-yyyy',Now) + '.log');
   if FileExists( GetEnvironmentVariable('appdata') + '/POS 2.0/LOGS/' +
    FormatDateTime('dd-mm-yyyy',Now) + '.log') = False then
   begin
      Rewrite(fLogFile);
      Close(fLogFile);
   end ;
   Append(fLogFile);


 end;

 procedure TLog.WriteLog(sLogType:string;sLogInput:string);
 begin
   try
   Append(fLogFile);
    Writeln(fLogFile,'['+TimeToStr(Now)+']['+sLogType+']'+sLogInput);
    CloseFile(fLogFile);
   except

   end;
 end;

end.
