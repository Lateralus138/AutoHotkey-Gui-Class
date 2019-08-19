# AutoHotkey Gui Class Version 2
Create AutoHotkey gui objects

## Example Code - getControls() - ShowCase
### Get a control information object 
```
    getControls(){
        if (this.getId()) {
            WinGet,_ctrlList,ControlList,% "ahk_id " this.id
            if (_ctrlList != ""){
                loop,parse,_ctrlList,`n
                {   
                    if (! IsObject(this.controls[A_LoopField])) {
                        this.controls[A_LoopField] := {}
                    }
                    GuiControlGet   ,   content,% this.sub,%A_LoopField%
                                    ,   % ((SubStr(A_LoopField,1,6)="Button")?"Text":"")
                    GuiControlGet,pos,% this.sub "Pos",%A_LoopField%
                    GuiControlGet,focus,% this.sub "Focus"
                    GuiControlGet,focusv,% this.sub "FocusV"
                    GuiControlGet,enabled,% this.sub "Enabled",%A_LoopField%
                    GuiControlGet,visible,% this.sub "Visible",%A_LoopField%
                    GuiControlGet,hwnd,% this.sub "Hwnd",%A_LoopField%
                    GuiControlGet,name,% this.sub "Name",%A_LoopField%
                    this.controls.focus := focus ;
                    this.controls.focusv := focusv ;
                    this.controls[A_LoopField]["content"] := content ;
                    this.controls[A_LoopField]["pos"]   :=  {   "x":posX
                                                            ,   "y":posY
                                                            ,   "w":posW
                                                            ,   "h":posH} ;
                    this.controls[A_LoopField]["enabled"] := enabled ;
                    this.controls[A_LoopField]["visible"] := visible ;
                    this.controls[A_LoopField]["hwnd"] := hwnd ;
                    this.controls[A_LoopField]["name"] := name ;
                }
            }
            return this.controls
        }
    }
```
## Motivation
I like to "objectify" things for various reasons and
I really wanted a way to compartmentalize different gui
windows

## Contributors

Ian Pride @ faithnomoread@yahoo.com - [Lateralus138] @ New Pride Services 

## License

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

	License provided in the License folder on the source page

