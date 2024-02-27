#Include, sendInput.ahk
SetTitleMatchMode, 2
;#IfWinActive - Google Chrome
#SingleInstance, force
DELAY_TIME := 50 ;second

array := []
arrayCount:= loadArray(array)
if (arrayCount = 0) { 
    MsgBox,,, The FreeFormResponse file is empty!
    ExitApp
}

;  DO NOT MODIFY ALL THING BELOW!!!
max := 0
option := 0
rand := 0
job_reviewed := 0
NR:=0
DELAY_TIME_IN_MILISECOND := DELAY_TIME * 1000

splash_counter(job_reviewed, job_remaining, NR)
{
    SplashTextOn, 200, 80, Counter:, 
    (
    Jobs reviewed: %job_reviewed%
    Remaining: %job_remaining%
    NR: %NR%
    )
    WinMove, Counter:, , (A_ScreenWidth - 200), (A_ScreenHeight - 1080)
}
;END FUNCTION IMPLEMENTING
MsgBox, 0, READ THIS CAREFULLY!,
(
Press F2 to pause/continue the program
Press Esc to exit the program 
Alert!: Make sure that Unikey (or whatever program has the same function) has been turned off to use this program! 
) 
TASK_COUNT := Floor(3600 / DELAY_TIME)
InputBox, option, Enter your option!, 1. Once each time you press F2.`n2. Loop mode, this will loop once each %DELAY_TIME% seconds (%TASK_COUNT% times an hour).,300,150
If (option = 1)
{
    max = 1
}
else if (option = 2)
{
    InputBox, max, Counter, 
    (
    How many times you want to have this program repeated?
    Note: Press F2 to start executing after this.
    )
}
Else{
    MsgBox, 0, ERROR!,
    (
    Program terminated due to inappropriate input value.
    )
    ExitApp,
}
If ErrorLevel
{
    MsgBox, 0, Canceled!,
    (
    You hit the cancel button, the program will be terminated then!
    )
    ExitApp
}

;Cover invalid input data type
If max is not integer
{
    MsgBox, 0, Error!, You did not enter a numberic data, this program will be terminated then!
    ExitApp
}

if WinExist("Google Chrome")
    WinActivate
job_remaining := max
Pause

if(option =1)
{
    Loop
    {
        productName := ""
        getProductName(productName)
        MouseClick, left, 308, 365
        Sleep, 500
        MouseClick, left, 308, 452
        Sleep, 500
        MouseClick, left, 308, 540
        Sleep, 500
        MouseClick, left, 308, 889
        Sleep, 500
        MouseClick, left, 308, 778
        Sleep, 250
        i := Mod(A_Index, arrayCount) + 1
        send % "This ad for " . productName . " " . array[i]
        Sleep, 250
        Send, {Tab}
        Sleep, 250
        Send, {Enter}
        Pause
    }

}
else if(option = 2)
{
    Loop 
    {
        Sleep, %DELAY_TIME_IN_MILISECOND% ;time between two ads reviewed
        productName := ""
        getProductName(productName)
        MouseClick, left, 308, 365
        Sleep, 500
        MouseClick, left, 308, 452
        Sleep, 500
        MouseClick, left, 308, 540
        Sleep, 500
        MouseClick, left, 308, 889
        Sleep, 500
        MouseClick, left, 308, 778
        Sleep, 250
        i := Mod(A_Index, arrayCount) + 1
        send % "This ad for " . productName . " " . array[i]
        Sleep, 250
        Send, {Tab}
        Sleep, 250
        Send, {Enter}

        job_reviewed := job_reviewed + 1
        job_remaining := job_remaining - 1
        splash_counter(job_reviewed,job_remaining,NR)
        If (job_remaining <= 0)
        {
            MsgBox, 4, Done, Successfully executed!`nDo you want to use this program one more time?`nClick No to exit the program.
            IfMsgBox Yes
            Reload
            else
                ExitApp
        }
    }
}
return

F2::
    if WinExist("Google Chrome")
        WinActivate
    Pause,, 1 ;Pause Script off/on
    ; setTimer, WinCheck, 5

Return
F4::
    NR := NR + 1
    job_remaining := job_remaining -1
    job_reviewed := job_reviewed + 1
    splash_counter(job_reviewed,job_remaining,NR)
Return

Esc::
ExitApp

