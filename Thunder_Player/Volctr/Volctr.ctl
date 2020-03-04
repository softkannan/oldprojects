VERSION 5.00
Begin VB.UserControl VolCtr 
   BackStyle       =   0  'Transparent
   ClientHeight    =   1245
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1215
   KeyPreview      =   -1  'True
   ScaleHeight     =   62.25
   ScaleMode       =   2  'Point
   ScaleWidth      =   60.75
   Begin VB.PictureBox P1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   960
      Left            =   120
      Picture         =   "Volctr.ctx":0000
      ScaleHeight     =   64
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   64
      TabIndex        =   0
      Top             =   120
      Width           =   960
      Begin VB.PictureBox Ptr 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         ForeColor       =   &H80000008&
         Height          =   135
         Left            =   240
         ScaleHeight     =   105
         ScaleWidth      =   105
         TabIndex        =   1
         Top             =   480
         Width           =   135
      End
   End
End
Attribute VB_Name = "VolCtr"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Private Value1 As Long
Private Max1 As Long
Private f As Boolean
Private X1 As Single
Public Event Change()
Private Sub P1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
X1 = X
End Sub
Private Sub P1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
If Button = 1 Then
  If X1 > X Then
   If (X1 - X) > 40 Then
    Decr
   End If
  Else
   If (X - X1) > 40 Then
    Inr
   End If
  End If
 End If
End Sub
Private Sub UserControl_Initialize()
Ptr.Top = P1.Height / 2
Ptr.Left = P1.Width / 2
Value1 = 1
f = False
End Sub
Public Property Let Value(t As Long)
 Value1 = (t / Max1) * 210
 Update
End Property
Public Property Let Max(t As Long)
 Max1 = t
End Property
Public Property Get Value() As Long
 Value = Value1
End Property
Sub Inr()
 Value1 = Value1 + 5
 If Value1 > 210 Then
  Value1 = 210
 End If
 Update
End Sub
Sub Decr()
 Value1 = Value1 - 5
 If Value1 < 1 Then
  Value1 = 1
 End If
 Update
End Sub
Sub Update()
  Ptr.Top = (P1.Height / 2) - 18 * Sin(PI / 180 * Value1)
  Ptr.Left = (P1.Width / 2) - 18 * Cos(PI / 180 * Value1)
  RaiseEvent Change
End Sub
