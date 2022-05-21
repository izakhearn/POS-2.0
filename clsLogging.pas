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

 // This is for when we create the Logging object. This will be used when a section
 // of the application is suppose to log an action that is being preformed
 // The function will check if a log file exist and open it. If one does not exist
 // It will create a log file with today's date and append the .log for the file type
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

 // Section of the application will call this function when it is ready to write
 // and action to the log file. The function should be called after the create function
 // as it will need the log file to write to. In the application when you call this function
 // You should say whether the type of log is info , debug or an error. Then you sould
 // Passthough your log message.
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
