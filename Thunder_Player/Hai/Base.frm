VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{84D1EEB7-556A-11D1-8118-B7B45FE6C56E}#1.0#0"; "LIBBTN.OCX"
Begin VB.Form Form1 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Thunder Player"
   ClientHeight    =   990
   ClientLeft      =   3780
   ClientTop       =   4380
   ClientWidth     =   3750
   Icon            =   "Base.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   990
   ScaleWidth      =   3750
   Begin VB.Timer TimerSo3d 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3120
      Top             =   360
   End
   Begin VB.Timer TimerSoDo 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   840
      Top             =   240
   End
   Begin VB.Timer TimerSoDt 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   600
      Top             =   240
   End
   Begin VB.Timer TimerSoW 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   600
      Top             =   240
   End
   Begin VB.Timer TimerLogo 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   840
      Top             =   240
   End
   Begin VB.Timer TimerCtr2 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2400
      Top             =   120
   End
   Begin VB.Timer TimerCtr1 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   2640
      Top             =   120
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn13 
      Height          =   255
      Left            =   3555
      TabIndex        =   12
      TabStop         =   0   'False
      ToolTipText     =   "Release MCI Player"
      Top             =   600
      Width           =   105
      _ExtentX        =   185
      _ExtentY        =   450
      BackColor       =   16777088
      Enabled         =   -1  'True
      MaskColor       =   65280
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn14 
      Height          =   255
      Left            =   75
      TabIndex        =   11
      TabStop         =   0   'False
      ToolTipText     =   "Release Slider"
      Top             =   600
      Width           =   105
      _ExtentX        =   185
      _ExtentY        =   450
      BackColor       =   16777088
      Enabled         =   -1  'True
      MaskColor       =   65280
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.Timer TimerFull 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   240
      Top             =   0
   End
   Begin VB.Timer TimerMove 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1560
      Top             =   240
   End
   Begin VB.Timer TimerSli 
      Interval        =   1000
      Left            =   720
      Top             =   240
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn11 
      Height          =   135
      Left            =   3360
      TabIndex        =   10
      TabStop         =   0   'False
      ToolTipText     =   "Quit"
      Top             =   150
      Width           =   135
      _ExtentX        =   238
      _ExtentY        =   238
      BackColor       =   255
      Enabled         =   -1  'True
      MaskColor       =   255
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn10 
      Height          =   135
      Left            =   3120
      TabIndex        =   9
      TabStop         =   0   'False
      ToolTipText     =   "Minimise"
      Top             =   150
      Width           =   135
      _ExtentX        =   238
      _ExtentY        =   238
      BackColor       =   65280
      Enabled         =   -1  'True
      MaskColor       =   65280
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin MSComDlg.CommonDialog Openbo 
      Left            =   2400
      Top             =   240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
      DefaultExt      =   "thu"
      Filter          =   "SuportedFiles|*.wmv;*.thu;*.m3u;*.avi;*.mov;*.mp3;*.mp2;*.mpg;*.dat;*.asf;*.wma;*.wav;*.au;*.mid;*.midi;*.asx|All Files|*.*"
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn9 
      Height          =   255
      Left            =   2280
      TabIndex        =   8
      TabStop         =   0   'False
      ToolTipText     =   "Open"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":030A
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn8 
      Height          =   255
      Left            =   1920
      TabIndex        =   7
      TabStop         =   0   'False
      ToolTipText     =   "Zoom"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":085C
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn7 
      Height          =   255
      Left            =   1680
      TabIndex        =   6
      TabStop         =   0   'False
      ToolTipText     =   "Forward"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":0DAE
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn6 
      Height          =   255
      Left            =   1440
      TabIndex        =   5
      TabStop         =   0   'False
      ToolTipText     =   "Rewind"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":1300
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn5 
      Height          =   255
      Left            =   1200
      TabIndex        =   4
      TabStop         =   0   'False
      ToolTipText     =   "Next Track"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":1852
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn4 
      Height          =   255
      Left            =   960
      TabIndex        =   3
      TabStop         =   0   'False
      ToolTipText     =   "Stop"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":1DA4
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn3 
      Height          =   255
      Left            =   720
      TabIndex        =   2
      TabStop         =   0   'False
      ToolTipText     =   "Pause"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":22F6
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn2 
      Height          =   255
      Left            =   480
      TabIndex        =   1
      TabStop         =   0   'False
      ToolTipText     =   "Play"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":2848
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn1 
      Height          =   255
      Left            =   240
      TabIndex        =   0
      TabStop         =   0   'False
      ToolTipText     =   "Prev Track "
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Base.frx":2D9A
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Rate"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   3120
      TabIndex        =   16
      Top             =   630
      Width           =   375
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      ForeColor       =   &H0000FF00&
      Height          =   225
      Left            =   120
      TabIndex        =   15
      Top             =   330
      Width           =   3450
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Sound"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   2520
      TabIndex        =   14
      Top             =   630
      Width           =   615
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Height          =   1095
      Left            =   0
      TabIndex        =   13
      Top             =   -120
      Width           =   3735
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00000000&
      BorderColor     =   &H0000FF00&
      BorderWidth     =   3
      Height          =   975
      Left            =   0
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   3735
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public fl As New Const1
Public mov As New EditMov
Sub ope(Optional Filename As String)
 On Error Resume Next
 If Filename <> "" Then
   Form2.openmedia (Filename)
  Else
   Openbo.Filename = ""
   Openbo.ShowOpen
   If Err.Number <> 32755 Then
      Form2.openmedia (Openbo.Filename)
   End If
End If
End Sub
Private Sub Form_Activate()
 If Formm.MM1.UsesWindows Then
  If Formm.full = True Then
  Formm.Resize 1
  End If
 End If
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 KeyRes KeyCode, Shift
End Sub
Private Sub Form_Load()
  On Error Resume Next
  Sizewin1 Me.Hwnd, 20, 20
  fl.CDPath = ""
  'Form2.Show
  'Form2.Hide
  Form4.V1.Max = 5000
  Form4.Show
  Form4.Hide
  fl.Ct1 = True
  fl.ct2 = True
  fl.ct3 = True
  fl.Tis = 0
  fl.Minz = False
  fl.SoundCount1 = 0
  fl.RateCount1 = 0
  PreLoad
  If Command$ = "" Then
    Open App.Path + "\default.m3u" For Input As #1
    If Err.Number = 0 Then
     Close #1
     ope App.Path + "\default.m3u"
    End If
    Close #1
  End If
  Kill App.Path + "\default.m3u"
 fl.Lo1 = False
 
End Sub

Private Sub Form_LostFocus()
DisName
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  fl.left1 = x
  fl.top1 = y
    If fl.ct2 = False Then
     Form4.ZOrder 0
    End If
    If fl.Ct1 = True Then
     Formm.ZOrder 0
    End If
 Else
  MouseRes Button, Shift
 End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Drag Button, x, y
 DisName
End Sub
Private Sub Form_Resize()
If fl.Minz = True Then
 Form1.Show
 If fl.Ct1 = False Then
  Formm.Show
 End If
 If fl.ct2 = False Then
  Form4.Show
 End If
 fl.Minz = False
End If
End Sub
Private Sub Form_Unload(Cancel As Integer)
 end1
End Sub
Private Sub Label1_Click()
 PopupMenu Form2.Sound1, 1, Label1.Left, Label1.Top + Label1.Height
End Sub
Private Sub Label1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Sound Effect"
End Sub

Private Sub Label2_Click()
 PopupMenu Form2.Rate1, 1, Label2.Left, Label2.Top + Label2.Height
End Sub
Sub MainMenu(index As Integer)
 Dim th As Long
 Select Case index
  Case 0:
   MsgBox "This Is Develobed By," + vbCr + "                                                          K.Kannan," + vbCr + "                          Computer Science Department," + vbCr + "                                      Maharaja Engg College.", vbOKOnly Or vbInformation, "About"
   th = ShellExecute(Me.Hwnd, "Open", App.Path + "\about.exe", "", "", vbNormalFocus)
  Case 7:
   Form6.Show
  Case 8:
   Form5.Show
  Case 9:
   FullScreen
  Case 10:
   Close1
  Case 12:
   end1
 End Select
End Sub

Private Sub Label2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Rate Control"
End Sub

Private Sub Label3_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  fl.left1 = x
  fl.top1 = y
 Else
  MouseRes Button, Shift
 End If
End Sub
Private Sub Label3_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Drag Button, x, y
End Sub
Private Sub Label4_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
If Button = 1 Then
  fl.left1 = x
  fl.top1 = y
    If fl.ct2 = False Then
     Form4.ZOrder 0
    End If
    If fl.Ct1 = True Then
     Formm.ZOrder 0
    End If
 Else
  MouseRes Button, Shift
 End If
End Sub
Private Sub Label4_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Drag Button, x, y
DisName
End Sub
Private Sub SoftBttn1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 Dim i As Long
 If Button = 1 Then
  PrevTrack
 Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(0).Visible = True
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
 End If
End Sub
Private Sub SoftBttn1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Previous track "
End Sub
Private Sub SoftBttn10_Click()
 On Error Resume Next
 Form1.WindowState = 1
 Form4.Hide
 Formm.Hide
 fl.Minz = True
End Sub

Private Sub SoftBttn10_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Minimise"
End Sub

Private Sub SoftBttn11_Click()
 end1
End Sub

Private Sub SoftBttn11_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Close"
End Sub

Private Sub SoftBttn13_Click()
 If fl.Ct1 = True Then
  TimerCtr1.Enabled = True
  Formm.Height = 0
  Formm.Show
 Else
  TimerCtr1.Enabled = True
 End If
End Sub

Private Sub SoftBttn13_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Upper Tray"
End Sub

Private Sub SoftBttn14_Click()
If fl.ct2 = True Then
  TimerCtr2.Enabled = True
  Form4.Show
  Form4.ZOrder 1
  Form4.Top = Form1.Top
  Form4.Left = Form1.Left
 Else
  TimerCtr2.Enabled = True
 End If
End Sub

Private Sub SoftBttn14_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Label3.Caption = "Lower Tray"
End Sub

Private Sub SoftBttn2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Long
If Button = 1 Then
  Play
Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(1).Visible = True
   Form2.Other2(0).Visible = False
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
End If
End Sub

Private Sub SoftBttn2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Play"
End Sub

Private Sub SoftBttn3_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Long
If Button = 1 Then
  Pause
Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(2).Visible = True
   Form2.Other2(0).Visible = False
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
End If
End Sub

Private Sub SoftBttn3_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Pause"
End Sub

Private Sub SoftBttn4_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Long
If Button = 1 Then
  Stop1
Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(3).Visible = True
   Form2.Other2(0).Visible = False
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
End If
End Sub

Private Sub SoftBttn4_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Stop"
End Sub

Private Sub SoftBttn5_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Long
If Button = 1 Then
  NextTrack
Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(4).Visible = True
   Form2.Other2(0).Visible = False
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
End If
End Sub

Private Sub SoftBttn5_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Next Track"
End Sub

Private Sub SoftBttn6_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Long
If Button = 1 Then
  PrevStep 10
Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(5).Visible = True
   Form2.Other2(0).Visible = False
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
End If
End Sub

Private Sub SoftBttn6_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Forward"
End Sub

Private Sub SoftBttn7_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
Dim i As Long
If Button = 1 Then
  NextStep 10
Else
  For i = 1 To 6
   Form2.Other2(i).Visible = False
  Next
   Form2.Other2(6).Visible = True
   Form2.Other2(0).Visible = False
   PopupMenu Form2.Other1
   Form2.Other2(0).Visible = True
End If
End Sub

Private Sub SoftBttn7_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Rewind"
End Sub

Private Sub SoftBttn8_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
If Button = 1 Then
 If fl.PrevSize = 2 Then
  MovieSize fl.PrevSize + 2
 ElseIf fl.PrevSize = 7 Then
 fl.PrevSize = 0
 MovieSize fl.PrevSize + 1
 Else
 MovieSize fl.PrevSize + 1
 End If
Else
 PopupMenu Form2.Main2(6)
End If
End Sub
Sub Pause()
 If Form2.x1.Filename <> "" Then
  Form2.x1.Pause
 Else
  If Form3.List1.ListCount < 0 Then
    fl.Plflag = True
    ope
  Else
    fl.Plflag = True
    Form2.openmedia Form3.List1.Text
  End If
 End If
End Sub
Sub Play()
 If Form2.x1.Filename <> "" Then
  If Form2.x1.PlayState = mpPlaying Then
   Form2.x1.Pause
  Else
   Form2.x1.Play
  End If
 Else
  If Form3.List1.ListCount < 1 Then
    fl.Plflag = True
    ope
  Else
    fl.Plflag = True
    Form2.openmedia Form3.List1.Text
  End If
 End If
End Sub
Sub Stop1()
 If Form2.x1.Filename <> "" Then
  Form2.x1.Pause
  Form2.x1.CurrentPosition = 0
 Else
  If Form3.List1.ListCount < 1 Then
    fl.Plflag = True
    ope
  Else
    fl.Plflag = True
    Form2.openmedia Form3.List1.Text
  End If
 End If
End Sub
Sub PrevStep(val As Integer)
 If Form2.x1.Filename <> "" Then
  If Form2.x1.CurrentPosition > val Then
   Form2.x1.CurrentPosition = Form2.x1.CurrentPosition - val
  Else
   Form2.x1.CurrentPosition = 0
  End If
 Else
  If Form3.List1.ListCount < 1 Then
    fl.Plflag = True
    ope
  Else
    fl.Plflag = True
    Form2.openmedia Form3.List1.Text
  End If
 End If
End Sub
Sub NextStep(val As Integer)
 If Form2.x1.Filename <> "" Then
  Form2.x1.CurrentPosition = Form2.x1.CurrentPosition + val
 Else
  If Form3.List1.ListCount < 1 Then
    fl.Plflag = True
    ope
  Else
    fl.Plflag = True
    Form2.openmedia Form3.List1.Text
  End If
 End If
End Sub
Sub NextTrack()
 If Form3.List1.ListCount > 0 Then
  If Form3.List1.ListIndex > Form3.List1.ListCount - 2 Then
   Form3.List1.ListIndex = -1
  End If
  Form3.List1.ListIndex = Form3.List1.ListIndex + 1
  fl.Plflag = True
  Form2.openmedia (Form3.List1.Text)
 End If
End Sub
Sub PrevTrack()
 If Form3.List1.ListCount > 0 Then
  Form3.List1.ListIndex = Form3.List1.ListIndex - 1
  If Form3.List1.ListIndex < 0 Then
   Form3.List1.ListIndex = Form3.List1.ListCount - 1
  End If
   fl.Plflag = True
  Form2.openmedia (Form3.List1.Text)
 End If
End Sub
Sub Opencom()
If Form2.x1.Filename <> "" Then
  Form4.P11.Max = Form2.x1.Duration
  If Form2.x1.ImageSourceHeight > 0 Then
    Form2.Show
    If fl.Ful = True Then
     MovieSize 0
     FullScreen
    ElseIf Form2.x1.DisplaySize = mpFullScreen Then
     MovieSize 0
     FullScreen
    ElseIf fl.PrevSize > 0 Then
     MovieSize fl.PrevSize
    Else
     MovieSize 0
    End If
  Else
    Form2.Hide
  End If
  If fl.Au = True Then
    fl.Plflag = True
  End If
  If fl.Plflag = True Then
    Play
    fl.Plflag = False
  End If
 End If
End Sub
Sub Logo()
 fl.Logopa1 = Form2.x1.Filename
 fl.Plflag = True
 Form2.x1.Filename = fl.Logopa
 Form2.x1.CurrentPosition = fl.Stp
 TimerLogo.Enabled = True
End Sub
Sub Drag(Button As Integer, x As Single, y As Single)
  On Error Resume Next
  x = x - fl.left1
  y = y - fl.top1
  If Button = 1 Then
  Move x + Form1.Left, y + Form1.Top
  If fl.ct2 = False Then
   Form4.Move Form1.Left, Form1.Top + Form1.Height
  Else
   Form4.Move Form1.Left, Form1.Top
  End If
   Formm.Move Form1.Left, Form1.Top - Formm.Height
   Form7.Top = Form1.Top - Form7.Height
   Form7.Left = Form1.Left + Form1.Width
  End If
End Sub
Function MouseRes(ByVal Button As Integer, ByVal Shift As Single)
 On Error Resume Next
 Dim t As Long
 If Button = 1 Then
  If fl.SetFocu = True Then
    If fl.ct2 = False Then
     Form4.SetFocus
    End If
    If fl.Ct1 = False Then
     Formm.SetFocus
    End If
    Form1.SetFocus
    fl.SetFocu = False
  Else
    fl.SetFocu = True
    Form2.SetFocus
    Form2.x1.ZOrder
  End If
 Else
  PopupMenu Form2.main1
 End If
End Function
Sub MovieSize(opt As Integer)
 If Form2.x1.Filename <> "" And Form2.x1.ImageSourceHeight > 0 Then
    'If Form1.
    'WindowState = 1 Then
    'Form1.WindowState = 2
    'End If
    fl.PrevSize = opt
    If opt = 3 Then
     FullScreen
    Else
    Form2.x1.DisplaySize = opt
    Form2.Frame1.Height = Form2.x1.Height + 315
    Form2.Frame1.Width = Form2.x1.Width + 215
    Form2.Height = Form2.x1.Height + 800
    Form2.Width = Form2.x1.Width + 450
    End If
 End If
End Sub
Sub KeyRes(ByVal KeyCode As Integer, ByVal Shift As Integer)
 Select Case KeyCode
  Case 37:
   PrevStep 3
  Case 39:
   NextStep 3
  Case vbKeyN:
   Pause
  Case vbKeySpace
   Play
  Case vbKeyZ:
   PrevStep 10
  Case vbKeyX:
   NextStep 10
  Case vbKey0 To vbKey9:
   Form2.x1.CurrentPosition = Form2.x1.Duration - ((Form2.x1.Duration / 9) * (vbKey9 - KeyCode))
  Case 38:
   Vol1Menu 0
  Case 40:
   Vol1Menu 1
  Case vbKeyAdd:
   Vol1Menu (0)
  Case vbKeySubtract:
   Vol1Menu (1)
  Case vbKeyC:
   PrevTrack
  Case vbKeyV:
   NextTrack
  Case vbKeyB:
   Stop1
  Case vbKeyP:
   Form3.Show
  Case vbKeyO:
   ope
  Case vbKeyF:
   FullScreen
  Case vbKeyA:
    If fl.PrevSize = 2 Then
     MovieSize fl.PrevSize + 2
    ElseIf fl.PrevSize = 7 Then
     fl.PrevSize = 0
     MovieSize fl.PrevSize + 1
    Else
     MovieSize fl.PrevSize + 1
    End If
  Case vbKeyQ:
   end1
  Case vbKeyEscape:
   MovieSize 0
  Case vbKeyR:
   If fl.RateCount1 > 9 Then
      fl.RateCount1 = 0
   End If
   ChRate fl.RateCount1
   fl.RateCount1 = fl.RateCount1 + 1
 Case vbKeyS:
   If fl.SoundCount1 > 6 Then
      fl.SoundCount1 = 0
   End If
   ChSound fl.SoundCount1
   fl.SoundCount1 = fl.SoundCount1 + 1
 Case vbKeyF1:
   MainMenu 0
 Case vbKeyD:
   OpenVCD
 Case vbKeyU:
   OpenURL
 Case vbKeyF2:
   Form6.Show
 Case vbKeyF3:
   Form5.Show
 Case vbKeyT:
   MouseRes 1, 1
 End Select
End Sub

Private Sub SoftBttn8_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Zoom"
End Sub

Private Sub SoftBttn9_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  ope
 Else
  PopupMenu Form2.Open1
 End If
End Sub

Private Sub SoftBttn9_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label3.Caption = "Open"
End Sub

Private Sub TimerCtr1_Timer()
 If fl.Ct1 = True Then
  If Formm.Height < 900 Then
  Formm.Height = Formm.Height + 150
  Formm.Top = Form1.Top - Formm.Height
  Else
   Formm.Height = 1010
   Formm.Top = Form1.Top - Formm.Height
   TimerCtr1.Enabled = False
   fl.Ct1 = False
  End If
 Else
  If Formm.Height > 200 Then
  Formm.Height = Formm.Height - 150
  Formm.Top = Form1.Top - Formm.Height
  Else
   Unload Formm
   TimerCtr1.Enabled = False
   fl.Ct1 = True
  End If
 End If
End Sub
Private Sub TimerCtr2_Timer()
 If fl.ct2 = True Then
  If Form4.Top < (Form1.Top + Form1.Height - 200) Then
    Form4.Top = Form4.Top + 100
    Form4.ZOrder 1
  Else
    Form4.Top = Form1.Top + Form1.Height
    Form4.ZOrder 0
    TimerCtr2.Enabled = False
    fl.ct2 = False
  End If
 Else
  If Form4.Top > (Form1.Top + 200) Then
    Form4.Top = Form4.Top - 100
    Form4.ZOrder 1
  Else
    Form4.Top = Form1.Top
    TimerCtr2.Enabled = False
    Form4.ZOrder 1
    fl.ct2 = True
  End If
 End If
End Sub
Private Sub TimerFull_Timer()
 On Error Resume Next
 If Form2.x1.DisplaySize <> mpFullScreen Then
  Form1.TimerFull.Enabled = False
  MovieSize fl.PrevSize
  Form2.Show
  Form1.SetFocus
 End If
End Sub
Private Sub TimerLogo_Timer()
 If Form2.x1.CurrentPosition > fl.Etp Then
  TimerLogo.Enabled = False
  fl.Plflag = True
  Form2.x1.Filename = fl.Logopa1
  DisName
 End If
End Sub
Private Sub TimerMove_Timer()
 mov.Scroll
End Sub
Private Sub TimerSli_Timer()
Form4.P11.Value = Form2.x1.CurrentPosition
 Select Case fl.Tis
  Case 0:
     Form4.Time.Caption = Time1(Form2.x1.CurrentPosition)
  Case 1:
     Form4.Time.Caption = "-" + Time1(Form2.x1.Duration - Form2.x1.CurrentPosition)
  Case 2:
     Form4.Time.Caption = Time1(Form2.x1.Duration)
 End Select
End Sub
Sub FullScreen()
If Form2.x1.Filename <> "" And Form2.x1.ImageSourceHeight > 0 And Form2.x1.DisplaySize <> mpFullScreen Then
 fl.PrevSize = Form2.x1.DisplaySize
 TimerFull.Enabled = True
 Form2.x1.DisplaySize = mpDoubleSize
 Form2.Hide
 Form2.x1.DisplaySize = mpFullScreen
End If
End Sub
Sub Endstream()
 Dim t As Boolean
 If mov.State = True Then
  mov.State = False
  mov.UnloadMove
 End If
 If fl.Re = True Then
  t = fl.Lo
  fl.Lo = False
  PlayLisPl 2
  fl.Lo = t
 ElseIf fl.PlCount >= 0 Then
   t = fl.Lo
   fl.Lo = False
   PlayLisPl fl.Plmode
   fl.Lo = t
 End If
End Sub
Sub end1()
On Error Resume Next
UnloadPre
Formm.MM1.Command = "stop"
Formm.MM1.Command = "close"
End
End Sub
Sub Main4Menu(index As Integer)
  Select Case index
   Case 0:
    Play
   Case 1:
    Pause
   Case 2:
    Stop1
  End Select
End Sub
Sub Vol1Menu(index As Integer)
 Select Case index
  Case 0:
   If Form2.x1.Volume < -150 Then
      Form2.x1.Volume = Form2.x1.Volume + 100
      Form4.V1.Value = Form2.x1.Volume * -1
   Else
      Form2.x1.Volume = 0
      Form4.V1.Value = Form2.x1.Volume * -1
   End If
  Case 1:
   If Form2.x1.Volume > -9850 Then
       Form2.x1.Volume = Form2.x1.Volume - 100
       Form4.V1.Value = Form2.x1.Volume * -1
   Else
       Form2.x1.Volume = -10000
       Form4.V1.Value = Form2.x1.Volume * -1
   End If
  Case 2:
   Mute1
 End Select
End Sub
Sub Main3Menu(index As Integer)
 Select Case index
   Case 0:
    ope
   Case 1:
    OpenURL
   Case 2:
    OpenVCD
   Case 3:
    Form3.Show
 End Select
End Sub
Sub OpenVCD()
On Error GoTo last
 Form3.remove 2
 Form1.fl.PlCount = Form3.List1.ListCount
 Form8.Drive1.Drive = fl.CDPath
 Form8.Dir1.Path = fl.CDPath
 Form8.File1.Path = fl.CDPath + "\mpegav\"
 Form3.Add 2
 fl.Plflag = True
 If Form3.List3.ListIndex < 0 Then
  Form3.List3.ListIndex = 0
  Form3.List1.ListIndex = 0
 End If
 Form1.fl.PlCount = Form3.List1.ListCount
 Form3.OpenOk
 Form1.fl.PlCount = Form3.List1.ListCount
 GoTo PEnd
last:
 If Err.Number = 68 Then
  MsgBox "Put Your Video CD" + vbCr + "In Your CD-ROM Drive", 0, "Error"
 ElseIf Err.Number = 76 Then
  MsgBox "Your CD Is Not a Video CD", 0, "Error"
 Else
  MsgBox "Error Number :" + str(Err.Number) + vbCr + vbCr + Err.Description, 0, "Error"
 End If
PEnd:
End Sub
Sub OpenURL()
  Dim s As String
  s = "Open URL:" + vbCr + "Enter Like This www.mp3.com/l.mp3"
  s = InputBox(s, "Open URL")
  If s <> "" Then
    Form2.openmedia (s)
  End If
End Sub
Sub FrameSeek(opt As Boolean)
If Form2.x1.ImageSourceHeight <> 0 Then
 If opt = True Then
  Pause
  Form2.x1.DisplayMode = mpFrames
  Form2.x1.CurrentPosition = Form2.x1.CurrentPosition + 5
  Form2.x1.DisplayMode = mpTime
 Else
  Pause
  Form2.x1.DisplayMode = mpFrames
  If Form2.x1.CurrentPosition > 5 Then
   Form2.x1.CurrentPosition = Form2.x1.CurrentPosition - 5
  Else
   Form2.x1.CurrentPosition = 0
  End If
  Form2.x1.DisplayMode = mpTime
 End If
End If
End Sub
Sub Thumove(index As Integer)
 On Error Resume Next
 Select Case index
  Case 0:
   mov.Makeclip
  Case 1:
   mov.NewClip
  Case 2:
   Openbo.Filter = "*.thu"
   Openbo.ShowOpen
   If Err.no <> 32755 Then
    mov.LoadMove Openbo.Filename
   End If
   Openbo.Filter = Form3.LoadFilter(0)
  Case 3:
    Openbo.Filter = "*.thu"
    Openbo.DialogTitle = "Save AS"
    Openbo.ShowSave
    If Err.Number <> 32755 Then
     mov.SaveMove Openbo.Filename
    End If
    Openbo.DialogTitle = "Open Movie"
    Openbo.Filter = Form3.LoadFilter(0)
  Case 4:
    mov.UnloadMove
 End Select
End Sub
Sub ChSound(index As Integer)
 Select Case index
  Case 0:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = 0
  Case 1:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = 10000
  Case 2:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = -10000
  Case 3:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form1.fl.SoundEff1 = True
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = 0
   TimerSoW.Enabled = True
  Case 4:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = 0
   TimerSoDt.Enabled = True
  Case 5:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = 0
   TimerSoDo.Enabled = True
  Case 6:
   Form1.TimerSoDo.Enabled = False
   Form1.TimerSoDt.Enabled = False
   Form1.TimerSoW.Enabled = False
   Form1.TimerSo3d.Enabled = False
   Form2.x1.Volume = fl.RestVol
   Form2.x1.Balance = 0
   TimerSo3d.Enabled = True
  Case 7:
    Form31.Show
 End Select
End Sub
Sub ChRate(index As Integer)
 Dim s As String
 On Error Resume Next
 Select Case index
  Case 1:
   Form2.x1.Rate = 0.1
  Case 2:
   Form2.x1.Rate = 0.25
  Case 3:
   Form2.x1.Rate = 0.5
  Case 4:
   Form2.x1.Rate = 0.75
  Case 5:
   Form2.x1.Rate = 1#
  Case 6:
   Form2.x1.Rate = 1.25
  Case 7:
   Form2.x1.Rate = 1.5
  Case 8:
   Form2.x1.Rate = 1.75
  Case 9:
   Form2.x1.Rate = 2#
  Case 10:
   s = "Enter Your Custom Rate:" + vbCr + "Range (0 To 2)"
   s = InputBox(s, "Rate")
   If s <> "" Then
   Form2.x1.Rate = CLng(s)
   End If
 End Select
End Sub
Sub OpenMenu(index As Integer)
 Select Case index
  Case 0:
   ope
  Case 1:
   OpenVCD
  Case 2:
   OpenURL
  Case 3:
   Form3.Show
  Case 4:
   Close1
 End Select
End Sub
Sub Othermenu(index As Integer)
 Select Case index
  Case 0:
   PrevTrack
  Case 1:
   Play
  Case 2:
   Pause
  Case 3:
   Stop1
  Case 4:
   PrevTrack
  Case 5:
   PrevStep 10
  Case 6:
   NextStep 10
 End Select
End Sub
Sub PlayLisPl(opt As Integer)
  On Error GoTo exitfn
  Select Case opt
  Case 0:
    If Form3.List1.ListIndex > Form3.List1.ListCount - 2 Then
     Form3.List1.ListIndex = -1
    End If
     Form3.List1.ListIndex = Form3.List1.ListIndex + 1
     fl.Plflag = True
     Form2.openmedia (Form3.List1.Text)
 Case 1:
   Form3.List1.ListIndex = Rnd * (Form3.List1.ListCount - 2)
   fl.Plflag = True
   Form2.openmedia (Form3.List1.Text)
 Case 2:
   fl.Plflag = True
   Form2.openmedia (Form2.x1.Filename)
 End Select
exitfn:
End Sub
Sub UnloadPre()
 On Error Resume Next
 Open App.Path + "\Logo.cfg" For Output As #1
 Write #1, fl.Logopa
 Write #1, fl.Lo
 Write #1, fl.Stp
 Write #1, fl.Etp
 Write #1, fl.Ful
 Write #1, fl.Au
 Write #1, fl.CDPath
 Write #1, fl.Re
 Write #1, Form8.Dir1.Path
 Write #1, Form8.Drive1.Drive
 Write #1, Form1.Top
 Write #1, Form1.Left
 Write #1, Left(Form2.x1.Filename, InStrRev(Form2.x1.Filename, "\"))
 Write #1, fl.Tis
 Write #1, Form4.V1.Value
 Write #1, fl.Left3D
 Write #1, fl.Right3D
 Write #1, fl.Swap
 Close #1
 Form3.M3usave (App.Path + "\default.m3u")
 Form3.remove 2
 End Sub
Sub PreLoad()
 On Error Resume Next
 Dim t As Variant
 Open App.Path + "\Logo.cfg" For Input As #1
 t = 0
 Input #1, t
  If t = 0 Then
   fl.Logopa = ""
  Else
   fl.Logopa = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Lo = False
  Else
   fl.Lo = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Stp = 0
  Else
   fl.Stp = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Etp = 0
  Else
   fl.Etp = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
    fl.Ful = False
  Else
    fl.Ful = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Au = False
  Else
   fl.Au = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.CDPath = "d:"
  Else
   fl.CDPath = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Re = False
  Else
   fl.Re = t
  End If
 t = 0
 Input #1, t
  If t = 0 Then
   Form8.Dir1.Path = App.Path
   Form8.File1.Path = App.Path
  Else
   Form8.Dir1.Path = t
   Form8.File1.Path = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   Form8.Drive1.Drive = Left(App.Path, 2)
  Else
   Form8.Drive1.Drive = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   Form1.Top = (Screen.Height / 2) - (Form1.Height / 2)
   Else
   Form1.Top = CSng(t)
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   Form1.Left = (Screen.Width / 2) - (Form1.Width / 2)
  Else
   Form2.Left = CSng(t)
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   Openbo.Filename = ""
  Else
   Openbo.Filename = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
    fl.Tis = 0
  Else
    fl.Tis = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   Form2.x1.Volume = 0
   Form4.V1.Value = 0
  Else
   Form2.x1.Volume = t * -1
   Form4.V1.Value = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Left3D = (Form1.Width - 200) / 2
  Else
   fl.Left3D = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   fl.Right3D = (Form1.Height - 200) / 2
  Else
   fl.Right3D = t
  End If
  t = 0
 Input #1, t
  If t = 0 Then
   Form1.fl.Swap = False
  Else
   Form1.fl.Swap = True
  End If
 Close #1
End Sub
Sub Wave()
    If Form2.x1.Balance > 2500 Then
     fl.SoundEff = False
    ElseIf Form2.x1.Balance < -2500 Then
     fl.SoundEff = True
    End If
    If fl.SoundEff = True Then
     Form2.x1.Balance = Form2.x1.Balance + 50
    Else
     Form2.x1.Balance = Form2.x1.Balance - 50
    End If
End Sub
Sub Dts()
   If Form2.x1.Balance = 0 Then
    Form2.x1.Balance = -10000
   ElseIf Form2.x1.Balance < 0 Then
    Form2.x1.Balance = 10000
   Else
    Form2.x1.Balance = 0
   End If
End Sub
Sub Dolpy()
   If Form2.x1.Volume < -1500 Then
    fl.SoundEff = False
   ElseIf Form2.x1.Volume > -50 Then
    fl.SoundEff = True
   End If
   If fl.SoundEff = True Then
    Form2.x1.Volume = Form2.x1.Volume - 50
   Else
    Form2.x1.Volume = Form2.x1.Volume + 50
   End If
End Sub
Private Sub TimerSo3d_Timer()
 Su3d
End Sub
Private Sub TimerSoDo_Timer()
 Dolpy
End Sub
Private Sub TimerSoDt_Timer()
 Dts
End Sub
Private Sub TimerSoW_Timer()
 Wave
End Sub
Function Time1(t1 As Long) As String
 If t1 > 0 Then
 Dim ss, mm, hh, ss1, MM1, hh1 As Long
 ss = t1 Mod 60
 t1 = t1 \ 60
 mm = t1 Mod 60
 t1 = t1 \ 60
 hh = t1
 Time1 = Format(hh, "00") + ":" + Format(mm, "00") + ":" + Format(ss, "00")
 End If
End Function
Sub Close1()
 If TimerFull = True Then
    TimerFull = False
    Form2.x1.DisplaySize = mpDefaultSize
    Form2.Frame1.Height = Form2.x1.Height + 315
    Form2.Frame1.Width = Form2.x1.Width + 215
    Form2.Height = Form2.x1.Height + 800
    Form2.Width = Form2.x1.Width + 450
 End If
 If LCase(Left(Form3.List1.Text, 2)) = fl.CDPath Then
  Form3.remove 2
 End If
 Unload Form2
 Form1.fl.Lo1 = False
 Form1.fl.Plflag = False
 Form1.fl.PlCount = Form3.List1.ListCount
 If Form1.mov.State = True Then
   Form1.fl.Lo1 = False
   Form1.mov.UnloadMove
 End If
End Sub
Sub Mute1()
 If Form2.x1.Mute = True Then
    Form2.x1.Mute = False
    Form4.Mu.BackColor = 65280
 Else
    Form2.x1.Mute = True
    Form4.Mu.BackColor = 255
 End If
End Sub
Sub Su3d()
    If Form2.x1.Balance < -2500 Then
     fl.SoundEff = True
    End If
    If Form2.x1.Balance > 2500 Then
     fl.SoundEff = False
    End If
    If fl.SoundEff = True Then
     Form2.x1.Balance = Form2.x1.Balance + 50
    Else
     Form2.x1.Balance = Form2.x1.Balance - 50
    End If
   If Form2.x1.Volume < -2500 Then
    fl.SoundEff1 = False
   End If
   If Form2.x1.Volume > -50 Then
    fl.SoundEff1 = True
   End If
   If fl.SoundEff1 = True Then
    Form2.x1.Volume = Form2.x1.Volume - 50
   Else
    Form2.x1.Volume = Form2.x1.Volume + 50
   End If
End Sub
Public Sub DisName()
  Form1.Label3.Caption = Right(Form2.x1.Filename, Len(Form2.x1.Filename) - InStrRev(Form2.x1.Filename, "\"))
  If Len(Form1.Label3.Caption) > 36 Then Form1.Label3.Caption = Left(Form1.Label3.Caption, 33) + "..."
End Sub
