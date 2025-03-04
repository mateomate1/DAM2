; Script de instalación con NSIS
!define APP_NAME "SimpleJarToExeTest"
!define APP_VERSION "1.0"
!define APP_PUBLISHER "Mateo y Mario DAM2"
!define APP_EXE "SimpleJarToExeTest.exe"
!define INSTALL_DIR "$PROGRAMFILES\${APP_NAME}"

Outfile "MiAplicacion-Setup.exe"
InstallDir "${INSTALL_DIR}"

Section "Instalar"
    SetOutPath "${INSTALL_DIR}"
    File "MiAplicacion.exe"
    File "MiAplicacion.dll"
    File "config.ini"

    ; Agregar al menú de inicio
    CreateDirectory "$SMPROGRAMS\${APP_NAME}"
    CreateShortCut "$SMPROGRAMS\${APP_NAME}\Desinstalar.lnk" "$INSTDIR\uninstall.exe"

    ; Guardar ruta de instalación para desinstalación
    WriteRegStr HKLM "Software\${APP_NAME}" "InstallDir" "$INSTDIR"

    ; Copiar desinstalador
    WriteUninstaller "$INSTDIR\uninstall.exe"
SectionEnd

Section "Desinstalar"
    Delete "$INSTDIR\MiAplicacion.exe"
    Delete "$INSTDIR\MiAplicacion.dll"
    Delete "$INSTDIR\config.ini"
    Delete "$INSTDIR\uninstall.exe"

    RMDir "$INSTDIR"

    Delete "$SMPROGRAMS\${APP_NAME}\Desinstalar.lnk"
    RMDir "$SMPROGRAMS\${APP_NAME}"

    DeleteRegKey HKLM "Software\${APP_NAME}"
SectionEnd

