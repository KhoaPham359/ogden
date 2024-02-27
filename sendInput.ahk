;Gui when nr, pop and others

loadArray(ByRef array) {
  arrayCount := 0
  Loop, Read, %A_ScriptDir%\FreeFormResponse.txt ; This loop retrieves each line from the file, one at a time.
  {
    arrayCount += 1
    array.Push(A_LoopReadLine) ; Append this line to the array.
  }
  return arrayCount
}

getProductName(ByRef ProductName) {
  OPTION_COUNT := 9
  GUI_WIDTH := 260
  GUI_HEIGHT := OPTION_COUNT * 40 + 10
  BUTTON_WIDTH := 200
  BUTTON_HEIGHT := 30

  Gui, Add, Button, x30 y10 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_ClothingStore, Clothing store
  Gui, Add, Button, x30 y50 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_MedicalProduct, Medical products 
  Gui, Add, Button, x30 y90 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_SkinCare, Skincare products 
  Gui, Add, Button, x30 y130 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_FinancialComp, Financial company
  Gui, Add, Button, x30 y170 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_EducationCenter, Education center
  Gui, Add, Button, x30 y210 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_Shoes, Shoes
  Gui, Add, Button, x30 y250 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_Decoration, Decoration products
  Gui, Add, Button, x30 y290 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_BeautyCenter, Beauty center
  Gui, Add, Button, x30 y330 w%BUTTON_WIDTH% h%BUTTON_HEIGHT% g_Manual, Manual 
  Gui, Show, w%GUI_WIDTH% h%GUI_HEIGHT%, Option
  Suspend, on
  pause
  return

  _ClothingStore:
    Gui, hide
    Suspend off
    pause, off
    ProductName = clothing store
  return

  _MedicalProduct:
    Gui, hide
    Suspend off
    pause, off
    ProductName = medical products
  return

  _SkinCare:
    Gui, hide
    Suspend off
    pause, off
    ProductName = skincare products
  return

  _FinancialComp: 
    Gui, hide
    Suspend off
    pause, off
    ProductName = financial company
  return 
  _EducationCenter:
    Gui, hide
    Suspend off
    pause, off
    ProductName = education center
  return

  _Shoes:
    Gui, hide
    Suspend off
    pause, off
    ProductName = shoes
  return

  _Decoration:
    Gui, hide
    Suspend off
    pause, off
    ProductName = decorations
  return

  _BeautyCenter:
    Gui, hide
    Suspend off
    pause, off
    ProductName = beauty center
  return
  
  _Manual:
    Gui, hide
    Suspend off
    pause, off
    InputBox, ProductName, Product Name 
    if ErrorLevel
      ExitApp
    if ProductName = 
    {
      MsgBox,,, Empty input! 
      ExitApp
    }
  return
  guiclose:
  ExitApp
  return
}
