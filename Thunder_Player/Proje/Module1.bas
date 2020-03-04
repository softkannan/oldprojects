Attribute VB_Name = "Module1"
Option Explicit

'*******************************************************
    'Declair variables
    Dim lstInpuT As String
    
    Public Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long
    Public Const HWND_NOTOPMOST = -2
    Public Const HWND_TOPMOST = -1
    Public Const SWP_NOMOVE = &H2
    Public Const SWP_NOSIZE = &H1
    Public Const flags = SWP_NOMOVE Or SWP_NOSIZE
'*******************************************************

'*******************************************************
    'set the Ontop method so the form appears on top
Public Sub Ontop(FormName As Form)
    Call SetWindowPos(FormName.hWnd, HWND_TOPMOST, 0&, 0&, 0&, 0&, flags)
End Sub
'*******************************************************

'*******************************************************
    'set the Notontop method so the form no longer appears on top
Public Sub Notontop(FormName As Form)
    Call SetWindowPos(FormName.hWnd, HWND_NOTOPMOST, 0&, 0&, 0&, 0&, flags)
End Sub
'*******************************************************

'*******************************************************
    'Set the readlist to display favorites on the form
Public Sub ReadList(list As ListBox, Filename As String, Optional ClearList As Boolean)
    On Error GoTo Err
    Open Filename For Input As #1
    If ClearList = True Then list.Clear
    Do While Not EOF(1)
        Input #1, lstInpuT
        list.AddItem lstInpuT
    Loop
    Close #1
    Exit Sub
Err:
   On Error Resume Next
   Exit Sub
End Sub
'*******************************************************

'*******************************************************
    'set the writelist method to save favorites
Public Sub WriteList(list As ListBox, Filename As String)
    Dim i
    If list.ListCount <= 0 Then
        Exit Sub
        End
    End If
    On Error GoTo Err
    Open Filename For Output As #1
    For i = 0 To list.ListCount - 1
        Print #1, list.list(i)
    Next
    Close #1
    Exit Sub
Err:
   On Error Resume Next
    Exit Sub
End Sub
'*******************************************************
