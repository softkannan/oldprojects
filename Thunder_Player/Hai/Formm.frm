VERSION 5.00
Object = "{C1A8AF28-1257-101B-8FB0-0020AF039CA3}#1.1#0"; "MCI32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{84D1EEB7-556A-11D1-8118-B7B45FE6C56E}#1.0#0"; "LIBBTN.OCX"
Object = "{23D221AC-C35F-4EF7-AFEE-F350F848026A}#1.0#0"; "SLIDERTHU.OCX"
Begin VB.Form Formm 
   Appearance      =   0  'Flat
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Thunder Player"
   ClientHeight    =   990
   ClientLeft      =   105
   ClientTop       =   105
   ClientWidth     =   3735
   ControlBox      =   0   'False
   Icon            =   "Formm.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form7"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   990
   ScaleWidth      =   3735
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin Insert_Project_Name.SoftBttn SoftBttn12 
      Height          =   255
      Left            =   2280
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":030A
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin SlderTwo.Slider P11 
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   335
      Width           =   3615
      _ExtentX        =   6376
      _ExtentY        =   450
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn11 
      Height          =   255
      Left            =   2040
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":065C
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.Timer Find12 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   3120
      Top             =   120
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn10 
      Height          =   255
      Left            =   2760
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   615
      Visible         =   0   'False
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":0BAE
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn9 
      Height          =   255
      Left            =   2520
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   615
      Visible         =   0   'False
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":1100
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.FileListBox CDp 
      Height          =   285
      Left            =   2760
      TabIndex        =   9
      Top             =   120
      Visible         =   0   'False
      Width           =   345
   End
   Begin VB.Timer TimerSli 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1200
      Top             =   120
   End
   Begin MCI.MMControl MM1 
      Height          =   300
      Left            =   3600
      TabIndex        =   8
      Top             =   480
      Width           =   60
      _ExtentX        =   106
      _ExtentY        =   529
      _Version        =   393216
      Frames          =   10
      BorderStyle     =   0
      PrevEnabled     =   -1  'True
      NextEnabled     =   -1  'True
      PlayEnabled     =   -1  'True
      PauseEnabled    =   -1  'True
      BackEnabled     =   -1  'True
      StepEnabled     =   -1  'True
      StopEnabled     =   -1  'True
      RecordEnabled   =   -1  'True
      EjectEnabled    =   -1  'True
      Silent          =   -1  'True
      PrevVisible     =   0   'False
      NextVisible     =   0   'False
      PlayVisible     =   0   'False
      PauseVisible    =   0   'False
      BackVisible     =   0   'False
      StepVisible     =   0   'False
      StopVisible     =   0   'False
      RecordVisible   =   0   'False
      EjectVisible    =   0   'False
      Shareable       =   -1  'True
      OLEDropMode     =   1
      DeviceType      =   ""
      FileName        =   ""
   End
   Begin MSComDlg.CommonDialog OpenBox 
      Left            =   480
      Top             =   120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
      DefaultExt      =   "*.wav"
      DialogTitle     =   "Open Media"
      Filter          =   "All Suported Files|*.dat;*.avi;*.mp3;*.mpg;*.mov;*.wav;*.mid;*.midi;|All Files|*.*"
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn8 
      Height          =   255
      Left            =   3240
      TabIndex        =   7
      TabStop         =   0   'False
      ToolTipText     =   "Open"
      Top             =   615
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":1652
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn7 
      Height          =   255
      Left            =   1800
      TabIndex        =   6
      TabStop         =   0   'False
      ToolTipText     =   "Forward"
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":1BA4
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn6 
      Height          =   255
      Left            =   1560
      TabIndex        =   5
      TabStop         =   0   'False
      ToolTipText     =   "Rewind"
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":20F6
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn5 
      Height          =   255
      Left            =   1320
      TabIndex        =   4
      TabStop         =   0   'False
      ToolTipText     =   "Frame Forward"
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":2648
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn4 
      Height          =   255
      Left            =   1080
      TabIndex        =   3
      TabStop         =   0   'False
      ToolTipText     =   "Stop"
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":2B9A
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn3 
      Height          =   255
      Left            =   840
      TabIndex        =   2
      TabStop         =   0   'False
      ToolTipText     =   "Pause"
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":30EC
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn2 
      Height          =   255
      Left            =   600
      TabIndex        =   1
      TabStop         =   0   'False
      ToolTipText     =   "Play"
      Top             =   600
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":363E
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn1 
      Height          =   255
      Left            =   360
      TabIndex        =   0
      TabStop         =   0   'False
      ToolTipText     =   "Frame Rewind"
      Top             =   620
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   450
      Picture         =   "Formm.frx":3B90
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Thunder"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Left            =   720
      TabIndex        =   15
      Top             =   120
      Width           =   2415
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H0000FF00&
      BorderWidth     =   3
      Height          =   975
      Left            =   0
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   3720
   End
End
Attribute VB_Name = "Formm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" _
    (ByVal Hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, _
    ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Plfl As Boolean
Public Cd1 As Boolean
Public h As Variant
Public full As Boolean
Private Ope1 As Boolean
Private Count1 As Long
Private Zo As Single
Private recordflag As Boolean
Dim r11  As RECT

Private Sub Find12_Timer()
 Dim t As Long
 If Count1 < 11 Then
 h = GetForegroundWindow()
 Count1 = Count1 + 1
 Else
 If (h = Formm.Hwnd) Or (h = MM1.Hwnd) Or (h = Form1.Hwnd) Or (h = Form2.Hwnd) Or (h = Form3.Hwnd) Or (h = Form4.Hwnd) Or (h = Form5.Hwnd) Or (h = Form6.Hwnd) Then
   h = 0
   MsgBox "Mci Window Not Finded", 0, "Result"
 End If
 If h Then
 Find12.Enabled = False
 t = GetWindowRect(h, r11)
 MsgBox "Mci Window Finded", 0, "Result"
 End If
 End If
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 KeyRes KeyCode, Shift
End Sub
Private Sub Form_Load()
 recordflag = False
 Sizewin1 Me.Hwnd, 20, 20
 Formm.Top = Form1.Top
 Formm.Left = Form1.Left
 Cd1 = False
 Zo = 0
 Plfl = False
 ReadSy
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  Form1.fl.top1 = y
  Form1.fl.left1 = x
 Else
 MouseRes Button, x, y
 End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Drag1 Button, x, y
 If MM1.Filename <> "" Then
  Label1.Caption = Right(MM1.Filename, Len(MM1.Filename) - InStrRev(MM1.Filename, "\"))
 Else
  Label1.Caption = "Thunder"
 End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
 Unload Form7
 Close1
End Sub

Private Sub Label1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
If Button = 1 Then
   Form1.fl.top1 = y
   Form1.fl.left1 = x
 Else
  MouseRes Button, x, y
 End If
End Sub

Private Sub Label1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Drag1 Button, x, y
 If MM1.Filename <> "" Then
  Label1.Caption = Right(MM1.Filename, Len(MM1.Filename) - InStrRev(MM1.Filename, "\"))
 Else
  Label1.Caption = "Thunder"
 End If
End Sub

Private Sub MM1_Done(NotifyCode As Integer)
 If Ope1 = True Then
  Find1 False
 End If
End Sub
Private Sub P11_Scroll()
 MM1.From = P11.Value
 Play
End Sub
Private Sub SoftBttn1_Click()
 StepFrame False
End Sub
Private Sub SoftBttn1_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "FrameRewind"
End Sub
Private Sub SoftBttn10_Click()
 Nex1 True
End Sub

Private Sub SoftBttn10_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "Next Track"
End Sub

Private Sub SoftBttn11_Click()
 If Zo > 5 Then
    Zo = 0
 ElseIf Zo = 3 Then
    Zo = Zo + 1
 End If
   Resize Zo
   Zo = Zo + 1
End Sub

Private Sub SoftBttn11_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Label1.Caption = "Zoom"
End Sub

Private Sub SoftBttn12_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  RecordButtn
 Else
  PopupMenu Form2.RecordM
 End If
End Sub

Private Sub SoftBttn12_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Label1.Caption = "Record"
End Sub

Private Sub SoftBttn2_Click()
 play1
End Sub

Private Sub SoftBttn2_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "Play"
End Sub

Private Sub SoftBttn3_Click()
 Pause
End Sub

Private Sub SoftBttn3_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "Pause"
End Sub

Private Sub SoftBttn4_Click()
 Stop1
End Sub

Private Sub SoftBttn4_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "Stop"
End Sub

Private Sub SoftBttn5_Click()
 StepFrame True
End Sub

Private Sub SoftBttn5_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Label1.Caption = "Frame Forward"
End Sub
Private Sub SoftBttn6_Click()
 Step False
 MM1.Command = "play"
End Sub

Private Sub SoftBttn6_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Label1.Caption = "Rewind"
End Sub

Private Sub SoftBttn7_Click()
 Step True
 MM1.Command = "play"
End Sub

Private Sub SoftBttn7_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
 Label1.Caption = "Forward"
End Sub

Private Sub SoftBttn8_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 1 Then
  ope
 Else
  Form2.Openq(4).Visible = False
  Form2.Openq(5).Visible = False
  Form2.Openq(6).Visible = False
  Form2.Openq(7).Visible = False
   PopupMenu Form2.Openmci
  Form2.Openq(4).Visible = True
  Form2.Openq(5).Visible = True
  Form2.Openq(6).Visible = True
  Form2.Openq(7).Visible = True
 End If
End Sub
Sub ope(Optional Filename As String, Optional de As String)
 Dim index As Integer
  On Error GoTo error1
 If Filename = "" Then
  Openbox.ShowOpen
  If Err.Number <> 32755 Then
   Close1
   Filename = Openbox.Filename
  End If
 End If
 MM1.Command = "stop"
 MM1.Command = "Close"
 MM1.TimeFormat = 0
 MM1.Filename = Filename
 If de <> "" Then
  MM1.DeviceType = de
 Else
  MM1.DeviceType = ""
 End If
 MM1.Command = "Open"
 MM1.Command = "Play"
 MM1.Command = "Pause"
 MM1.TimeFormat = 0
 P11.Max = MM1.Length
 TimerSli.Enabled = True
 Ope1 = True
 Plfl = False
Exit Sub
error1:
 If LCase(MM1.DeviceType) <> "mpegvideo" Then
  ope MM1.Filename, "MPEGVideo"
 ElseIf Err.Number <> 32755 Then
  DMssBox
 End If
End Sub
Sub Play()
 MM1.Command = "play"
End Sub
Sub play1()
If Plfl = False Then
  MM1.Command = "Play"
  Plfl = True
 Else
  MM1.Command = "pause"
  Plfl = False
 End If
End Sub
Sub Pause()
 MM1.Command = "Pause"
End Sub
Sub Stop1()
MM1.Command = "Stop"
P11.Value = 0
If recordflag = True Then
MM1.Wait = True
MM1.Command = "Save"
MM1.Command = "Close"
Close1
End If
End Sub

Private Sub SoftBttn8_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "Open"
End Sub

Private Sub SoftBttn9_Click()
 Nex1 False
End Sub

Private Sub SoftBttn9_MouseMove(Button As Integer, Shift As Integer, x As Single, y As Single)
Label1.Caption = "Previous Track"
End Sub

Private Sub TimerSli_Timer()
 On Error Resume Next
   P11.Value = MM1.Position
   CheckEstream
End Sub
Function StepFrame(op As Boolean)
 If MM1.DeviceType <> "cdaudio" Then
  If op = True Then
    MM1.TimeFormat = 3
    MM1.Frames = 1
    MM1.Command = "Step"
    MM1.TimeFormat = 0
  Else
    MM1.TimeFormat = 3
    MM1.Frames = 1
    MM1.Command = "Back"
    MM1.TimeFormat = 0
  End If
 End If
End Function
Function Step(op As Boolean)
If MM1.DeviceType = "cdaudio" Then
 If op = True Then
  MM1.TimeFormat = mciFormatTmsf
   MM1.Command = "stop"
   MM1.From = MM1.Position + 20
   MM1.Command = "play"
 Else
  MM1.TimeFormat = mciFormatTmsf
  MM1.Command = "stop"
  MM1.From = MM1.Position - 20
  MM1.Command = "play"
 End If
Else
 If op = True Then
  MM1.TimeFormat = 0
  MM1.Frames = 100
  MM1.Command = "Step"
 Else
  MM1.TimeFormat = 0
  MM1.Frames = 100
  MM1.Command = "Back"
 End If
End If
End Function
Function MenuOpe(index As Integer)
 On Error Resume Next
 Select Case index
  Case 0:
   ope
  Case 2:
   OpenVCD
  Case 1:
   OpenACD
  Case 3:
   Form7.Show
  Case 5:
    Close1
  Case 6:
    ShellExecute 0, "Open", "sndvol32.exe", "", "", vbNormalFocus
  Case 7:
        MsgBox "It is To Find The Which Window Is The MCI Window." + vbCr + vbCr + " So Please Click The Mci Window Within 5 Seconds", 0, "Find"
        Find1 True
   End Select
End Function
Sub CheckEstream()
 If MM1.Position >= MM1.Length Then
  If Cd1 = True Then
   CDp.ListIndex = CDp.ListIndex + 1
   If CDp.ListIndex > CDp.ListCount Then
   CDp.ListIndex = 1
   End If
   ope GetP
   MM1.Command = "play"
  End If
 End If
End Sub
Function GetP() As String
  If Right(CDp.Path, 1) = "\" Then
   GetP = CDp.Path + CDp.Filename
  Else
   GetP = CDp.Path + "\" + CDp.Filename
  End If
End Function
Function Nex1(opt As Boolean)
 If Cd1 = True Then
  If opt = True Then
   CDp.ListIndex = CDp.ListIndex + 1
    If CDp.ListIndex > CDp.ListCount Then
     CDp.ListIndex = 1
    End If
    ope GetP
    MM1.Command = "play"
  ElseIf opt = False Then
   CDp.ListIndex = CDp.ListIndex - 1
   If CDp.ListIndex < 1 Then
    CDp.ListIndex = CDp.ListCount
   End If
    ope GetP
    MM1.Command = "play"
  End If
ElseIf MM1.DeviceType = "cdaudio" Then
 If opt = True Then
    MM1.Command = "stop"
    MM1.Command = "Seek"
    MM1.Command = "next"
    MM1.Command = "play"
  Else
    MM1.Command = "stop"
    MM1.Command = "Seek"
    MM1.Command = "prev"
    MM1.Command = "play"
  End If
End If
End Function
Sub Close1()
 Ope1 = False
 Formm.MM1.Command = "stop"
 MM1.DeviceType = ""
 Formm.MM1.Command = "close"
 TimerSli.Enabled = False
 Cd1 = False
 SoftBttn10.Visible = False
 SoftBttn9.Visible = False
End Sub
Function MouseRes(ByVal Button As Single, ByVal x As Single, ByVal y As Single)
 If Button = 1 Then
   Form1.fl.top1 = y
  Form1.fl.left1 = x
 Else
  PopupMenu Form2.Openmci
 End If
End Function
Sub OpenVCD()
On Error GoTo last
   Close1
   CDp.Pattern = "*.dat"
   CDp.Path = Form1.fl.CDPath + "\mpegav"
   CDp.ListIndex = 0
   ope GetP, "MPEGVideo"
   Cd1 = True
   MM1.Command = "play"
   SoftBttn10.Visible = True
   SoftBttn9.Visible = True
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
Sub OpenACD()
On Error Resume Next
   Close1
   MM1.Wait = True
   MM1.UpdateInterval = 0
   MM1.Command = "close"
   MM1.DeviceType = "cdaudio"
   MM1.Command = "open"
   MM1.TimeFormat = 0
   P11.Max = MM1.Length
   MM1.Command = "play"
   TimerSli.Enabled = True
   SoftBttn10.Visible = True
   SoftBttn9.Visible = True
End Sub
Function Drag1(ByVal Button As Single, ByVal x As Single, ByVal y As Single)
On Error Resume Next
  x = x - Form1.fl.left1
  y = y - Form1.fl.top1
 If Button = 1 Then
  Move x + Formm.Left, y + Formm.Top
  Form1.Move Formm.Left, Formm.Top + Formm.Height
  If Form1.fl.ct2 = False Then
   Form4.Move Form1.Left, Form1.Top + Form1.Height
  Else
   Form4.Move Form1.Left, Form1.Top
  End If
   Form7.Top = Form1.Top - Form7.Height
   Form7.Left = Form1.Left + Form1.Width
 End If
End Function
Sub Resize(ByVal opt As Single)
 On Error Resume Next
 Dim Style As Long
 Dim cx As Long
 Dim retVal As Boolean
 Dim cy As Long
 cx = GetSystemMetrics(SM_CXSCREEN)
 cy = GetSystemMetrics(SM_CYSCREEN)
 If h Then
  Select Case (opt)
   Case 0:
    full = False
    cy = GetSystemMetrics(SM_CYMAXIMIZED)
    retVal = SetWindowPos(h, -2, 0, 0, cx, cy, SWP_SHOWWINDOW)
    Me.SetFocus
   Case 1:
     full = False
     retVal = SetWindowPos(h, -2, cx / 4, cy / 4, cx / 2, cy / 2, SWP_SHOWWINDOW)
     Me.SetFocus
   Case 2:
     full = False
     retVal = SetWindowPos(h, -2, (cx - (cx / 3)) / 2, (cy - (cy / 3)) / 2, cx / 3, cy / 3, SWP_SHOWWINDOW)
     Me.SetFocus
   Case 3:
     full = True
     retVal = SetWindowPos(h, HWND_TOPMOST, 0, 0, cx, cy, SWP_SHOWWINDOW)
   Case 4:
     full = False
     retVal = SetWindowPos(h, -2, (cx - r11.Right) / 2, (cy - r11.Bottom) / 2, r11.Right, r11.Bottom, SWP_SHOWWINDOW)
     Me.SetFocus
   Case 5:
     full = False
     retVal = SetWindowPos(h, -2, (cx - (cx / 1.2)) / 2, (cy - (cy / 1.2)) / 2, cx / 1.2, cy / 1.2, SWP_SHOWWINDOW)
     Me.SetFocus
   End Select
   If retVal = False Then
    MsgBox "Zoom Error: Zooming Is Failed", 0, "Error"
   End If
 Else
  MsgBox "You Are Not Using The Windows MCI Or Xing MCI Driver 3.30" + vbCr + "So Manualy Find The MCI Window By Clicking Find Menu Before Applying Zoom"
 End If
End Sub
Sub Find1(opt As Boolean)
  Dim t As Long
  h = 0
  If FindWindow(vbNullString, MM1.Filename) Then
     h = FindWindow(vbNullString, MM1.Filename)
  ElseIf FindWindow(vbNullString, Right(MM1.Filename, Len(MM1.Filename) - InStrRev(MM1.Filename, "\"))) Then
     h = FindWindow(vbNullString, Right(MM1.Filename, Len(MM1.Filename) - InStrRev(MM1.Filename, "\")))
  Else
    If opt = True Then
     Me.SetFocus
     Find12.Enabled = True
     Count1 = 0
     End If
  End If
     t = GetWindowRect(h, r11)
End Sub
Sub KeyRes(ByVal KeyCode As Integer, ByVal Shift As Integer)
 Select Case (KeyCode)
  Case vbKeySpace:
   play1
  Case vbKeyN:
   Pause
  Case vbKeyB:
   Stop1
  Case vbKeyA:
   If Zo > 5 Then
    Zo = 0
   ElseIf Zo = 3 Then
    Zo = Zo + 1
   End If
   Resize Zo
   Zo = Zo + 1
  Case vbKeyF:
    Resize 3
  Case vbKeyEscape:
    Resize 1
  Case vbKeyC:
    Nex1 False
  Case vbKeyV:
    Nex1 True
  Case vbKeyZ:
   Step False
   MM1.Command = "play"
  Case vbKeyX:
   Step True
   MM1.Command = "play"
  Case vbKeyO:
   ope
  Case vbKeyF1:
   Form1.MainMenu 0
  Case vbKeyQ:
   Form1.end1
  Case vbKeyD:
   OpenVCD
  Case vbKeyG:
   OpenACD
  Case vbKeyH:
   Form7.Show
  Case vbKeyF2:
   Form6.Show
  Case vbKeyF3:
   Form5.Show
  Case vbKey0 To vbKey9:
   MM1.From = MM1.Length - ((MM1.Length / 9) * (vbKey9 - KeyCode))
   Play
 End Select
End Sub
Sub DMssBox()
    Dim MSG As String
    Select Case Err
        Case conMCIErrCannotLoadDriver
            MSG = "Error load media device driver."
        Case conMCIErrDeviceOpen
            MSG = "The device is not open or is not known."
        Case conMCIErrInvalidDeviceID
            MSG = "Invalid device id."
        Case conMCIErrInvalidFile
            MSG = "Invalid filename."
        Case conMCIErrUnsupportedFunction
            MSG = "Action not available for this device."
        Case Else
            MSG = "Unknown error (" + Err.Description + ")."
    End Select

    MsgBox MSG, 48, "Error"
End Sub
Function WindowsDirectory() As String
Dim WinPath As String
    WinPath = String(145, Chr(0))
    WindowsDirectory = Left(WinPath, GetWindowsDirectory(WinPath, 145))
End Function
Sub ReadSy()
  On Error Resume Next
  Dim s As String
  Dim index As Long
  Dim myVer As MYVERSION
  myVer = WindowsVersion()
  Form7.Dev1.ListIndex = 0
    
  If myVer.lExtraInfo <> VER_PLATFORM_WIN32_NT Then
    Open WindowsDirectory + "\system.ini" For Input As #1
    While Not EOF(1)
        Input #1, s
        index = 0
        If LCase(s) = "[mci]" Then
            While s <> ""
                Input #1, s
                Form7.Dev1.AddItem (Left(s, InStr(1, s, "=") - 1))
                index = index + 1
            Wend
        End If
    Wend
    Close #1
  Else
    Form7.Dev1.AddItem ("cdaudio")
    Form7.Dev1.AddItem ("sequencer")
    Form7.Dev1.AddItem ("waveaudio")
    Form7.Dev1.AddItem ("avivideo")
    Form7.Dev1.AddItem ("videodisc")
    Form7.Dev1.AddItem ("MPEGVideo")
  End If
  
End Sub
Sub Record1(s As String, d As String)
 Close1
 MM1.Notify = False
 MM1.Wait = True
 MM1.Shareable = False
 MM1.DeviceType = d
 MM1.Filename = s
 MM1.Command = "open"
 MM1.To = -1
 MM1.Wait = False
 MM1.Command = "record"
End Sub
Function OpenbyDevice(Devicet As String)
On Error Resume Next
If recordflag = False Then
 Formm.ope "", Devicet
Else
 recordflag = True
 Openbox.ShowSave
 If Err.Number <> 32755 Then
 Kill Openbox.Filename
 Record1 Openbox.Filename, Devicet
 Else
 recordflag = False
 End If
End If
End Function
Sub RecordButtn()
 On Error Resume Next
 recordflag = True
 Openbox.ShowSave
 If Err.Number <> 32755 Then
 Kill Openbox.Filename
 Record1 Openbox.Filename, "waveaudio"
 Else
 recordflag = False
 End If
End Sub
Sub RecordMenu(op As Integer)
 Select Case op
  Case 0:
   RecordButtn
  Case 1:
   recordflag = True
   Form7.Show
 End Select
End Sub
