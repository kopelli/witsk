$iniFile = %1%
CreateSettings($iniFile)

CreateSettings(iniFile)
{
    @name = HipChat
    @sectionName = %@name%_Shortcuts

    IniWrite, HipChat ahk_class Qt5qWindowIcon, %iniFile%, %@name%, WinTitle

    IniWrite, Invite someone to a room, %iniFile%, %@sectionName%, CTRL+I
    IniWrite, Join a new room or 1-1 chat, %iniFile%, %@sectionName%, CTRL+J
    IniWrite, Toggle notifications sound on/off, %iniFile%, %@sectionName%, CTRL+SHIFT+S
    IniWrite, Change current topic, %iniFile%, %@sectionName%, CTRL+T
    IniWrite, Go to <number> tab, %iniFile%, %@sectionName%, CTRL+<number>
    IniWrite, Next Tab, %iniFile%, %@sectionName%, CTRL+Tab
    IniWrite, Next Tab, %iniFile%, %@sectionName%, CTRL+PageDown
    IniWrite, Previous Tab, %iniFile%, %@sectionName%, CTRL+SHIFT+Tab
    IniWrite, Previous Tab, %iniFile%, %@sectionName%, CTRL+PageUp
}
