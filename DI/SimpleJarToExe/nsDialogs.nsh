!ifndef __NSDIALOGS_NSH__
!define __NSDIALOGS_NSH__

!macro NSD_CreateCheckBox X Y W H TEXT
  Push ${NSD_CreateCheckBox}
  Exch $0
  nsDialogs::CreateControl "Button" "BS_AUTOCHECKBOX | WS_TABSTOP | WS_VISIBLE | WS_CHILD" "${X}" "${Y}" "${W}" "${H}" "$1"
  Pop $0
  !insertmacro NSD_SetText "$0" "${TEXT}"
!macroend

!macro NSD_SetText HWND TEXT
  System::Call 'USER32::SetWindowText(p $0, t "${TEXT}")'
!macroend

!macro NSD_GetState HWND VAR
  System::Call 'USER32::SendMessage(p $HWND, i 0xF0, i 0, i 0) i .r1'
  StrCpy $VAR $1
!macroend

!macro NSD_SetState HWND STATE
  System::Call 'USER32::SendMessage(p $HWND, i 0xF1, i ${STATE}, i 0)'
!macroend

!endif
