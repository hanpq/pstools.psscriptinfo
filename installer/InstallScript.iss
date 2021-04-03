[Setup]
AppId={{ f49be34c-e1a9-4e1e-9a98-ed2b72b78efa }}
AppName=pstools.psscriptinfo
AppVersion=1.3.1
AppPublisher=
AppPublisherURL=
AppSupportURL=
AppUpdatesURL=
DefaultDirName={userdocs}\WindowsPowerShell\Modules\pstools.psscriptinfo
DisableDirPage=yes
DefaultGroupName=pstools.psscriptinfo
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir=C:\Users\hanpalmq\OneDrive\DEV\Powershell\modules\pstools.psscriptinfo\release\1.3.1
OutputBaseFilename=pstools.psscriptinfo.1.3.1.Installer
Compression=lzma
SolidCompression=yes
WizardStyle=modern
Uninstallable=yes
SetupIconFile=C:\Users\hanpalmq\OneDrive\DEV\Powershell\modules\pstools.psscriptinfo\stage\pstools.psscriptinfo\1.3.1\data\appicon.ico

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "C:\Users\hanpalmq\OneDrive\DEV\Powershell\modules\pstools.psscriptinfo\stage\pstools.psscriptinfo\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs skipifsourcedoesntexist

[Icons]
Name: "{userdesktop}\pstools.psscriptinfo"; Filename: "{sys}\WindowsPowerShell\v1.0\powershell.exe"; Parameters: "-executionpolicy bypass -noexit -noprofile -file ""{app}\1.3.1\data\banner.ps1"""; IconFilename: "{app}\1.3.1\data\AppIcon.ico"

[Run]
Filename: "Powershell.exe"; Parameters: "-executionpolicy bypass -noexit -noprofile -file ""{app}\1.3.1\data\banner.ps1"""; Description: "Run pstools.psscriptinfo"; Flags: postinstall nowait


