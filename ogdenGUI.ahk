#SingleInstance, force

;DEFINE VARIABLE
version := "1.0"

;BEGINNING

Gui, Add, Text, x10 y30 , Choose mode:
Gui, Add, Radio,gisSingle x120 y30, Single
Gui, Add, Radio,gIsLoop, Loop

Gui, +AlwaysOnTop
Gui, Show, x1200 y100 w500 h500, Ogden Assistant ver %version%, `t
Return

isLoop:
    Gui, Show, x1200 y100 w500 h500, Ogden Assistant ver %version%, `t
return
isSingle:
    Gui, Show, x1200 y100 w500 h200, Ogden Assistant ver %version%, `t
return
Esc::ExitApp

F2::Reload