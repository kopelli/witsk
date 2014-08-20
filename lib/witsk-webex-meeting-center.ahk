$iniFile = %1%
CreateSettings($iniFile)

CreateSettings(iniFile)
{
    @name = WebEx_Meeting_Center
    @sectionName = %@name%_Shortcuts

    IniWrite, ahk_class WbxDockParent, %iniFile%, %@name%, WinTitle

    IniWrite, Close Meeting Center, %iniFile%, %@sectionName%, CTRL+W
    IniWrite, Transfer files, %iniFile%, %@sectionName%, CTRL+T
    IniWrite, Undo last undone action, %iniFile%, %@sectionName%, CTRL+Z
    IniWrite, Redo last undone action, %iniFile%, %@sectionName%, CTRL+Y
    IniWrite, Display Font Formatting dialog box, %iniFile%, %@sectionName%, CTRL+ALT+F
    IniWrite, Share presentation or document, %iniFile%, %@sectionName%, CTRL+ALT+O
    IniWrite, Share application, %iniFile%, %@sectionName%, CTRL+ALT+A
    IniWrite, Share desktop, %iniFile%, %@sectionName%, CTRL+ALT+D
    IniWrite, Display whiteboard, %iniFile%, %@sectionName%, CTRL+ALT+N
    IniWrite, Display full screen, %iniFile%, %@sectionName%, ALT+Enter
    IniWrite, Zoom in, %iniFile%, %@sectionName%, CTRL++
    IniWrite, Zoom out, %iniFile%, %@sectionName%, CTRL+-
    IniWrite, Pass microphone, %iniFile%, %@sectionName%, CTRL+ALT+M
    IniWrite, Mute/unmute your microphone, %iniFile%, %@sectionName%, CTRL+M
    IniWrite, Find Participant, %iniFile%, %@sectionName%, CTRL+F
    IniWrite, F1, %iniFile%, %@sectionName%, Help
}
