VERSION 5.00
Object = "{84D1EEB7-556A-11D1-8118-B7B45FE6C56E}#1.0#0"; "libbtn.ocx"
Object = "{23D221AC-C35F-4EF7-AFEE-F350F848026A}#1.0#0"; "SliderThu.ocx"
Begin VB.Form Form4 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Slider"
   ClientHeight    =   990
   ClientLeft      =   3570
   ClientTop       =   3435
   ClientWidth     =   3750
   Icon            =   "Slider.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form4"
   ScaleHeight     =   990
   ScaleWidth      =   3750
   ShowInTaskbar   =   0   'False
   Begin SlderTwo.Slider P11 
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   600
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   450
   End
   Begin SlderTwo.VC1 V1 
      Height          =   375
      Left            =   1000
      TabIndex        =   9
      Top             =   50
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   661
   End
   Begin VB.PictureBox Mu 
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      ForeColor       =   &H80000008&
      Height          =   100
      Left            =   1000
      ScaleHeight     =   75
      ScaleWidth      =   75
      TabIndex        =   8
      ToolTipText     =   "Mute"
      Top             =   150
      Width           =   100
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn6 
      Height          =   255
      Left            =   2280
      TabIndex        =   7
      TabStop         =   0   'False
      ToolTipText     =   "Play List"
      Top             =   345
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Slider.frx":030A
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn5 
      Height          =   255
      Left            =   2040
      TabIndex        =   4
      TabStop         =   0   'False
      ToolTipText     =   "Frame Forward"
      Top             =   345
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Slider.frx":085C
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn4 
      Height          =   255
      Left            =   1800
      TabIndex        =   3
      TabStop         =   0   'False
      ToolTipText     =   "Frame Rewind"
      Top             =   345
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Slider.frx":0DAE
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn3 
      Height          =   255
      Left            =   1560
      TabIndex        =   2
      TabStop         =   0   'False
      ToolTipText     =   "End Point"
      Top             =   345
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Slider.frx":1300
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn2 
      Height          =   255
      Left            =   1320
      TabIndex        =   1
      TabStop         =   0   'False
      ToolTipText     =   "Start Point"
      Top             =   345
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Slider.frx":1852
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn1 
      Height          =   255
      Left            =   1080
      TabIndex        =   0
      TabStop         =   0   'False
      ToolTipText     =   "Make Movie"
      Top             =   345
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Slider.frx":1DA4
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.Label Plmode 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Repeat All"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   2760
      TabIndex        =   6
      Top             =   80
      Width           =   975
   End
   Begin VB.Label Time 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   15
      TabIndex        =   5
      Top             =   45
      Width           =   720
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H0000FF00&
      BorderWidth     =   3
      Height          =   975
      Left            =   0
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   3735
   End
End
Attribute VB_Name = "Form4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 Form1.KeyRes KeyCode, Shift
End Sub
Private Sub Form_Load()
 Sizewin1 Me.Hwnd, 20, 20
 Form4.ZOrder (1)
 Form4.Top = Form1.Top
 Form4.Left = Form1.Left
 V1.Value = Form2.x1.Volume * -1
End Sub
Private Sub Form_LostFocus()
Form1.DisName
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 Form1.MouseRes Button, Shift
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.DisName
End Sub

Private Sub Mu_Click()
 Form1.Mute1
End Sub

Private Sub P11_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Slider Bar"
End Sub
Private Sub P11_Scroll()
 Form2.x1.CurrentPosition = P11.Value
End Sub
Private Sub Plmode_Click()
 PlmodeChange
End Sub
Private Sub Plmode_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Click And Feel"
End Sub

Private Sub SoftBttn1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  Form1.mov.Makeclip
 ElseIf Button = 2 Then
  PopupMenu Form2.Move2
 End If
End Sub

Private Sub SoftBttn1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Right Click See Menu"
End Sub

Private Sub SoftBttn2_Click()
 Form1.mov.MarkSClip
End Sub

Private Sub SoftBttn2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Clip Start Point"
End Sub

Private Sub SoftBttn3_Click()
 Form1.mov.MarkEClip
End Sub

Private Sub SoftBttn3_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Clip End Point"
End Sub

Private Sub SoftBttn4_Click()
Form1.FrameSeek False
End Sub

Private Sub SoftBttn4_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Previous Frame"
End Sub

Private Sub SoftBttn5_Click()
 Form1.FrameSeek True
End Sub

Private Sub SoftBttn5_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Next Frame"
End Sub

Private Sub SoftBttn6_Click()
 Form3.Show
 
End Sub
Sub PlmodeChange()
 If Form1.fl.Plmode = 0 Then
  Form1.fl.Plmode = 1
  Form4.Plmode.Caption = "Suffle"
 ElseIf Form1.fl.Plmode = 1 Then
  Form1.fl.Plmode = 2
  Form4.Plmode.Caption = "Repeat My"
 Else
  Form1.fl.Plmode = 0
  Form4.Plmode.Caption = "Repeat All"
 End If
End Sub

Private Sub SoftBttn6_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Play list"
End Sub
Private Sub Time_Click()
 If Form1.fl.Tis = 0 Then
  Form1.fl.Tis = 1
 ElseIf Form1.fl.Tis = 1 Then
  Form1.fl.Tis = 2
 Else
  Form1.fl.Tis = 0
 End If
End Sub
Private Sub Time_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Click And Feel"
End Sub
Private Sub V1_Change()
 Form2.x1.Volume = (V1.Value) * (-1)
 End Sub
Private Sub V1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Form1.Label3.Caption = "Volume Control"
End Sub
