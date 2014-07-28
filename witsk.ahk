#NoEnv      ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn All   ; Enable warnings to assist with detecting common errors.
#SingleInstance force
#Persistent

SendMode Input                  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%     ; Ensures a consistent starting directory.

OnExit, EXIT

; Ensure that the INI file exists for this (compiled) script
FileAppend,,%A_ScriptFullPath%.ini

; Work around to figure out the full path to the INI file
$iniFilePath=
Loop, %A_ScriptFullPath%.ini
{
    $iniFilePath := A_LoopFileLongPath
}

; Execute all the "library" scripts to update the INI file with the keybinding information
Loop, lib\witsk-*.ahk, 0, 1
{
    ; HACK: This assumes that .ahk files default action is to execute them
    ; It works around the issue of dynamically called functions not necessarily working
    ; The alternative would be for this script to have an #INCLUDE
    ; for every...single...libary...we...ever...write...
    RunWait, %A_AhkPath% "%A_LoopFileLongPath%" "%$iniFilePath%", %A_ScriptDir%, Hide
}

AllLibraries := GetAllLibraries($iniFilePath)


; =============================================================================
; Functions
; =============================================================================

Max(value1, value2)
{
    return value1 > value2 ? value1 : value2
}

GetAllLibraries(iniFilePath)
{
    @_allLibraries := Object()
    IniRead, $settings, %iniFilePath%
    Loop, Parse, $settings, `n
    {
        ; We only care about those sections that end in "_Shortcuts"
        If (RegExMatch(A_LoopField, "_Shortcuts$") > 0)
        {
            @_shortcutsSection := A_LoopField
            @_libraryCommands := Object()
            @actualSection := SubStr(A_LoopField, 1, StrLen(A_LoopField)-StrLen("_Shortcuts"))
            ; Loop through all the key-value pairs of the shortcuts section
            IniRead, @shortCuts, %iniFilePath%, %@_shortcutsSection%
            Loop, Parse, @shortCuts, `n
            {
                @_shortcutLine := A_LoopField
                @_key := SubStr(@_shortcutLine, 1, InStr(@_shortcutLine, "=")-1)
                @_value := SubStr(@_shortcutLine, StrLen(@_key)+2)
                @_libraryCommands[@_key] := @_value
            }
            IniRead, @_windowTitle, %iniFilePath%, %@actualSection%, WinTitle, %A_Space%
            @_allLibraries[@_windowTitle] := @_libraryCommands
        }
    }
    return @_allLibraries
}

GetMaxStringLength(array)
{
    @_maxLength := -1
    For @_key, @_value in array
        @_maxLength := Max(@_maxLength, StrLen(@_key))
    return @_maxLength
}

WhatIsThatShortcutKey(commands)
{
    Gui, Destroy    ; Destroy any current windows because we have a completely new set of requirements
    Gui, +ToolWindow -Disabled -SysMenu -Caption +E0x20 ; +AlwaysOnTop
    Gui, Margin, 50, 50
    Gui, Color, 111111
    Gui, Font, s10 cEEEEEE w900, Inconsolata
    @_maxKeyLength := GetMaxStringLength(commands) + 1

    For key, value in commands
    {
        paddedKey := SubStr(key . "                                        ", 1, @_maxKeyLength)
        Gui, Add, Text, xm yp+22 w150, %paddedKey%
        Gui, Add, Text, xp+150 yp+0, %value%
    }

    Gui, Show, AutoSize NoActivate, ~~WHAT~IS~THAT~SHORTCUT~KEY~~MAIN~~WINDOW~~
    WinSet, Transparent, 230, ~~WHAT~IS~THAT~SHORTCUT~KEY~~MAIN~~WINDOW~~
    WinSet, AlwaysOnTop, On, ~~WHAT~IS~THAT~SHORTCUT~KEY~~MAIN~~WINDOW~~ 
}

; =============================================================================
; Hotkeys
; =============================================================================
$^?::
    For @_winTitle, @_winCommands in AllLibraries
    {
        If (WinActive(@_winTitle))
        {
            WhatIsThatShortcutKey(@_winCommands)
        }
    }
return

$Esc::
    Send, {Esc}
    Gui, Destroy
return

GuiEscape:
GuiClose:
ButtonCancel:
EXIT:
ExitApp
