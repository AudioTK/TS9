[Setup]
AppName=TS9
AppVersion=1.0


DefaultDirName={pf}\TS9
DefaultGroupName=TS9
Compression=lzma2
SolidCompression=yes
OutputDir=.\
ArchitecturesInstallIn64BitMode=x64
OutputBaseFilename=TS9 Installer
LicenseFile=license.rtf
SetupLogging=yes

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "vst3_32"; Description: "32-bit VST3 Plugin (.vst3)"; Types: full custom;
Name: "vst3_64"; Description: "64-bit VST3 Plugin (.vst3)"; Types: full custom; Check: Is64BitInstallMode;
Name: "manual"; Description: "User guide"; Types: full custom; Flags: fixed

[Files]
Source: "..\Builds\VisualStudio2019_32\Win32\Release\VST3\TS9.vst3"; DestDir: "{cf}\VST3\"; Check: not Is64BitInstallMode; Components:vst3_32; Flags: ignoreversion;
Source: "..\Builds\VisualStudio2019_32\Win32\Release\VST3\TS9.vst3"; DestDir: "{cf32}\VST3\"; Check: Is64BitInstallMode; Components:vst3_32; Flags: ignoreversion;
Source: "..\Builds\VisualStudio2019\x64\Release\VST3\TS9.vst3"; DestDir: "{cf64}\VST3\"; Check: Is64BitInstallMode; Components:vst3_64; Flags: ignoreversion;

Source: "..\manual\TS9_manual.pdf"; DestDir: "{app}"
Source: "changelog.txt"; DestDir: "{app}"
Source: "readmewin.rtf"; DestDir: "{app}"; DestName: "readme.rtf"; Flags: isreadme

[Icons]
Name: "{group}\TS9"; Filename: "{app}\TS9.exe"
;Name: "{group}\User guide"; Filename: "{app}\TS9_manual.pdf"
Name: "{group}\Changelog"; Filename: "{app}\changelog.txt"
;Name: "{group}\readme"; Filename: "{app}\readme.rtf"
Name: "{group}\Uninstall TS9"; Filename: "{app}\unins000.exe"

;[Dirs] 
;Name: {cf}\Digidesign\DAE\Plugins\

[Code]
var
  OkToCopyLog : Boolean;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssDone then
    OkToCopyLog := True;
end;

procedure DeinitializeSetup();
begin
  if OkToCopyLog then
    FileCopy (ExpandConstant ('{log}'), ExpandConstant ('{app}\InstallationLogFile.log'), FALSE);
  RestartReplace (ExpandConstant ('{log}'), '');
end;

[UninstallDelete]
Type: files; Name: "{app}\InstallationLogFile.log"
