#Include, sendInput.ahk
pause
productName := ""
getProductName(productName)
msgbox % productName

F2::
  if WinExist("Google Chrome")
    WinActivate
  Pause,, 1 ;Pause Script off/on
return 
Esc::
ExitApp