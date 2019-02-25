; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "POS 2.0"
#define MyAppVersion "1.0"
#define MyAppPublisher "Izak Web Designs"
#define MyAppURL "https://izakwebdesigns.co.za"
#define MyAppExeName "POS.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{D924990F-FCDB-48DF-90C2-3CB4D2DB536B}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=C:\Users\Izak Hearn\Desktop\pos-2.0\Setup Files\
OutputBaseFilename=Pos 2.0 Setup
Compression=lzma2/max
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked


[Files]
Source: "C:\Users\Izak Hearn\Desktop\pos-2.0\Win32\Debug\POS.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\Izak Hearn\Desktop\pos-2.0\Setup Files\Database.accdb"; DestDir: "{userappdata}\POS 2.0\"; Flags: onlyifdoesntexist uninsneveruninstall
Source: "C:\Users\Izak Hearn\Desktop\pos-2.0\HTML Content\*"; DestDir: "{userappdata}\POS 2.0\HTML\"; Flags: ignoreversion
Source: "C:\Users\Izak Hearn\Desktop\pos-2.0\Setup Files\AccessDatabaseEngine.exe"; DestDir: "{app}"; AfterInstall: RunDatabaseDriverInstaller; Flags : deleteafterinstall;
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{commonprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[Code]
procedure RunDatabaseDriverInstaller;
var ResultCode : Integer;
begin
  Exec(ExpandConstant('{app}\AccessDatabaseEngine.exe'),'','',SW_SHOWNORMAL,
  ewWaitUntilTerminated, ResultCode);
end;

