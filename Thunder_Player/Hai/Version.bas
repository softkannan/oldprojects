Attribute VB_Name = "Version"
Option Explicit
Dim WinVersion As Integer

Type MYVERSION
    lMajorVersion As Long
    lMinorVersion As Long
    lExtraInfo As Long
End Type

Type OSVERSIONINFO
        dwOSVersionInfoSize As Long
        dwMajorVersion As Long
        dwMinorVersion As Long
        dwBuildNumber As Long
        dwPlatformId As Long
        szCSDVersion As String * 128      '  Maintenance string for PSS usage
End Type



Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" (ByRef lpVersionInformation As OSVERSIONINFO) As Long

Public Const VER_PLATFORM_WIN32s = 0
Public Const VER_PLATFORM_WIN32_WINDOWS = 1
Public Const VER_PLATFORM_WIN32_NT = 2
Function WindowsVersion() As MYVERSION
Dim myOS As OSVERSIONINFO, WinVer As MYVERSION
Dim lResult As Long

    myOS.dwOSVersionInfoSize = Len(myOS)    'should be 148
    
    lResult = GetVersionEx(myOS)
        
    'Fill user type with pertinent info
    WinVer.lMajorVersion = myOS.dwMajorVersion
    WinVer.lMinorVersion = myOS.dwMinorVersion
    WinVer.lExtraInfo = myOS.dwPlatformId
    
    WindowsVersion = WinVer

End Function


