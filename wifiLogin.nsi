; example2.nsi
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install example2.nsi into a directory that the user selects.
;
; See install-shared.nsi for a more robust way of checking for administrator rights.
; See install-per-user.nsi for a file association example.

;--------------------------------
!include MUI2.nsh
; The name of the installer
Name "NUY WiFi Login"

; The file to write
OutFile "WiFiLogin Installer.exe"

; Request application privileges for Windows Vista and higher
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir "$PROGRAMFILES64\NUY WiFi Login"

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\NUY WiFi Login" "Install_Dir"

!define MUI_ABORTWARNING

;--------------------------------

; Pages

!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_LANGUAGE "SimpChinese"

;--------------------------------

; The stuff to install
Section "NUY WiFi Login (required)"

  SectionIn RO
  
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r "windows\*"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM "Software\NUY WiFi Login" "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NUY WiFi Login" "DisplayName" "NUY WiFi Login"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NUY WiFi Login" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NUY WiFi Login" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NUY WiFi Login" "NoRepair" 1
  WriteUninstaller "$INSTDIR\uninstall.exe"
  
SectionEnd

; Optional section (can be disabled by the user)
Section "Start Menu Shortcuts"

  CreateDirectory "$SMPROGRAMS\NUY WiFi Login"
  CreateShortcut "$SMPROGRAMS\NUY WiFi Login\Uninstall.lnk" "$INSTDIR\uninstall.exe"
  CreateShortcut "$SMPROGRAMS\NUY WiFi Login\NUY WiFi Login.lnk" "$INSTDIR\wifilogin.exe"

SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\NUY WiFi Login"
  DeleteRegKey HKLM "SOFTWARE\NUY WiFi Login"

  ; Remove files and uninstaller
  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\NUY WiFi Login\*.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\NUY WiFi Login"
  RMDir /r "$INSTDIR"

SectionEnd
