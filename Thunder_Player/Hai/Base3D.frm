VERSION 5.00
Begin VB.Form Form31 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "3DVolume Control"
   ClientHeight    =   3150
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3750
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   210
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   250
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox SpeakerRight 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   510
      Left            =   360
      Picture         =   "Base3D.frx":0000
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   2
      ToolTipText     =   "Right Speaker"
      Top             =   1440
      Width           =   510
   End
   Begin VB.PictureBox SpeakerLeft 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   510
      Left            =   2640
      Picture         =   "Base3D.frx":0842
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   1
      ToolTipText     =   "Left Speaker"
      Top             =   1320
      Width           =   510
   End
   Begin VB.PictureBox Head 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   630
      Left            =   1080
      Picture         =   "Base3D.frx":1084
      ScaleHeight     =   600
      ScaleWidth      =   555
      TabIndex        =   0
      ToolTipText     =   "Your Head In Front Of CPU"
      Top             =   1320
      Width           =   585
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H0000FF00&
      BorderWidth     =   3
      Height          =   3135
      Left            =   0
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   3735
   End
End
Attribute VB_Name = "Form31"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private left1 As Integer
Private top1 As Integer
Private left2 As Integer
Private top2 As Integer
Sub Drag(Button As Integer, X As Single, Y As Single)
  On Error Resume Next
  X = X - left1
  Y = Y - top1
  If Button = 1 Then
  Pic1.Move X + Pic1.Left, Y + Pic1.Top
  End If
  If Pic1.Left < 40 Then
  Pic1.Left = 40
  Pic1.Move Pic1.Left, Pic1.Top
  End If
  If Pic1.Top < 40 Then
  Pic1.Top = 40
  Pic1.Move Pic1.Left, Pic1.Top
  End If
  If Pic1.Left > Form31.Width - 200 Then
  Pic1.Left = Form31.Width - 200
  Pic1.Move Pic1.Left, Pic1.Top
  End If
  If Pic1.Top > Form31.Height - 225 Then
  Pic1.Top = Form31.Height - 225
  Pic1.Move Pic1.Left, Pic1.Top
  End If
  'Label1.Caption = "X:" + Str(Pic1.Left) + " Y:" + Str(Pic1.Top)
  Process Pic1.Left, Pic1.Top
End Sub
Private Sub Form_Load()
 Sizewin1 Me.hwnd, 50, 50
 'Sizewin1 Pic1.hwnd, 15, 15
 SpeakerLeft.Top = (Form31.Height / 2) - (SpeakerLeft.Height / 2)
 SpeakerLeft.Left = 500
 SpeakerRight.Top = (Form31.Height / 2) - (SpeakerRight.Height / 2)
 SpeakerRight.Left = Form31.Width - SpeakerRight.Width - 600
 Head.Top = (Form31.Height / 2) - (Head.Height / 2)
 Head.Left = (Form31.Width / 2) - (Head.Width / 2)
 'Pic1.Left = Form1.fl.Left3D
 'Pic1.Top = Form1.fl.Right3D
' Process Pic1.Left, Pic1.Top
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 On Error Resume Next
 If Button = 1 Then
  If X < 40 Then
   X = 40
  End If
  If X > Form31.Width - 200 Then
   X = Form31.Width - 200
  End If
  If Y < 40 Then
   Y = 40
  End If
  If Y > Form31.Height - 225 Then
   Y = Form31.Height - 225
  End If
  Pic1.Top = Y
  Pic1.Left = X
  Process X, Y
 ElseIf Button = 2 Then
  left2 = X
  top2 = Y
  'PopupMenu Form3.Volume3D
 End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 Drag1 Button, X, Y
End Sub
Private Sub Head_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Button = 1 Then
 If X < 0 Then
   X = 0
  End If
  If X > Head.Width Then
   X = Head.Width
  End If
  If Y < 0 Then
   Y = 0
  End If
  If Y > Head.Height Then
   Y = Head.Height
  End If
  Pic1.Top = Y + Head.Top
  Pic1.Left = X + Head.Left
  Process X, Y
 Else
  PopupMenu Form3.Volume3D
 End If
End Sub
Private Sub Pic1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  If Button = 1 Then
   left1 = X
   top1 = Y
  Else
   PopupMenu Form3.Volume3D
  End If
End Sub
Private Sub Pic1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 Drag Button, X, Y
End Sub
Sub Process(ByVal X As Integer, ByVal Y As Integer)
 On Error Resume Next
 Dim x1, Y1, B1, V1 As Integer
 x1 = CInt((X / (Form31.Width - 200)) * 100)
 Y1 = CInt((Y / (Form31.Height - 225)) * 100)
 V1 = CInt((((100 - Y1) * 2) / 100) * 3000)
 B1 = CInt((((100 - x1) * 2) / 100) * 1500)
 B1 = 1500 - B1
 V1 = 3000 - V1
 If x1 < 50 Then
  x1 = x1 * 2
  B1 = CInt(((100 - x1) / 100) * 1500)
  B1 = B1 * -1
 End If
 If V1 < 50 Then
  Y1 = Y1 * 2
  V1 = CInt(((100 - Y1) / 100) * 3000)
 End If
 V1 = V1 * -1
 Form2.x1.Volume = V1
 If Form1.fl.Swap = True Then
   Form2.x1.Balance = B1 * -1
 Else
   Form2.x1.Balance = B1
 End If
 Form1.fl.Left3D = X
 Form1.fl.Right3D = Y
End Sub
Sub Drag1(Button As Integer, X As Single, Y As Single)
 On Error Resume Next
  X = X - left2
  Y = Y - top2
  If Button = 2 Then
    Form31.Move X + Form31.Left, Y + Form31.Top
  End If
End Sub
Sub MenuRes(opt As Integer)
 Select Case opt
  Case 1:
   If Form1.fl.Swap = True Then
    Form1.fl.Swap = False
   Else
    Form1.fl.Swap = True
   End If
  Case 2:
    Unload Me
 End Select
End Sub
Private Sub SpeakerLeft_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Button = 1 Then
 If X < 0 Then
   X = 0
  End If
  If X > SpeakerLeft.Width Then
   X = SpeakerLeft.Width
  End If
  If Y < 0 Then
   Y = 0
  End If
  If Y > SpeakerLeft.Height Then
   Y = SpeakerLeft.Height
  End If
  Pic1.Top = Y + SpeakerLeft.Top
  Pic1.Left = X + SpeakerLeft.Left
  Process X, Y
 Else
  PopupMenu Form3.Volume3D
 End If
End Sub
Private Sub SpeakerRight_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If Button = 1 Then
 If X < 0 Then
   X = 0
  End If
  If X > SpeakerRight.Width Then
   X = SpeakerRight.Width
  End If
  If Y < 0 Then
   Y = 0
  End If
  If Y > SpeakerRight.Height Then
   Y = SpeakerRight.Height
  End If
  Pic1.Top = Y + SpeakerRight.Top
  Pic1.Left = X + SpeakerRight.Left
  Process X, Y
 Else
  PopupMenu Form3.Volume3D
 End If
End Sub
