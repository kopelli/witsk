$iniFile = %1%
CreateSettings($iniFile)

CreateSettings(iniFile)
{
    @name = Windows
    @sectionName = %@name%_Shortcuts

    IniWrite, Program Manager ahk_class Progman, %iniFile%, %@name%, WinTitle

    IniWrite, Open Start Menu, %iniFile%, %@sectionName%, CTRL+ESC
    IniWrite, Switch between open programs, %iniFile%, %@sectionName%, ALT+TAB
    IniWrite, Quit Program, %iniFile%, %@sectionName%, ALT+F4
    IniWrite, Delete item permanently, %iniFile%, %@sectionName%, SHIFT+DELETE
    IniWrite, Lock the computer, %iniFile%, %@sectionName%, Windows Logo+L
}
