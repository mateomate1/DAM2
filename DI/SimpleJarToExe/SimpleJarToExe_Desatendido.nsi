Outfile "SimpleJarToExeTest_Desatendido.exe"
InstallDir "$PROGRAMFILES\SimpleJarToExeTest"
RequestExecutionLevel admin

Page instfiles

Section "Instalar"
    SetOutPath "$INSTDIR"
    
    File /r "C:\Users\Mateo\Documents\GitHub\DAM2\DI\SimpleJarToExe\*.*"
    
    CreateShortcut "$DESKTOP\SimpleJarToExeTest.lnk" "$INSTDIR\SimpleJarToExeTest.exe"
    
    CreateDirectory "$SMPROGRAMS\SimpleJarToExeTest"
    CreateShortcut "$SMPROGRAMS\SimpleJarToExeTest\SimpleJarToExeTest.lnk" "$INSTDIR\SimpleJarToExeTest.exe"
    
    WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
    Delete "$INSTDIR\*.*"
    RMDir /r "$INSTDIR"  ; Elimina la carpeta completa con todo su contenido

    Delete "$DESKTOP\SimpleJarToExeTest.lnk"
    Delete "$SMPROGRAMS\SimpleJarToExeTest\SimpleJarToExeTest.lnk"
    RMDir "$SMPROGRAMS\SimpleJarToExeTest"
    
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\SimpleJarToExeTest"
SectionEnd
