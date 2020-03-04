VERSION 5.00
Begin VB.UserControl VC1 
   BackColor       =   &H80000004&
   BackStyle       =   0  'Transparent
   ClientHeight    =   285
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1560
   KeyPreview      =   -1  'True
   ScaleHeight     =   285
   ScaleWidth      =   1560
   Begin VB.PictureBox Ba 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H80000008&
      Height          =   75
      Left            =   120
      ScaleHeight     =   45
      ScaleWidth      =   1305
      TabIndex        =   0
      Top             =   120
      Width           =   1335
      Begin VB.Image Sli 
         Appearance      =   0  'Flat
         Height          =   135
         Left            =   0
         Picture         =   "Vctr.ctx":0000
         Top             =   0
         Width           =   135
      End
   End
End
Attribute VB_Name = "VC1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Option Explicit
Public Event Change()
Public Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Private Max1 As Long
Private Val1 As Long
Private X1 As Single
Private Sub Ba_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Button = 1 Then
  Sli.Left = X
  UpdateV
 End If
End Sub

Private Sub Ba_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
RaiseEvent MouseMove(Button, Shift, X, Y)
End Sub

Private Sub Sli_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 X1 = X
End Sub
Private Sub Sli_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Button = 1 Then
  X = X - X1
  If X + Sli.Left < 0 Then
  X = 0
  End If
  Sli.Left = X + Sli.Left
  If Sli.Left > Ba.Width - Sli.Width Then
    Sli.Left = Ba.Width - Sli.Width
  End If
  UpdateV
 End If
 RaiseEvent MouseMove(Button, Shift, X, Y)
End Sub
Sub UpdateV()
 Val1 = (Sli.Left / Ba.Width) * Max1
 RaiseEvent Change
End Sub
Private Sub UserControl_Initialize()
 Max1 = 5000
End Sub
Sub Update()
 Sli.Left = (Val1 / Max1) * (Ba.Width - Ba.Left)
 RaiseEvent Change
End Sub
Public Property Let Max(t As Long)
Max1 = t
Val1 = 1
Update
End Property
Public Property Get Value() As Long
 Value = Val1
End Property
Public Property Let Value(t As Long)
 Val1 = t
 Update
End Property
Public Property Let SliderCol(t As Long)
Ba.BackColor = t
End Property
Private Sub UserControl_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
RaiseEvent MouseMove(Button, Shift, X, Y)
End Sub
