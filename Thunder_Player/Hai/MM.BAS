Attribute VB_Name = "Mul"
Option Explicit
Declare Function GetActiveWindow Lib "user32" () As Long
Declare Function SetWindowPos Lib "user32" (ByVal hwnd As Long, _
         ByVal hWndInsertAfter As Long, ByVal X As Long, ByVal Y As Long, _
         ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long



Declare Function ShowCursor Lib "user32" (ByVal bShow As Long) As Long

'Function FindWindow used in determining whether or not
'another instance of the screen saver is running
Declare Function FindWindow Lib "user32" Alias "FindWindowA" _
(ByVal lpClassName As String, ByVal lpWindowName As String) As Long

' Required to find te full screen hieght and width
Declare Function GetSystemMetrics Lib "user32" _
         (ByVal nIndex As Long) As Long
Public Const SM_CXSCREEN = 0
Public Const SM_CYSCREEN = 1
Public Const HWND_TOP = 0
Public Const SWP_SHOWWINDOW = &H40

'Constants for application
Public Const SW_SHOWNORMAL = 1
Private Const APP_NAME = "Saver"

