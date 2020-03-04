VERSION 5.00
Object = "{22D6F304-B0F6-11D0-94AB-0080C74C7E95}#1.0#0"; "MSDXM.OCX"
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Thunder Player"
   ClientHeight    =   3690
   ClientLeft      =   4710
   ClientTop       =   3555
   ClientWidth     =   5445
   Icon            =   "Move.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   OLEDropMode     =   1  'Manual
   ScaleHeight     =   3690
   ScaleWidth      =   5445
   WhatsThisHelp   =   -1  'True
   Begin VB.Frame Frame1 
      Height          =   3615
      Left            =   80
      TabIndex        =   0
      Top             =   0
      Width           =   5295
      Begin MediaPlayerCtl.MediaPlayer x1 
         CausesValidation=   0   'False
         Height          =   2715
         Left            =   105
         TabIndex        =   1
         TabStop         =   0   'False
         ToolTipText     =   "Movie Window"
         Top             =   195
         Visible         =   0   'False
         Width           =   3585
         AudioStream     =   -1
         AutoSize        =   -1  'True
         AutoStart       =   0   'False
         AnimationAtStart=   0   'False
         AllowScan       =   -1  'True
         AllowChangeDisplaySize=   -1  'True
         AutoRewind      =   0   'False
         Balance         =   0
         BaseURL         =   ""
         BufferingTime   =   3
         CaptioningID    =   ""
         ClickToPlay     =   0   'False
         CursorType      =   0
         CurrentPosition =   -1
         CurrentMarker   =   0
         DefaultFrame    =   ""
         DisplayBackColor=   16777215
         DisplayForeColor=   0
         DisplayMode     =   0
         DisplaySize     =   4
         Enabled         =   -1  'True
         EnableContextMenu=   0   'False
         EnablePositionControls=   0   'False
         EnableFullScreenControls=   0   'False
         EnableTracker   =   0   'False
         Filename        =   ""
         InvokeURLs      =   -1  'True
         Language        =   -1
         Mute            =   0   'False
         PlayCount       =   1
         PreviewMode     =   0   'False
         Rate            =   1
         SAMILang        =   ""
         SAMIStyle       =   ""
         SAMIFileName    =   ""
         SelectionStart  =   -1
         SelectionEnd    =   -1
         SendOpenStateChangeEvents=   -1  'True
         SendWarningEvents=   -1  'True
         SendErrorEvents =   -1  'True
         SendKeyboardEvents=   -1  'True
         SendMouseClickEvents=   -1  'True
         SendMouseMoveEvents=   -1  'True
         SendPlayStateChangeEvents=   -1  'True
         ShowCaptioning  =   0   'False
         ShowControls    =   0   'False
         ShowAudioControls=   0   'False
         ShowDisplay     =   0   'False
         ShowGotoBar     =   0   'False
         ShowPositionControls=   0   'False
         ShowStatusBar   =   0   'False
         ShowTracker     =   0   'False
         TransparentAtStart=   0   'False
         VideoBorderWidth=   0
         VideoBorderColor=   0
         VideoBorder3D   =   -1  'True
         Volume          =   0
         WindowlessVideo =   0   'False
      End
   End
   Begin VB.Menu Rate1 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Rate 
         Caption         =   "0.00"
         Index           =   1
      End
      Begin VB.Menu Rate 
         Caption         =   "0.25"
         Index           =   2
      End
      Begin VB.Menu Rate 
         Caption         =   "0.50"
         Index           =   3
      End
      Begin VB.Menu Rate 
         Caption         =   "0.75"
         Index           =   4
      End
      Begin VB.Menu Rate 
         Caption         =   "Normal"
         Index           =   5
      End
      Begin VB.Menu Rate 
         Caption         =   "1.25"
         Index           =   6
      End
      Begin VB.Menu Rate 
         Caption         =   "1.50"
         Index           =   7
      End
      Begin VB.Menu Rate 
         Caption         =   "1.75"
         Index           =   8
      End
      Begin VB.Menu Rate 
         Caption         =   "2.00"
         Index           =   9
      End
      Begin VB.Menu Rate 
         Caption         =   "Custom"
         Index           =   10
      End
   End
   Begin VB.Menu Sound1 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Sound 
         Caption         =   "Streo"
         Index           =   0
      End
      Begin VB.Menu Sound 
         Caption         =   "Left"
         Index           =   1
      End
      Begin VB.Menu Sound 
         Caption         =   "Right"
         Index           =   2
      End
      Begin VB.Menu Sound 
         Caption         =   "Wave"
         Index           =   3
      End
      Begin VB.Menu Sound 
         Caption         =   "ZigZag"
         Index           =   4
      End
      Begin VB.Menu Sound 
         Caption         =   "Dts"
         Index           =   5
      End
      Begin VB.Menu Sound 
         Caption         =   "Su3d"
         Index           =   6
      End
      Begin VB.Menu Sound 
         Caption         =   "3DVolume"
         Index           =   7
      End
   End
   Begin VB.Menu Move2 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Movie1 
         Caption         =   "MakeMovie       (Click)"
         Index           =   0
      End
      Begin VB.Menu Movie1 
         Caption         =   "NewClip    (Ctrl+Click)"
         Index           =   1
      End
      Begin VB.Menu Movie1 
         Caption         =   "LoadMove   (Alt+Click)"
         Index           =   2
      End
      Begin VB.Menu Movie1 
         Caption         =   "SaveClip  (Shift+Click)"
         Index           =   3
      End
      Begin VB.Menu Movie1 
         Caption         =   "UnloadMove"
         Index           =   4
      End
   End
   Begin VB.Menu Open1 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Open2 
         Caption         =   "Open                 (Click)"
         Index           =   0
      End
      Begin VB.Menu Open2 
         Caption         =   "OpenVCD   (Ctrl+Click)"
         Index           =   1
      End
      Begin VB.Menu Open2 
         Caption         =   "OpenURL  (Shift+Click)"
         Index           =   2
      End
      Begin VB.Menu Open2 
         Caption         =   "PlayList         "
         Index           =   3
      End
      Begin VB.Menu Open2 
         Caption         =   "Close"
         Index           =   4
      End
   End
   Begin VB.Menu Other1 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Other2 
         Caption         =   "PrevTrack click)"
         Index           =   0
      End
      Begin VB.Menu Other2 
         Caption         =   "Play/Pause (Click)"
         Index           =   1
         Visible         =   0   'False
      End
      Begin VB.Menu Other2 
         Caption         =   "Pause (Click)"
         Index           =   2
         Visible         =   0   'False
      End
      Begin VB.Menu Other2 
         Caption         =   "Stop (Click)"
         Index           =   3
         Visible         =   0   'False
      End
      Begin VB.Menu Other2 
         Caption         =   "NextTrack (Click)"
         Index           =   4
         Visible         =   0   'False
      End
      Begin VB.Menu Other2 
         Caption         =   "PrevStep (Click)"
         Index           =   5
         Visible         =   0   'False
      End
      Begin VB.Menu Other2 
         Caption         =   "NextStep (Click)"
         Index           =   6
         Visible         =   0   'False
      End
   End
   Begin VB.Menu main1 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Main2 
         Caption         =   "ThunderPlayer..."
         Index           =   0
      End
      Begin VB.Menu Main2 
         Caption         =   "-"
         Index           =   1
      End
      Begin VB.Menu Main2 
         Caption         =   "File"
         Index           =   2
         Begin VB.Menu Main3 
            Caption         =   "Open"
            Index           =   0
         End
         Begin VB.Menu Main3 
            Caption         =   "OpenURL"
            Index           =   1
         End
         Begin VB.Menu Main3 
            Caption         =   "OpenVCD"
            Index           =   2
         End
         Begin VB.Menu Main3 
            Caption         =   "PlayList"
            Index           =   3
         End
      End
      Begin VB.Menu Main2 
         Caption         =   "PlayBack"
         Index           =   3
         Begin VB.Menu Main4 
            Caption         =   "Play\Pause"
            Index           =   0
         End
         Begin VB.Menu Main4 
            Caption         =   "Pause"
            Index           =   1
         End
         Begin VB.Menu Main4 
            Caption         =   "Stop"
            Index           =   2
         End
      End
      Begin VB.Menu Main2 
         Caption         =   "Volume"
         Index           =   4
         Begin VB.Menu Vol1 
            Caption         =   "UP"
            Index           =   0
         End
         Begin VB.Menu Vol1 
            Caption         =   "Down"
            Index           =   1
         End
         Begin VB.Menu Vol1 
            Caption         =   "Mute"
            Index           =   2
         End
      End
      Begin VB.Menu Main2 
         Caption         =   "-"
         Index           =   5
      End
      Begin VB.Menu Main2 
         Caption         =   "Zoom"
         Index           =   6
         Begin VB.Menu MoveSi1 
            Caption         =   "DefaultSize"
            Index           =   0
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "HalfSize"
            Index           =   1
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "DoubleSize"
            Index           =   2
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "FullScreen"
            Index           =   3
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "FitToSize"
            Index           =   4
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "OneSixeenthScreen"
            Index           =   5
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "OneFourthScreen"
            Index           =   6
         End
         Begin VB.Menu MoveSi1 
            Caption         =   "OneHalfScreen"
            Index           =   7
         End
      End
      Begin VB.Menu Main2 
         Caption         =   "MovieDetails"
         Index           =   7
      End
      Begin VB.Menu Main2 
         Caption         =   "Options"
         Index           =   8
      End
      Begin VB.Menu Main2 
         Caption         =   "FullScreen"
         Index           =   9
      End
      Begin VB.Menu Main2 
         Caption         =   "Close"
         Index           =   10
      End
      Begin VB.Menu Main2 
         Caption         =   "-"
         Index           =   11
      End
      Begin VB.Menu Main2 
         Caption         =   "Quit"
         Index           =   12
      End
   End
   Begin VB.Menu Openmci 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Openq 
         Caption         =   "Open"
         Index           =   0
      End
      Begin VB.Menu Openq 
         Caption         =   "Audio CD"
         Index           =   1
      End
      Begin VB.Menu Openq 
         Caption         =   "Video CD"
         Index           =   2
      End
      Begin VB.Menu Openq 
         Caption         =   "OpenByDevice"
         Index           =   3
      End
      Begin VB.Menu Openq 
         Caption         =   "Zoom"
         Index           =   4
         Begin VB.Menu MCIzoom 
            Caption         =   "Maximised"
            Index           =   0
         End
         Begin VB.Menu MCIzoom 
            Caption         =   "HalfScreen"
            Index           =   1
         End
         Begin VB.Menu MCIzoom 
            Caption         =   "1/3Screen"
            Index           =   2
         End
         Begin VB.Menu MCIzoom 
            Caption         =   "FullScreen"
            Index           =   3
         End
         Begin VB.Menu MCIzoom 
            Caption         =   "DefaultScreen"
            Index           =   4
         End
         Begin VB.Menu MCIzoom 
            Caption         =   "3/4Screen"
            Index           =   5
         End
      End
      Begin VB.Menu Openq 
         Caption         =   "Close"
         Index           =   5
      End
      Begin VB.Menu Openq 
         Caption         =   "Volume"
         Index           =   6
      End
      Begin VB.Menu Openq 
         Caption         =   "Find"
         Index           =   7
      End
   End
   Begin VB.Menu RecordM 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu RecordM1 
         Caption         =   "Record"
         Index           =   0
      End
      Begin VB.Menu RecordM1 
         Caption         =   "RecordByDevice"
         Index           =   1
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Function openmedia(Filename As String)
Dim t As Integer
 Form2.WindowState = 0
 Form1.TimerLogo.Enabled = False
  If Form1.mov.State = True Then
   Form1.fl.Lo1 = False
   Form1.mov.UnloadMove
  End If
  If LCase(Right(Filename, 3)) = "thu" Then
    Form1.fl.Lo1 = True
    Form1.mov.LoadMove (Filename)
    Form1.fl.Plflag = True
  ElseIf LCase(Right(Filename, 3)) = "m3u" Then
   'Form3.remove 2
    Form1.fl.PlCount = Form3.List1.ListCount
    Form3.M3uload (Filename)
  ElseIf Filename <> x1.Filename Then
    x1.Filename = Filename
  ElseIf Filename <> "" Then
    x1.Filename = Filename
  End If
 If x1.Filename <> "" Then
  Form1.Label3.Caption = Right(Form2.x1.Filename, Len(Form2.x1.Filename) - InStrRev(Form2.x1.Filename, "\"))
  Form1.Label3.ToolTipText = x1.Filename + " - Thunder Player 1.0"
  Form1.Caption = Form1.Label3.Caption + " - Thunder Player 1.0"
  Form2.Caption = Form1.Label3.Caption + " - Thunder Player 1.0"
  If Len(Form1.Label3.Caption) > 36 Then
   Form1.Label3.Caption = Left(Form1.Label3.Caption, 33) + "..."
  End If
  End If
  If Form1.fl.Lo1 <> True Then
  If Form1.fl.Lo = True Then
     If x1.Filename <> "" Then
       Form1.Logo
     End If
   End If
  End If
  If LCase(Right(Filename, 3)) = "m3u" Then
   Form3.OpenOk
  End If
End Function
Private Sub Form_GotFocus()
 On Error Resume Next
  x1.SetFocus
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 Form1.KeyRes KeyCode, Shift
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 Form1.MouseRes Button, Shift
End Sub

Private Sub Form_Unload(Cancel As Integer)
   Form1.Close1
End Sub
Private Sub Frame1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
  Form1.MouseRes Button, Shift
End Sub
Private Sub Main2_Click(Index As Integer)
  Form1.MainMenu (Index)
End Sub
Private Sub Main3_Click(Index As Integer)
 Form1.Main3Menu (Index)
End Sub
Private Sub Main4_Click(Index As Integer)
 Form1.Main4Menu (Index)
End Sub
Private Sub MCIzoom_Click(Index As Integer)
 Formm.Resize Index
End Sub
Private Sub MoveSi1_Click(Index As Integer)
 Form1.MovieSize (Index)
End Sub
Private Sub Movie1_Click(Index As Integer)
 Form1.Thumove (Index)
End Sub

Private Sub Open2_Click(Index As Integer)
Form1.OpenMenu (Index)
End Sub
Private Sub Openq_Click(Index As Integer)
 Formm.MenuOpe Index
End Sub
Private Sub Other2_Click(Index As Integer)
 Form1.Othermenu (Index)
End Sub
Private Sub Rate_Click(Index As Integer)
 Form1.ChRate (Index)
End Sub

Private Sub RecordM1_Click(Index As Integer)
 Formm.RecordMenu Index
End Sub

Private Sub Sound_Click(Index As Integer)
Form1.ChSound Index
End Sub
Private Sub Vol1_Click(Index As Integer)
 Form1.Vol1Menu (Index)
End Sub
Private Sub x1_DblClick(Button As Integer, ShiftState As Integer, x As Single, y As Single)
 If Button = 1 Then
  Form1.Play
 End If
End Sub
Private Sub x1_EndOfStream(ByVal Result As Long)
 Form1.Endstream
End Sub
Private Sub x1_Error()
 Dim t As String
 t = "Error Description:" + x1.ErrorDescription + vbCr + "Error Number:" + str(x1.ErrorCode)
 MsgBox t, 0, "Error"
 If Form1.fl.Logopa = "" Then
  Form1.fl.Lo = False
 End If
 Form1.Close1
End Sub
Private Sub x1_KeyDown(KeyCode As Integer, ShiftState As Integer)
 Select Case KeyCode
 Case vbKeySpace:
 Case vbKeyM:
 Case Else
  Form1.KeyRes KeyCode, ShiftState
 End Select
End Sub
Private Sub x1_MouseDown(Button As Integer, ShiftState As Integer, x As Single, y As Single)
 Form1.MouseRes Button, ShiftState
End Sub
Private Sub x1_ReadyStateChange(ReadyState As MediaPlayerCtl.ReadyStateConstants)
 If ReadyState = amvComplete Then
  Form1.Opencom
 End If
End Sub

