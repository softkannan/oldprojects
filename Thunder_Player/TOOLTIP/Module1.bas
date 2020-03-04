Attribute VB_Name = "Module1"
Option Explicit
'
' Copyright © 1997-1999 Brad Martinez, http://www.mvps.org
'
' Exported by Comctl32.dll >= v4.00.950
' Ensures that the common control dynamic-link library (DLL) is loaded.
Declare Sub InitCommonControls Lib "comctl32.dll" ()

' The NMHDR structure contains information about a notification message. The pointer
' to this structure is specified as the lParam member of the WM_NOTIFY message.
Public Type NMHDR
  hwndFrom As Long   ' Window handle of control sending message
  idFrom As Long        ' Identifier of control sending message
  code  As Long          ' Specifies the notification code
End Type

Public Type POINTAPI   ' pt
  x As Long
  y As Long
End Type

Public Type RECT   ' rct
  Left As Long
  Top As Long
  Right As Long
  Bottom As Long
End Type

Declare Function SendMessage Lib "user32" Alias "SendMessageA" _
                            (ByVal hWnd As Long, _
                            ByVal wMsg As Long, _
                            ByVal wParam As Long, _
                            lParam As Any) As Long   ' <---

Public Const WM_USER = &H400

Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" _
                            (ByVal dwExStyle As Long, ByVal lpClassName As String, _
                             ByVal lpWindowName As String, ByVal dwStyle As Long, _
                             ByVal x As Long, ByVal y As Long, _
                             ByVal nWidth As Long, ByVal nHeight As Long, _
                             ByVal hwndParent As Long, ByVal hMenu As Long, _
                             ByVal hInstance As Long, lpParam As Any) As Long

Declare Function DestroyWindow Lib "user32" (ByVal hWnd As Long) As Long

Declare Sub MoveMemory Lib "kernel32" Alias "RtlMoveMemory" (pDest As Any, pSource As Any, ByVal dwLength As Long)
'

' Returns the low-order word from the given 32-bit value.

Public Function LOWORD(dwValue As Long) As Integer
  MoveMemory LOWORD, dwValue, 2
End Function

' Returns the larger of the two passed params

Public Function Max(param1 As Long, param2 As Long) As Long
  If param1 > param2 Then Max = param1 Else Max = param2
End Function

Public Function GetStrFromBufferA(szA As String) As String
  If InStr(szA, vbNullChar) Then
    GetStrFromBufferA = Left$(szA, InStr(szA, vbNullChar) - 1)
  Else
    ' If sz had no null char, the Left$ function
    ' above would rtn a zero length string ("").
    GetStrFromBufferA = szA
  End If
End Function
