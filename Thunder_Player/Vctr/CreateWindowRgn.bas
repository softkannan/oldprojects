Attribute VB_Name = "Module1"
Public Declare Function CreateRoundRectRgn Lib "gdi32" (ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long, ByVal X3 As Long, ByVal Y3 As Long) As Long
Public Declare Function SetWindowRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long, ByVal bRedraw As Boolean) As Long
Public Declare Function ValidateRgn Lib "user32" (ByVal hwnd As Long, ByVal hRgn As Long) As Long
Public Declare Function GetClientRect Lib "user32" (ByVal hwnd As Long, lpRect As RECT) As Long

Public Type RECT
        Left As Long
        Top As Long
        Right As Long
        Bottom As Long
End Type
Public Function Sizewin(hwnd As Long)
Dim Rgn As Long
Dim ReWin As RECT
GetClientRect hwnd, ReWin
Rgn = CreateRoundRectRgn(ReWin.Left, ReWin.Top, ReWin.Right, ReWin.Bottom, 50, 50)
SetWindowRgn hwnd, Rgn, False
End Function

