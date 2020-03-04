Attribute VB_Name = "Mai"
Option Explicit
Public Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Long) As Long
Declare Function SetActiveWindow Lib "user32" (ByVal hwnd As Long) As Long
Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
    (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, _
    ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Public Declare Function CreateRoundRectRgn Lib "GDI32" (ByVal x1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long) As Long
Public Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
Public Declare Function ValidateRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long) As Long
Public Declare Function GetClientRect Lib "user32" (ByVal hwnd As Long, ByRef lpRect As RECT) As Long
'Public Declare Function GetWindowRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long
Public Declare Function CreateRectRgn Lib "GDI32" (ByVal x1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long
'Public ReWin1 As RECT
Sub Main()
On Error Resume Next
If App.PrevInstance Then End
  Form1.Show
End Sub
