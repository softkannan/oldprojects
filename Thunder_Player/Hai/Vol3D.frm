VERSION 5.00
Begin VB.Form Form31 
   BackColor       =   &H80000007&
   BorderStyle     =   0  'None
   Caption         =   "Vol3D"
   ClientHeight    =   3150
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3750
   DrawMode        =   6  'Mask Pen Not
   DrawStyle       =   5  'Transparent
   LinkTopic       =   "Form8"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3150
   ScaleWidth      =   3750
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Pic1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   240
      Left            =   2520
      Picture         =   "Vol3D.frx":0000
      ScaleHeight     =   240
      ScaleWidth      =   240
      TabIndex        =   3
      Top             =   2160
      Width           =   240
   End
   Begin VB.PictureBox SpeakerRight 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   510
      Left            =   1080
      Picture         =   "Vol3D.frx":0102
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   2
      Top             =   2160
      Width           =   510
   End
   Begin VB.PictureBox SpeakerLeft 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   510
      Left            =   2160
      Picture         =   "Vol3D.frx":0944
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   1
      Top             =   960
      Width           =   510
   End
   Begin VB.PictureBox Head 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   630
      Left            =   1080
      Picture         =   "Vol3D.frx":1186
      ScaleHeight     =   600
      ScaleWidth      =   555
      TabIndex        =   0
      Top             =   600
      Width           =   585
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H0080FF80&
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
Sub Drag(Button As Integer, x As Single, y As Single)
  On Error Resume Next
  x = x - left1
  y = y - top1
  If Button = 1 Then
  Pic1.Move x + Pic1.Left, y + Pic1.Top
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
 Sizewin1 Me.Hwnd, 50, 50
 'Sizewin1 Pic1.hwnd, 15, 15
 SpeakerLeft.Top = (Form31.Height / 2) - (SpeakerLeft.Height / 2)
 SpeakerLeft.Left = 500
 SpeakerRight.Top = (Form31.Height / 2) - (SpeakerRight.Height / 2)
 SpeakerRight.Left = Form31.Width - SpeakerRight.Width - 600
 Head.Top = (Form31.Height / 2) - (Head.Height / 2)
 Head.Left = (Form31.Width / 2) - (Head.Width / 2)
 Pic1.Left = Form1.fl.Left3D
 Pic1.Top = Form1.fl.Right3D
 Process Pic1.Left, Pic1.Top
 
 'PaintWnd Me.hwnd, Me.hdc
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 On Error Resume Next
 If Button = 1 Then
  If x < 40 Then
   x = 40
  End If
  If x > Form31.Width - 200 Then
   x = Form31.Width - 200
  End If
  If y < 40 Then
   y = 40
  End If
  If y > Form31.Height - 225 Then
   y = Form31.Height - 225
  End If
  Pic1.Top = y
  Pic1.Left = x
  Process x, y
 ElseIf Button = 2 Then
  left2 = x
  top2 = y
  'PopupMenu Form3.Volume3D
 End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Drag1 Button, x, y
End Sub
Private Sub Head_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
 If x < 0 Then
   x = 0
  End If
  If x > Head.Width Then
   x = Head.Width
  End If
  If y < 0 Then
   y = 0
  End If
  If y > Head.Height Then
   y = Head.Height
  End If
  Pic1.Top = y + Head.Top
  Pic1.Left = x + Head.Left
  Process x, y
 Else
  PopupMenu Form3.Volume3D
 End If
End Sub
Private Sub Pic1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
  If Button = 1 Then
   left1 = x
   top1 = y
  Else
   PopupMenu Form3.Volume3D
  End If
End Sub
Private Sub Pic1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Drag Button, x, y
End Sub
Sub Process(ByVal x As Integer, ByVal y As Integer)
 On Error Resume Next
 Dim x1, Y1, B1, V1 As Integer
 x1 = CInt((x / (Form31.Width - 200)) * 100)
 Y1 = CInt((y / (Form31.Height - 225)) * 100)
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
 Form1.fl.Left3D = x
 Form1.fl.Right3D = y
End Sub
Sub Drag1(Button As Integer, x As Single, y As Single)
 On Error Resume Next
  x = x - left2
  y = y - top2
  If Button = 2 Then
    Form31.Move x + Form31.Left, y + Form31.Top
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
Private Sub SpeakerLeft_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
 If x < 0 Then
   x = 0
  End If
  If x > SpeakerLeft.Width Then
   x = SpeakerLeft.Width
  End If
  If y < 0 Then
   y = 0
  End If
  If y > SpeakerLeft.Height Then
   y = SpeakerLeft.Height
  End If
  Pic1.Top = y + SpeakerLeft.Top
  Pic1.Left = x + SpeakerLeft.Left
  Process x, y
 Else
  PopupMenu Form3.Volume3D
 End If
End Sub
Private Sub SpeakerRight_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
 If x < 0 Then
   x = 0
  End If
  If x > SpeakerRight.Width Then
   x = SpeakerRight.Width
  End If
  If y < 0 Then
   y = 0
  End If
  If y > SpeakerRight.Height Then
   y = SpeakerRight.Height
  End If
  Pic1.Top = y + SpeakerRight.Top
  Pic1.Left = x + SpeakerRight.Left
  Process x, y
 Else
  PopupMenu Form3.Volume3D
 End If
End Sub

