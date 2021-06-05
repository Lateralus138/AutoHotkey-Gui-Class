# AutoHotkey Gui Class Version 2

Create AutoHotkey gui objects

<sub>This `README` is:</sub>

![Under Construction](https://img.shields.io/static/v1?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAACmElEQVQokUWSa0iTcRTGn//26u4b6ZQ0U8lKMqykwPpgZVBEHyLp8jEoIZJADCQ0iCiStIwuZmHRioIuroQss2VkrkIrdeFckiZqdhctTXPOve8Tr7M6X8/zO+fwPEfIwy7IwQA0GgExGYQwyhCmMLRX1z2hJCJSN+xZgqAZnPgCaAUQ0EHICjSYLlKBCDdNQb7HLmeRoy3zQFnzYk/1WTckGUIXCVD+Kw+BpAxtuBXCpkN7bdXt/JL3W3J3xuHg3iTsL/NkNFWVPoWkQOj/wxooCrRhFgiTjI4n9ZVHHQObjxVEY8UGIi1zEhVFCahwdq5qvn+hHkKC0EcBigxwvAnkW3ge7L6TMi+VztOLOOKOY8ulKL68GM2emnjeLF3AZSlz2FCZ6yaHwLGv6pkv8MyxsUoHLcsLwBuHwE0rtdy2UuLWNTpmpkkszQEfnAPDAd47tbaB7NaJR+eXujfmtGTUXgFWp5uwPd8Oi1GBJEmwWYlP34L4PSFw7chPeD+MYnkWUVmy0CeNfe5N8ANIjNWpNmHzqklYrDIGRwRm2gXsM/xofRMOf1AgcbYOAfgxMvgxCmS9+dbh5A6VarxuIMdBDoJ0g+vSreytNpAEux7qqWrK82I+kC2xYOAzyFbz5QNJPrXhdRo4XK/n3WILkxPsbKqwsr8xBB3PjukhGyJJv+qqB+QvkN0mR2Fim5pU1hobzxTYOPbcyJoTNpoAlu6wdZKvIslR0O9VXe0Clc5p2Ge4WDh36ux3ThM/1RqnNhXvilU32cjvINtAf4cKdkzlSHpBTqgNY11JfLtFA+o14NU8Wx/piggNfg2yGVR8EF9/dP37PyCIoDQLs8z9hmv71nsC4wFz9klX2tD4/AEG+gBoQ7KghD8MZ2xdnt7s7wAAAABJRU5ErkJggg==&label=Under&message=Construction&color=yellow&labelColor=1d1d1d&style=for-the-badge)

<mark>**COMING SOON**</mark>

I will be adding more case examples as well as links to projects built with this.

There might not be any changes to this code base; not to say I write perfect code, but if there's a better way to refactor/optimize this class then I don't know how to do it and welcome anyone to fork this and do so, but this is perfect for everything I do with GUI's in *AutoHotkey* and the way it works is quite clever if I do say so myself (and I do, of course :p).

The way this class works, even if there isn't a method to do everything under the sun with GUI's, it can still tie in with any normal method allowing you to just plug this framework into existing projects creating hybrids (framework/normal AHK GUI code).

Also, I plan to create an archived release of this with no artifacts for easy download accessibility and stat creation for this project.

- [AutoHotkey Gui Class Version 2](#autohotkey-gui-class-version-2)
  - [Example](#example)
  - [Recent bug fixes](#recent-bug-fixes)
  - [File Types](#file-types)
  - [Example Code getControls() ShowCase](#example-code-getcontrols-showcase)
    - [Get a control information object](#get-a-control-information-object)
  - [Motivation](#motivation)
  - [License](#license)
  - [Project Information](#project-information)
    - [Latest Version Status](#latest-version-status)

## Example

You can find an example/tutorial script in the [Example Folder](./example/) found at the root of this repository &amp; there's an archive of the example here [Compressed Example](./example/class_example.zip). 

This is meant for intermediate to advanced skill level users. In order to use this class you should probably already be experienced with the AutoHotkey language &amp; especially experienced with guis. Understanding how guis work in AutoHotkey will help you understand how to use this class &amp; also all the things that can be done with this class.

You can find a video preview of the example/tutorial here:
[AutoHotkey _Gui Class Example Preview](https://lateralus138.github.io/AutoHotkey_Gui_Class_Preview/)

## Recent bug fixes

- Fixed bug in getControls() method that didn't correctly get the 'focus' &amp; 'focusv' attributes of a control.
- Added the need to provided a Text Hwnd variable name for the custom _Gui.Button() method along with it's relative Progress Hwnd variable name. 

## File Types

The .aclass file is the same as the .ahk file, which can be used as
an #Include; helps me separate main files from imports

## Example Code getControls() ShowCase

### Get a control information object 
```AutoHotkey
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
                    this.controls[A_LoopField]["focus"] := focus ;
                    this.controls[A_LoopField]["focusv"] := focusv ;
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

## Project Information

![Readme Card](https://github-readme-stats.vercel.app/api/pin/?username=Lateralus138&repo=AutoHotkey-Gui-Class)

|Description|Status|
|:---:|:---:|
|Project Release Date|![GitHub Release Date](https://img.shields.io/github/release-date/Lateralus138/AutoHotkey-Gui-Class?style=for-the-badge)|
|Total downloads for this project|![GitHub all releases](https://img.shields.io/github/downloads/Lateralus138/AutoHotkey-Gui-Class/total?style=for-the-badge)|
|Complete repository size|![This Repo Size](https://img.shields.io/github/repo-size/Lateralus138/AutoHotkey-Gui-Class?style=for-the-badge)|
|Commits in last month|![GitHub commit activity](https://img.shields.io/github/commit-activity/m/Lateralus138/AutoHotkey-Gui-Class?style=for-the-badge)|
|Commits in last year|![GitHub commit activity](https://img.shields.io/github/commit-activity/y/Lateralus138/AutoHotkey-Gui-Class?style=for-the-badge)|

### Latest Version Status

|Description|Status|Number of Downloads|
|:---:|:---:|:---:|
|Latest Release version|![Release Version](https://img.shields.io/github/v/release/Lateralus138/AutoHotkey-Gui-Class?style=for-the-badge)|![GitHub release (latest by date)](https://img.shields.io/github/downloads/Lateralus138/AutoHotkey-Gui-Class/1.0.0/total?style=for-the-badge)|
|Latest Tag version, possible Pre-Release's|![Tag Version](https://img.shields.io/github/v/tag/Lateralus138/AutoHotkey-Gui-Class?style=for-the-badge)|![GitHub release (latest by date)](https://img.shields.io/github/downloads/Lateralus138/AutoHotkey-Gui-Class/1.0.0/total?style=for-the-badge)|