VERSION 5.00
Begin VB.Form Form6 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Details..."
   ClientHeight    =   3210
   ClientLeft      =   3405
   ClientTop       =   1980
   ClientWidth     =   5370
   Icon            =   "Prop.frx":0000
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3210
   ScaleWidth      =   5370
   ShowInTaskbar   =   0   'False
   Begin VB.Timer TimerP 
      Interval        =   1000
      Left            =   1200
      Top             =   120
   End
   Begin VB.Frame Frame 
      Caption         =   "Statistics"
      Height          =   3135
      Index           =   2
      Left            =   1320
      TabIndex        =   20
      Top             =   0
      Visible         =   0   'False
      Width           =   3975
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   20
         Left            =   2040
         TabIndex        =   41
         Top             =   2520
         Width           =   1695
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   19
         Left            =   2040
         TabIndex        =   40
         Top             =   2160
         Width           =   1695
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   18
         Left            =   2040
         TabIndex        =   39
         Top             =   1800
         Width           =   1695
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   17
         Left            =   2040
         TabIndex        =   38
         Top             =   1440
         Width           =   1695
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   16
         Left            =   2040
         TabIndex        =   37
         Top             =   1080
         Width           =   1695
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   15
         Left            =   2040
         TabIndex        =   36
         Top             =   720
         Width           =   1695
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   14
         Left            =   2040
         TabIndex        =   35
         Top             =   360
         Width           =   1695
      End
      Begin VB.Label Label 
         Caption         =   "Quality                         :"
         Height          =   255
         Index           =   20
         Left            =   240
         TabIndex        =   48
         Top             =   2520
         Width           =   1935
      End
      Begin VB.Label Label 
         Caption         =   "Pockets Lost               :"
         Height          =   255
         Index           =   19
         Left            =   240
         TabIndex        =   47
         Top             =   2160
         Width           =   2055
      End
      Begin VB.Label Label 
         Caption         =   "Pockets Recovered    :"
         Height          =   255
         Index           =   18
         Left            =   240
         TabIndex        =   46
         Top             =   1800
         Width           =   1935
      End
      Begin VB.Label Label 
         Caption         =   "Pockets Received      :"
         Height          =   255
         Index           =   17
         Left            =   240
         TabIndex        =   45
         Top             =   1440
         Width           =   1695
      End
      Begin VB.Label Label 
         Caption         =   "BandWidth                  :"
         Height          =   255
         Index           =   16
         Left            =   240
         TabIndex        =   44
         Top             =   1080
         Width           =   1815
      End
      Begin VB.Label Label 
         Caption         =   "Error Correction           :"
         Height          =   255
         Index           =   15
         Left            =   240
         TabIndex        =   43
         Top             =   720
         Width           =   1815
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "Protocal                      :"
         Height          =   255
         Index           =   14
         Left            =   240
         TabIndex        =   42
         Top             =   360
         Width           =   1815
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Content"
      Height          =   3135
      Index           =   1
      Left            =   1320
      TabIndex        =   19
      Top             =   0
      Visible         =   0   'False
      Width           =   3975
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   13
         Left            =   1560
         TabIndex        =   27
         Top             =   2520
         Width           =   2175
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   12
         Left            =   1560
         TabIndex        =   26
         Top             =   2160
         Width           =   2175
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   11
         Left            =   1560
         TabIndex        =   25
         Top             =   1800
         Width           =   2175
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   10
         Left            =   1560
         TabIndex        =   24
         Top             =   1440
         Width           =   2175
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   9
         Left            =   1560
         TabIndex        =   23
         Top             =   1080
         Width           =   2175
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   8
         Left            =   1560
         TabIndex        =   22
         Top             =   720
         Width           =   2175
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   7
         Left            =   1560
         TabIndex        =   21
         Top             =   360
         Width           =   2175
      End
      Begin VB.Label Label 
         Caption         =   "CurrentPosition  :"
         Height          =   255
         Index           =   13
         Left            =   240
         TabIndex        =   34
         Top             =   2520
         Width           =   1815
      End
      Begin VB.Label Label 
         Caption         =   "Rate                  :"
         Height          =   255
         Index           =   12
         Left            =   240
         TabIndex        =   33
         Top             =   2160
         Width           =   1815
      End
      Begin VB.Label Label 
         Caption         =   "Description        :"
         Height          =   255
         Index           =   11
         Left            =   240
         TabIndex        =   32
         Top             =   1800
         Width           =   1935
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "Ratting              :"
         Height          =   255
         Index           =   7
         Left            =   240
         TabIndex        =   31
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label 
         Caption         =   "Copyright           :"
         Height          =   255
         Index           =   10
         Left            =   240
         TabIndex        =   30
         Top             =   1440
         Width           =   1935
      End
      Begin VB.Label Label 
         Caption         =   "Author               :"
         Height          =   255
         Index           =   9
         Left            =   240
         TabIndex        =   29
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label Label 
         Caption         =   "Title                   :"
         Height          =   255
         Index           =   8
         Left            =   240
         TabIndex        =   28
         Top             =   720
         Width           =   1935
      End
   End
   Begin VB.Frame Frame 
      Caption         =   "Movie"
      Height          =   3135
      Index           =   0
      Left            =   1320
      TabIndex        =   1
      Top             =   0
      Width           =   3975
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   6
         Left            =   1320
         TabIndex        =   11
         Top             =   2520
         Width           =   2415
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   5
         Left            =   1320
         TabIndex        =   10
         Top             =   2160
         Width           =   2415
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   4
         Left            =   1320
         TabIndex        =   9
         Top             =   1800
         Width           =   2415
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   3
         Left            =   1320
         TabIndex        =   8
         Top             =   1440
         Width           =   2415
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   2
         Left            =   1320
         TabIndex        =   7
         Top             =   1080
         Width           =   2415
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   1
         Left            =   1320
         TabIndex        =   6
         Top             =   720
         Width           =   2415
      End
      Begin VB.TextBox Text 
         Alignment       =   2  'Center
         BackColor       =   &H80000004&
         Enabled         =   0   'False
         Height          =   285
         Index           =   0
         Left            =   1320
         TabIndex        =   5
         Top             =   360
         Width           =   2415
      End
      Begin VB.Label Label 
         Caption         =   "Length           :"
         Height          =   255
         Index           =   6
         Left            =   240
         TabIndex        =   18
         Top             =   2520
         Width           =   1095
      End
      Begin VB.Label Label 
         Caption         =   "CreationDate :"
         Height          =   255
         Index           =   5
         Left            =   240
         TabIndex        =   17
         Top             =   2160
         Width           =   1095
      End
      Begin VB.Label Label 
         Caption         =   "MediaType    :"
         Height          =   255
         Index           =   4
         Left            =   240
         TabIndex        =   16
         Top             =   1800
         Width           =   1095
      End
      Begin VB.Label Label 
         Caption         =   "Location        :"
         Height          =   255
         Index           =   3
         Left            =   240
         TabIndex        =   15
         Top             =   1440
         Width           =   1095
      End
      Begin VB.Label Label 
         Caption         =   "File Name      :"
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   14
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label Label 
         Caption         =   "Net Speed     :"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   13
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label Label 
         BackStyle       =   0  'Transparent
         Caption         =   "Size               :"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   12
         Top             =   360
         Width           =   1095
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Select"
      Height          =   3135
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   975
      Begin VB.Label LabelSE3 
         BackStyle       =   0  'Transparent
         Caption         =   "Statistics"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   2400
         Width           =   735
      End
      Begin VB.Label LabelSE2 
         BackStyle       =   0  'Transparent
         Caption         =   "Content Properties"
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label LabelSE1 
         BackStyle       =   0  'Transparent
         Caption         =   "Media      Properties"
         ForeColor       =   &H00FF0000&
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   735
      End
   End
End
Attribute VB_Name = "Form6"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 If vbKeyEscape = KeyCode Then
  Unload Me
 End If
End Sub
Private Sub Form_Load()
 LoadDetails
End Sub
Private Sub LabelSE1_Click()
 Frame(0).Visible = False
 Frame(1).Visible = False
 Frame(2).Visible = False
 Frame(0).Visible = True
End Sub
Private Sub LabelSE2_Click()
 Frame(0).Visible = False
 Frame(1).Visible = False
 Frame(2).Visible = False
 Frame(1).Visible = True
End Sub
Private Sub LabelSE3_Click()
 Frame(0).Visible = False
 Frame(1).Visible = False
 Frame(2).Visible = False
 Frame(2).Visible = True
End Sub
Sub LoadDetails()
 On Error Resume Next
 'Dim t As Long
 Dim s As String
 Text(0).Text = str(Form2.x1.ImageSourceWidth) + "  X " + str(Form2.x1.ImageSourceHeight)
 Label(0).ToolTipText = Text(0).Text
 Text(1).Text = str(Form2.x1.ConnectionSpeed \ 1000) + "  Kbs/Sec"
 Label(1).ToolTipText = Text(1).Text
 Text(2).Text = Right(Form2.x1.Filename, Len(Form2.x1.Filename) - InStrRev(Form2.x1.Filename, "\"))
 Label(2).ToolTipText = Text(2).Text
 Text(3).Text = Left(Form2.x1.Filename, InStrRev(Form2.x1.Filename, "\"))
 Label(3).ToolTipText = Text(3).Text
 If Form2.x1.ImageSourceHeight > 0 Then
  s = "Video"
 Else
  s = "Audio"
 End If
 Text(4).Text = s
 Label(4).ToolTipText = Text(4).Text
 Text(5).Text = Form2.x1.CreationDate
 Label(5).ToolTipText = Text(5).Text
 Text(6).Text = str(CLng(Form2.x1.Duration)) + " Sec"
 Label(6).ToolTipText = Text(6).Text
 s = Form2.x1.GetMediaInfoString(mpClipRating)
 If s = "" Then
  s = "UnKnown"
 End If
 Text(7).Text = s
 Label(7).ToolTipText = Text(7).Text
 s = ""
 s = Form2.x1.GetMediaInfoString(mpClipTitle)
 If s = "" Then
  s = "UnKnown"
 End If
 Text(8).Text = s
 Label(8).ToolTipText = Text(8).Text
 s = Form2.x1.GetMediaInfoString(mpClipAuthor)
 If s = "" Then
  s = "UnKnown"
 End If
 Text(9).Text = s
 Label(9).ToolTipText = Text(9).Text
 s = Form2.x1.GetMediaInfoString(mpClipCopyright)
 If s = "" Then
  s = "UnKnown"
 End If
 Text(10).Text = s
 Label(10).ToolTipText = Text(10).Text
 s = Form2.x1.GetMediaInfoString(mpClipDescription)
 If s = "" Then
  s = "UnKnown"
 End If
 Text(11).Text = s
 Label(11).ToolTipText = Text(11).Text
 Text(12).Text = str(Form2.x1.Rate) + " X"
 Label(12).ToolTipText = Text(12).Text
 Text(13).Text = str(CLng(Form2.x1.CurrentPosition)) + " Sec"
 Label(13).ToolTipText = Text(13).Text
 If Form2.x1.SourceProtocol = 0 Then
  s = "File"
 Else
  s = "No: " + str(Form2.x1.SourceProtocol)
 End If
 Text(14).Text = s
 Label(14).ToolTipText = Text(14).Text
 Text(15).Text = Form2.x1.ErrorCorrection
 Label(15).ToolTipText = Text(15).Text
 Text(16).Text = str(Form2.x1.Bandwidth \ 1000) + " Kbs/Sec"
 Label(16).ToolTipText = Text(16).Text
 Text(17).Text = str(Form2.x1.ReceivedPackets)
 Label(17).ToolTipText = Text(17).Text
 Text(18).Text = str(Form2.x1.RecoveredPackets)
 Label(18).ToolTipText = Text(18).Text
 Text(19).Text = str(Form2.x1.LostPackets)
 Label(19).ToolTipText = Text(19).Text
 Text(20).Text = str(Form2.x1.ReceptionQuality) + "  %"
 Label(20).ToolTipText = Text(20).Text
End Sub
Private Sub TimerP_Timer()
 LoadDetails
End Sub
