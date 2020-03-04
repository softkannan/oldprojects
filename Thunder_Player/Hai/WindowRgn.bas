Attribute VB_Name = "Sizewin"
Option Explicit
Public Function Sizewin1(Hwnd As Long, x As Single, y As Single)
Dim ReWin As RECT
Dim Rgn As Long
GetClientRect Hwnd, ReWin
Rgn = CreateRoundRectRgn(ReWin.Left, ReWin.Top, ReWin.Right, ReWin.Bottom, x, y)
SetWindowRgn Hwnd, Rgn, False
End Function

