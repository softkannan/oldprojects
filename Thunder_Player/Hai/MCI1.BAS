Attribute VB_Name = "MCI1"
Option Explicit 'All variables must be declared
'Declare Function GetActiveWindow Lib "user32" () As Long
'Declare Function ShowCursor Lib "user32" (ByVal bShow As Long) As Long
Declare Function FindWindow Lib "user32" Alias "FindWindowA" _
(ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Declare Function GetSystemMetrics Lib "user32" _
         (ByVal nIndex As Long) As Long
Declare Function SetWindowPos Lib "user32" (ByVal Hwnd As Long, _
         ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, _
         ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
Declare Function GetWindowRect Lib "user32" (ByVal Hwnd As Long, ByRef r As RECT) As Boolean
Declare Function GetForegroundWindow Lib "user32" () As Long
'Declare Function GetWindowText Lib "user32" (ByVal hwnd As Long, ByVal s As String, ByVal mc As Integer) As Integer
Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Declare Function GetVersion Lib "kernel32" () As Long
'Public Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, ByVal Hwnd As Long, ByVal MSG As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal Hwnd As Long, ByVal nIndex As Long) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal Hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
'window styles
'Public Const WS_OVERLAPPED = 0
Public Const WS_POPUP = &H80000000
Public Const WS_VISIBLE = 1
'Public Const WS_CAPTION = &HC00000
Public Const WS_BORDER = &H800000
Public Const WS_SYSMENU = &H80000
'Public Const WS_EX_TOPMOST = &H8&
'Public Const WS_THICKFRAME = &H40000
'Public Const WS_MINIMIZEBOX = &H20000
'Public Const WS_MAXIMIZEBOX = &H10000

' Constants for screen dimensions
Public Const SM_CXSCREEN = 0
Public Const SM_CYSCREEN = 1
Public Const HWND_TOP = 0
Public Const SWP_SHOWWINDOW = &H40
Public Const SM_CXBORDER = 5
Public Const SM_CYBORDER = 6
Public Const HWND_TOPMOST = -1
Public Const SM_CYCAPTION = 4
Public Const SM_CXMAXIMIZED = 61
Public Const SM_CYMAXIMIZED = 62

'Constants for application
Public Const SW_SHOWNORMAL = 1
'Private Const APP_NAME = "Saver"

Public Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
'MCI Constants
'Public Const conMCIAppTitle = "MCI Control Application"

' These constants are defined in mmsystem.h.
Public Const conMCIErrInvalidDeviceID = 30257
Public Const conMCIErrDeviceOpen = 30263
Public Const conMCIErrCannotLoadDriver = 30266
Public Const conMCIErrUnsupportedFunction = 30274
Public Const conMCIErrInvalidFile = 30304
'Mouse Constants
'Public Const WM_MOUSEMOVE = &H200
'Public Const WM_LBUTTONDOWN = &H201
'Public Const WM_LBUTTONUP = &H202
'Public Const WM_LBUTTONDBLCLK = &H203
'Public Const WM_RBUTTONDOWN = &H204
'Public Const WM_RBUTTONUP = &H205
'Public Const WM_RBUTTONDBLCLK = &H206
'SetWindowLong Constants
'Public Const GWL_USERDATA = (-21)
'Public Const GWL_WNDPROC = (-4)
Public Const GWL_STYLE = (-16)
'Privious Instance
'Public PrevWndProc As Long
'Public hwnd1 As Long
'PrevWndProc = SetWindowLong(gTrayHwnd, GWL_WNDPROC, AddressOf SubWndProc)
'Public Function SubWndProc(ByVal Hwnd As Long, ByVal MSG As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
' Dim x As Long
' MsgBox "jill"
'x = CallWindowProc(PrevWndProc, Hwnd, MSG, wParam, lParam)

'  Select Case MSG
   'Case WM_LBUTTONDBLCLK:
    'MsgBox "dbclk"
 '  Case WM_RBUTTONDOWN:
  '  MsgBox "Lbuttondown"
  'End Select
'End Function
