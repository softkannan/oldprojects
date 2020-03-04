VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form5 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Options"
   ClientHeight    =   2865
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   FillStyle       =   0  'Solid
   Icon            =   "Options.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2865
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame3 
      Caption         =   "Player"
      Height          =   2775
      Left            =   1320
      TabIndex        =   11
      Top             =   0
      Width           =   3255
      Begin VB.Frame Frame4 
         Height          =   1455
         Left            =   120
         TabIndex        =   12
         Top             =   240
         Width           =   3015
         Begin VB.TextBox CDt 
            Height          =   285
            Left            =   2520
            TabIndex        =   17
            ToolTipText     =   "Give The CD-ROM Drive Letter(c:)"
            Top             =   960
            Width           =   375
         End
         Begin VB.CheckBox Auto 
            Caption         =   "AutoStart"
            Height          =   255
            Left            =   240
            TabIndex        =   15
            ToolTipText     =   "Auto Start"
            Top             =   960
            Width           =   1215
         End
         Begin VB.CheckBox Rep 
            Caption         =   "RepeatForever"
            Height          =   255
            Left            =   1440
            TabIndex        =   14
            ToolTipText     =   "Continus Loop"
            Top             =   360
            Width           =   1455
         End
         Begin VB.CheckBox full 
            Caption         =   "FullScreen"
            Height          =   255
            Left            =   240
            TabIndex        =   13
            ToolTipText     =   "Every Time Open With Fullscreen"
            Top             =   360
            Width           =   1095
         End
         Begin VB.Label CD 
            Caption         =   "CD Drive:"
            Height          =   255
            Left            =   1800
            TabIndex        =   16
            ToolTipText     =   "CD-ROM Path"
            Top             =   960
            Width           =   735
         End
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Logo"
      Height          =   2775
      Left            =   1320
      TabIndex        =   1
      Top             =   0
      Width           =   3255
      Begin VB.CheckBox Logo 
         Caption         =   "Logo Enable"
         Height          =   195
         Left            =   1080
         TabIndex        =   8
         ToolTipText     =   "Logo Enable Or Disable"
         Top             =   2280
         Width           =   1215
      End
      Begin VB.TextBox Eta 
         Height          =   285
         Left            =   1800
         TabIndex        =   6
         Text            =   "End"
         ToolTipText     =   "End Position"
         Top             =   1560
         Width           =   735
      End
      Begin VB.TextBox Sta 
         Height          =   285
         Left            =   480
         TabIndex        =   5
         Text            =   "Start"
         ToolTipText     =   "Starting Position Of Logo"
         Top             =   1560
         Width           =   735
      End
      Begin VB.CommandButton Openbox 
         Caption         =   "Browse"
         Height          =   255
         Left            =   2280
         TabIndex        =   3
         ToolTipText     =   "Search Logo File Path"
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox Path 
         Height          =   285
         Left            =   600
         TabIndex        =   2
         Text            =   "Path"
         ToolTipText     =   "Give Logo File Path"
         Top             =   450
         Width           =   1575
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Start End Position"
         Height          =   255
         Left            =   240
         TabIndex        =   7
         ToolTipText     =   "The Starting And Ending Seconds Of Logo"
         Top             =   1080
         Width           =   2775
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Path:"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         ToolTipText     =   "Logo Path"
         Top             =   480
         Width           =   495
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Setup"
      Height          =   2775
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   1095
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Player"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         TabIndex        =   10
         ToolTipText     =   "Option About Player Setting"
         Top             =   840
         Width           =   855
      End
      Begin VB.Label Label3 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "Logo"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         TabIndex        =   9
         ToolTipText     =   "Option About Logo Setting"
         Top             =   480
         Width           =   855
      End
   End
   Begin MSComDlg.CommonDialog Logoset 
      Left            =   120
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
      Filter          =   "AllFiles|*.*"
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub CDt_KeyDown(KeyCode As Integer, Shift As Integer)
If vbKeyEscape = KeyCode Then
  Unload Me
 End If
End Sub
Private Sub Eta_KeyDown(KeyCode As Integer, Shift As Integer)
If vbKeyEscape = KeyCode Then
  Unload Me
 End If
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 If vbKeyEscape = KeyCode Then
  Unload Me
 End If
End Sub
Private Sub Form_Load()
On Error Resume Next
 CDt.Text = Form1.fl.CDPath
 Logo.Value = BoolToI(Form1.fl.Lo)
 Path.Text = Form1.fl.Logopa
 Sta.Text = str(Form1.fl.Stp)
 Eta.Text = str(Form1.fl.Etp)
 full.Value = BoolToI(Form1.fl.Ful)
 Auto.Value = BoolToI(Form1.fl.Au)
 Rep.Value = BoolToI(Form1.fl.Re)
End Sub
Private Sub Form_Unload(Cancel As Integer)
On Error Resume Next
  Form1.fl.Lo = CBool(Logo.Value)
  Form1.fl.Logopa = Path.Text
  Form1.fl.Stp = CLng(Sta.Text)
  Form1.fl.Etp = CLng(Eta.Text)
  Form1.fl.Ful = CBool(full.Value)
  Form1.fl.Au = CBool(Auto.Value)
  Form1.fl.Re = CBool(Rep.Value)
  Form1.fl.CDPath = CDt.Text
  Cancel = 0
End Sub
Private Sub Label4_Click()
  Frame3.Visible = True
  Frame2.Visible = False
End Sub
Private Sub Label3_Click()
  Frame3.Visible = False
  Frame2.Visible = True
End Sub
Private Sub Openbox_Click()
 On Error Resume Next
 Logoset.ShowOpen
 If Err.Number <> 32755 Then
  Path.Text = Logoset.Filename
 End If
End Sub
Function BoolToI(E As Boolean) As Integer
 If E = True Then
  BoolToI = 1
 Else
  BoolToI = 0
 End If
End Function
Private Sub Path_KeyDown(KeyCode As Integer, Shift As Integer)
If vbKeyEscape = KeyCode Then
  Unload Me
 End If
End Sub
Private Sub Sta_KeyDown(KeyCode As Integer, Shift As Integer)
If vbKeyEscape = KeyCode Then
  Unload Me
 End If
End Sub
