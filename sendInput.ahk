; List = clothing store|medical products|funiture|skincare products|financial service|drugstore|driving course|English course|soccer page|education center|shoes|decorations|beauty center|game app|bacarat|lot|health care products|weight loss products|financial service|Hiup milk|MB Bank|houseware|dental care|Vietcombank|Viettinbank|sunscreen|dental care|loan service|foods|dermatology clinic|manual
iniFilePath := "options.ini"
global OptionList := {}
List := LoadListFromINI(iniFilePath)

Gui -Caption +AlwaysOnTop
gui font, s12
Gui Margin, 2,2
Gui Add, ListBox, x2 y2 r5 w240 vChoice, %List%
Gui add, text, w200 vText
getProductName(ByRef ProductName)
{
    gui show, x1200 y350
    WinGet GuiID, ID, A                 ; ID of the GUI for ControlSend below
    Text = 
    c =
    Loop
    {
        Text = %c%
        GuiControl,,Text, search: %Text%
        If ek in Up,Down                 ; navigate in the ListBox
        ControlSend ListBox1, {%ek%}, ahk_id %GuiID%
        Else {                           ; select bottom entry, then abbreviation
            GuiControl ChooseString,Choice,manual    ;... to show it on top
            GuiControl ChooseString,Choice,%c%
            GuiControlGet Choice          ; get selected
        }
        Input k, I L1 M, {Enter}{Esc}{TAB}{BS}{Up}{Down}
        StringTrimLeft ek, ErrorLevel, 7 ; Remove "Endkey:"
    
        If ek in Escape
            exitapp                     ; exit
        If ek = Enter
        {
            GuiControlGet Choice
            if (Choice = "manual" && c = "")
                Continue
            Break
        }
        If ek = Backspace
        {
            StringTrimRight c,c,1         ; remove last char
        }
        c := c . k
    }
    GuiControlGet Choice 
    gui submit
    if (Choice = "manual")
        ProductName := c
    Else
        ProductName := Choice
    UpdateFrequency(ProductName)
}

loadArray(ByRef array) {
    arrayCount := 0
    Loop, Read, %A_ScriptDir%\FreeFormResponse.txt ; This loop retrieves each line from the file, one at a time.
    {
        arrayCount += 1
        array.Push(A_LoopReadLine) ; Append this line to the array.
    }
    return arrayCount
}

LoadListFromINI(filePath) {
    global OptionList
    IniRead, sections, %filePath%
    totalFreq := 0
    Loop, Parse, sections, `n, `r
    {
        section := A_LoopField
        if (section != "")
        {
            IniRead, freq, %filePath%, %section%, frequency, 0
            OptionList[section] := freq
            totalFreq += freq
        }
    }

    if (totalFreq >= 500)
    {
        RemoveLowFrequencyOptions()
        ; Set frequencies to 1 for all options after cleanup
        for option, _ in OptionList
        {
            OptionList[option] := 1
            IniWrite, 1, %filePath%, %option%, frequency
        }
    }
    ; Append "manual" option to the end of the list
    OptionList["manual"] := 0
    ; Construct the final list string
    options := ""
    for option, freq in OptionList
    {
        options .= option "|"
    }
    return RTrim(options, "|")
}

UpdateFrequency(option) {
    global OptionList, iniFilePath
    if (OptionList.HasKey(option)) {
        OptionList[option]++
    } else {
        OptionList[option] := 1
    }
    IniWrite, % OptionList[option], %iniFilePath%, %option%, frequency
    global List := LoadListFromINI(iniFilePath)
    GuiControl,, Choice, %List%
}

RemoveLowFrequencyOptions() {
    msgbox,,, remove
    global OptionList, iniFilePath
    for option, freq in OptionList
    {
        if (freq = 1)
        {
            OptionList.Delete(option)
            IniDelete, %iniFilePath%, %option%
        }
    }
}