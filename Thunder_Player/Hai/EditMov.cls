VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "EditMov"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Type Pt
 Stp As Long
 Etp As Long
End Type
Private Count As Integer
Private NewCl As Boolean
Public State As Boolean
Private index As Integer
Private Stp As Long
Private Etp As Long
Dim P() As Pt
Function MarkSClip()
 Stp = Form2.x1.CurrentPosition
 Etp = Stp
End Function
Function MarkEClip()
 If Stp > -1 Then
  Etp = Form2.x1.CurrentPosition
 Else
  Stp = 0
  Etp = Form2.x1.CurrentPosition
 End If
End Function
Function Makeclip()
  If NewCl = True Then
   P(index).Stp = Stp
   P(index).Etp = Etp
   index = index + 1
   Else
    NewClip
   End If
End Function
Function NewClip()
     ReDim P(0 To 500)
     Stp = 0
     Etp = 0
     Count = 0
     index = 0
     NewCl = True
End Function
Function SaveMove(Filename As String)
 Dim i As Long
 On Error Resume Next
 'Filename = "G:\test.thu"
  If index > 0 Then
   Open Filename For Output As #1
    Write #1, Form2.x1.Filename
   For i = 0 To index - 1
    Write #1, P(i).Stp, P(i).Etp
   Next
   Close #1
  Else
   MsgBox "Hey! What Is This" + vbCr + "You First Make" + vbCr + "Start & End Point" + vbCr + "Then MakeClip", , "Error"
  End If
End Function
Function LoadMove(Filename As String)
  On Error Resume Next
  Dim t As String
  Dim i As Integer
  UnloadMove
  NewClip
  Open Filename For Input As #1
   Input #1, t
  While Not EOF(1)
   Input #1, P(i).Stp, P(i).Etp
   i = i + 1
  Wend
  Close #1
  index = 0
  Form2.openmedia (t)
  Count = i
  Form2.x1.CurrentPosition = P(index).Stp
  'Index = Index + 1
  Form1.TimerMove.Enabled = True
  State = True
  Scroll
End Function
Function Scroll()
 If State = True Then
  If Form2.x1.CurrentPosition > P(index).Etp Then
    index = index + 1
    If index > Count Then
    index = 0
    'Form1.TimerMove.Enabled = False
    End If
   Form2.x1.CurrentPosition = P(index).Stp
  ElseIf Form2.x1.CurrentPosition < P(index).Stp Then
   index = index - 1
   If index < 0 Then
    index = 0
   End If
   Form2.x1.CurrentPosition = P(index).Stp
  End If
 'Form1.Label3.Caption = Index
 
End If
End Function
Function UnloadMove()
 ReDim P(0)
 index = 0
 Count = 0
 Stp = 0
 Etp = 0
 NewCl = False
 Form1.TimerMove.Enabled = False
 State = False
End Function
