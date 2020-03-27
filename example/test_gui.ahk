#SingleInstance,Force
#KeyHistory,0
SetBatchLines,-1
ListLines,Off
SendMode Input ; Forces Send and SendRaw to use SendInput buffering for speed.
SetTitleMatchMode,3 ; A window's title must exactly match WinTitle to be a match.
SetWorkingDir,%A_ScriptDir%
SplitPath,A_ScriptName,,,,thisscriptname
#MaxThreadsPerHotkey,1 ; no re-entrant hotkey handling
; DetectHiddenWindows,On
SetWinDelay,0  ; Remove short delay done automatically after every windowing command except IfWinActive and IfWinExist
                ; -1 is a little too fast & can cause several issues in SetWinDelay
; SetKeyDelay,-1,-1 ; Remove short delay done automatically after every keystroke sent by Send or ControlSend
; SetMouseDelay,-1 ; Remove short delay done automatically after Click and MouseMove/Click/Drag
#Include,%A_WorkingDir%\_Gui.aclass

; ╓────────────────────────────────────────────────╖
; ║ OnMessages for working with Left button clicks ║
; ║ & Alt shortcuts.                               ║
; ╙────────────────────────────────────────────────╜
OnMessage(0x201,"WM_LBUTTONDOWN") ; For left button clicks
OnMessage(0x104,"WM_SYSKEYDOWN") ; For Alt hotkeys
OnMessage(0x200,"WM_MOUSEMOVE") ; For hovering custom buttons & possibly ToolTips

; ╓──────────────────────────────────────────────╖
; ║ Button Data                                  ║
; ║ Create associative array of button data      ║
; ║ for use in my custom _Gui.Button() method.   ║
; ║ You can use whatever keywords you like,but   ║
; ║ it's best to use the below format. Most of   ║
; ║ this should be self explanatory,but 'bprog'  ║
; ║ & 'btext' are any extra options passed to    ║
; ║ the progress bar and overlayed text as this  ║
; ║ button is created using Text layed over a    ║
; ║ progress bar for better customization.       ║
; ╙──────────────────────────────────────────────╜
bttnData :=   {b: {x:"s",y:"+20",w:200,h:32
            ,text:"Test Button &B"
            ,pHwnd:"Test2Hwnd"
            ,tHwnd:"Test2THwnd"
            ,bprog:"Background0x280860 C0x3F00AF"
            ,btext:"c0xEFEFEF"}
        ,c: {x:"+20",y:"p",w:300,h:48
            ,text:"Test Button &C"
            ,pHwnd:"Test3Hwnd"
            ,tHwnd:"Test3THwnd"
            ,bprog:"Background0x6E2222 C0xCC3333"
            ,btext:"c0xEFEFEF"}
        ,exit: {x:"s",y:"+20",w:120,h:32
            ,text:"E&xit"
            ,pHwnd:"ExitHwnd"
            ,tHwnd:"ExitTHwnd"
            ,bprog:"Background0x787878 C0x101010"
            ,btext:"c0xEFEFEF"}}

HEADER_TEXT=
(join%A_Space%
This is an example gui for my AutoHotkey _Gui Class
that objectifies each individual gui window. This
example is a small showcase/preview of what can be
done with the provided _Gui.Button() method. Read
through the comments in this example script and
the _Gui class file itself to get a better understaning
of how this class works. This is meant as a semi-
tutorial for intermediate to advanced AutoHotkey
users as you should already have a good understanding
of how to create AutoHotkey Guis.
)

; ╓──────────────────────────────────────────────────────╖
; ║ Create Gui                                           ║
; ║ Creating Gui objects CAN make your code cleaner &    ║
; ║ possibly more organized & all _Gui objects can be    ║
; ║ tied together (parent/child relationships) just like ║
; ║ the normal method as every normal GUI method is      ║
; ║ supplied in this class.                              ║
; ║ GUI.Options("+LastFound") (where GUI = _Gui("Main")) ║
; ║ is like using:                                       ║
; ║ Gui,Main:+LastFound                                  ║
; ╙──────────────────────────────────────────────────────╜
; ╓──────────────────────────────────────────────────────────╖
; ║ The _Gui.Button() method must make use of WM_LBUTTONDOWN ║
; ║ & WM_SYSKEYDOWN for button presses & Alt presses         ║
; ║ respectively                                             ║
; ╙──────────────────────────────────────────────────────────╜
GUI := New _Gui("Main","AutoHotkey _Gui Class - button() example")
GUI.Color("0xEFEFEF")

GUI.Font("Segoe UI","s16 cRed")
GUI.Add("Text","AutoHotkey _Gui Class Tutorial/Example","w520 Center +0x200")
GUI.Font("Segoe UI","s14 cBlue")
GUI.Add("Text","Level: Intermediate/Advanced","w520 Center +0x200")
GUI.Font("Segoe UI","s12 c0x101010")
GUI.Add("Text",HEADER_TEXT,"+Wrap w520")

GUI.Font("Segoe UI","s16 cRed")
GUI.Add("Text","Default Button Type")

GUI.Font("Segoe UI","s10 c0x101010")
GUI.Add("Text","This is the default button with less theming options.","x+20 yp h30 +0x200 +Wrap")

; Normal style button
GUI.Font("Segoe UI","s12 c0x101010")
GUI.Add("Button","Test Button &A","x20 HwndTest1Hwnd")

GUI.Font("Segoe UI","s16  cRed")
GUI.Add("Text","Custom Button Type","Section x20")

GUI.Font("Segoe UI","s10 c0x101010")
GUI.Add("Text","This is the custom .Button() from my _Gui class with more theming options.","x+20 yp w299 +Wrap +Center")

; Custom style buttons
GUI.Font("Segoe UI","s14 c0x101010")
GUI.Button(bttnData.b.x,bttnData.b.y,bttnData.b.w
    ,bttnData.b.h,bttnData.b.text,bttnData.b.pHwnd
    ,bttnData.b.tHwnd,bttnData.b.bprog,bttnData.b.btext)
GUI.Button(bttnData.c.x,bttnData.c.y,bttnData.c.w
    ,bttnData.c.h,bttnData.c.text,bttnData.c.pHwnd
    ,bttnData.c.tHwnd,bttnData.c.bprog,bttnData.c.btext)
GUI.Button(bttnData.exit.x,bttnData.exit.y,bttnData.exit.w
    ,bttnData.exit.h,bttnData.exit.text,bttnData.exit.pHwnd
    ,bttnData.exit.tHwnd,bttnData.exit.bprog,bttnData.exit.btext)

GUI.Add("Picture",A_WorkingDir "\test_gui.png","w32 h-1 x+20 yp")

; Rounded button using WinSet,Region
; I will possibly be adding this option into the _Gui class
WinSet,Region,0-0 w200 h32 R32-32,ahk_id %Test2Hwnd%

; Show Main GUI
GUI.Show("AutoSize")

; ╓─────────────────────────────────────────────────────╖
; ║ getControls()                                       ║
; ║ You can get a full list of the GUIs controls with   ║
; ║ any info the control can provide such as position,  ║
; ║ size, hwnd, Enabled, Name, Focus, & more etc...     ║
; ╙─────────────────────────────────────────────────────╜
GUI_CONTROL_LIST:=GUI.getControls() ; Get the control list associative array
; You can display some of this info by clicking the "Test Buttons" in this
; example.

NEW_PIC_POS_X:=((GUI_CONTROL_LIST.Static9.pos.x+GUI_CONTROL_LIST.Static9.pos.w)-32)
GuiControl,Main:Move,Static11,% "x" NEW_PIC_POS_X

; GUI.Show("AutoSize")
; There are various ways to set a windows icons, but this
; is how I do it when my scripts aren't compiled (sometimes
; even when compiled).
if FileExist(A_WorkingDir "\test_gui.ico") {
    SetWinIcon(A_WorkingDir "\test_gui.ico","ahk_id " GUI.getId())
}

; Return to make sure script doesn't exit prematurely
Return

; ╓───────────╖
; ║ Functions ║
; ╙───────────╜
quote(string,mode:=0) ; mode defaults to double quotes
{	mode:=!mode?"""":"`'"
	return mode string mode
}
; ╓─────────────────────────────────────────────────────────╖
; ║ test_to_sub function for processing button ids & keys   ║
; ║ against actual hwnd or alt+hotkey pressed; if values    ║
; ║ equal then set immediate timer to goto sub. Used in     ║
; ║ both the WM_LBUTTONDOWN & WM_SYSKEYDOWN functions since ║
; ║ both functions are evaluating close to the same thing.  ║
; ╙─────────────────────────────────────────────────────────╜
test_to_sub(a,b,sub){   ; Test value a against value b; if true
    if (a=b) {          ; then GoSub of Function
        SetTimer,%sub%,-1
        return 1
    }
    return 0
}
; ╓────────────────────────────────────────────────╖
; ║ WM_LBUTTONDOWN to process left mouse button    ║
; ║ clicks anywhere in the gui. Here test_to_sub   ║
; ║ tests if the current controls id equals one of ║
; ║ the buttons Hwnds & if so executes the proper  ║
; ║ GoSub or function.                             ║
; ╙────────────────────────────────────────────────╜
WM_LBUTTONDOWN(argv*){
    global Test1Hwnd,Test2Hwnd,Test3Hwnd,ExitHwnd
    if test_to_sub(argv[4],ExitHwnd,"MainGuiClose")
        return
    if test_to_sub(argv[4],Test1Hwnd,"A")
        return
    if test_to_sub(argv[4],Test2Hwnd,"B")
        return
    if test_to_sub(argv[4],Test3Hwnd,"C")
        return
}
; ╓────────────────────────────────────────────╖
; ║ WM_SYSKEYDOWN to process Alt+keys. This is ║
; ║ used if you want to create underscored     ║
; ║ referenced Alt hotkeys to the buttons      ║
; ║ function. Not necessary. Here test_to_sub  ║
; ║ tests if your wanted key (E.g. "c") is     ║
; ║ held while Alt is pressed & if so executes ║
; ║ the proper GoSub or function.              ║
; ╙────────────────────────────────────────────╜
WM_SYSKEYDOWN(argv*){
    if (argv[1]=18) { ; 18 = Alt
        Input,ipv,L1 T0.2 M ; Wait half a second for additional key presses
                            ; else do nothing
        if (ErrorLevel != "Timeout" or ErrorLevel = "Max") {
            if test_to_sub(ipv,"x","MainGuiClose")
                return
            if test_to_sub(ipv,"a","A")
                return
            if test_to_sub(ipv,"b","B")
                return
            if test_to_sub(ipv,"c","C")
                return           
        }
    }
}
; ╓────────────────────────────────────────────────────╖
; ║ button_change function to work with _Gui.button()  ║
; ║ allows you to make changes to a button while it's  ║
; ║ hovered or clicked. Makes it easier to work with   ║
; ║ the progress bar overlayed with text. I will       ║
; ║ be adding this as a _Gui class method using 'this' ║
; ╙────────────────────────────────────────────────────╜
button_change(bg,fg,progid,tid,tfg,staticTxt){
    global
    GuiControl,Main:+Background%bg% +C%fg%,%progid%
    GuiControl,Main:+C%tfg%,%tid%
    GuiControl,Main:,%tid%,%staticTxt%   
}
WM_MOUSEMOVE(argv*){
    global Test1Hwnd,Test2Hwnd,Test3Hwnd,ExitHwnd
        ,Test2THwnd,Test3THwnd,ExitTHwnd
; ╓────────────────────────────────────────────────────╖
; ║ Create and test for button hover state so that the ║
; ║ button isn't being changed every time you move the ║
; ║ mouse so that there's no flickering.               ║
; ╙────────────────────────────────────────────────────╜
    static bttnHvrState1,bttnHvrState2,bttnHvrState3,bttnHvrState4
    if ((argv[4]=Test2Hwnd) And (bttnHvrState2!=1)) {   ; if above button & button state
        bttnHvrState2 := 1                              ; isn't set
        return button_change("0x8060B8","0x9070C8"
                            ,Test2Hwnd,Test2THwnd
                            ,"0x101010","Test Button &B")
    }  
    if ((argv[4]!=Test2Hwnd) And (bttnHvrState2=1)) {   ; if you're not above button &
        bttnHvrState2 := 0                              ; the button state is set
        return button_change("0x280860","0x3F00AF"
                        ,Test2Hwnd,Test2THwnd
                        ,"0xEFEFEF","Test Button &B")
    }

    if ((argv[4]=Test3Hwnd) And (bttnHvrState3!=1)) {
        bttnHvrState3 := 1
        return button_change("0x734D4D","0xD68A8A"
                            ,Test3Hwnd,Test3THwnd
                            ,"0x101010","Test Button &C")
    }  
    if ((argv[4]!=Test3Hwnd) And (bttnHvrState3=1)) {
        bttnHvrState3 := 0
        return button_change("0x6E2222","0xCC3333"
                        ,Test3Hwnd,Test3THwnd
                        ,"0xEFEFEF","Test Button &C")
    }

    if ((argv[4]=ExitHwnd) And (bttnHvrState4!=1)) {
        bttnHvrState4 := 1
        return button_change("0x444444","0x787878"
                            ,ExitHwnd,ExitTHwnd
                            ,"0x101010","E&xit")
    }  
    if ((argv[4]!=ExitHwnd) And (bttnHvrState4=1)) {
        bttnHvrState4 := 0
        return button_change("0x787878","0x101010"
                        ,ExitHwnd,ExitTHwnd
                        ,"0xEFEFEF","E&xit")
    }
}
SetWinIcon(ico,win*){
    if (FileExist(ico)
        And (hwnd:=WinExist(win[1],win[2],win[3],win[4]))) {
        hico:=DllCall("LoadImage",uint,0,str,ico,uint,1,int,0,int,0,uint,0x10)
        SendMessage,0x80,0,hico,,ahk_id %hwnd% 
        SendMessage,0x80,1,hico,,ahk_id %hwnd%
        return 1
    }
    return 0
}
; ╓──────╖
; ║ Subs ║
; ╙──────╜
A:
MsgBox,64,% GUI.title " Info",  %   "Information for " quote("Test Button A")
        .   "`n`nGUI_CONTROL_LIST[" quote("Button1") "][" quote("pos") "][" quote("x") "] &`n"
        .   "GUI_CONTROL_LIST.Button1.pos.x`nboth equal: "
        .   "x" GUI_CONTROL_LIST["Button1"]["pos"]["x"] " | "
        .   "x" GUI_CONTROL_LIST.Button1.pos.x
        .   "`n`nGUI_CONTROL_LIST[" quote("Button1") "][" quote("pos") "][" quote("y") "] &`n"
        .   "GUI_CONTROL_LIST.Button1.pos.y`nboth equal: "
        .   "y" GUI_CONTROL_LIST["Button1"]["pos"]["y"] " | "
        .   "y" GUI_CONTROL_LIST.Button1.pos.y
        .   "`n`nContent in control:`n" GUI_CONTROL_LIST.Button1.content 
return
B:
MsgBox,64,% GUI.title " Info",  %   "Information for " quote("Test Button B")
        .   "`n`nGUI_CONTROL_LIST[" quote("msctls_progress321") "][" quote("pos") "][" quote("x") "] &`n"
        .   "GUI_CONTROL_LIST.msctls_progress321.pos.x`nboth equal: "
        .   "x" GUI_CONTROL_LIST["msctls_progress321"]["pos"]["x"] " | "
        .   "x" GUI_CONTROL_LIST.msctls_progress321.pos.x
        .   "`n`nGUI_CONTROL_LIST[" quote("msctls_progress321") "][" quote("pos") "][" quote("y") "] &`n"
        .   "GUI_CONTROL_LIST.msctls_progress321.pos.y`nboth equal: "
        .   "y" GUI_CONTROL_LIST["msctls_progress321"]["pos"]["y"] " | "
        .   "y" GUI_CONTROL_LIST.msctls_progress321.pos.y
        .   "`n`nContent in control:`n" GUI_CONTROL_LIST.msctls_progress321.content
        .   "`n`nContent in control (Text):`n" GUI_CONTROL_LIST.Static8.content  
return
C:
MsgBox,64,% GUI.title " Info",  %   "Information for " quote("Test Button C")
        .   "`n`nGUI_CONTROL_LIST[" quote("msctls_progress322") "][" quote("pos") "][" quote("x") "] &`n"
        .   "GUI_CONTROL_LIST.msctls_progress322.pos.x`nboth equal: "
        .   "x" GUI_CONTROL_LIST["msctls_progress322"]["pos"]["x"] " | "
        .   "x" GUI_CONTROL_LIST.msctls_progress322.pos.x
        .   "`n`nGUI_CONTROL_LIST[" quote("msctls_progress322") "][" quote("pos") "][" quote("y") "] &`n"
        .   "GUI_CONTROL_LIST.msctls_progress322.pos.y`nboth equal: "
        .   "y" GUI_CONTROL_LIST["msctls_progress322"]["pos"]["y"] " | "
        .   "y" GUI_CONTROL_LIST.msctls_progress322.pos.y
        .   "`n`nContent in control:`n" GUI_CONTROL_LIST.msctls_progress322.content
        .   "`n`nContent in control (Text):`n" GUI_CONTROL_LIST.Static9.content  
return
MainGuiClose:
    ExitApp