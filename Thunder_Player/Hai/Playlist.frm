VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{84D1EEB7-556A-11D1-8118-B7B45FE6C56E}#1.0#0"; "LIBBTN.OCX"
Begin VB.Form Form3 
   Appearance      =   0  'Flat
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Playlist"
   ClientHeight    =   2775
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   3300
   ForeColor       =   &H00FFFFFF&
   Icon            =   "Playlist.frx":0000
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   3300
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin Insert_Project_Name.SoftBttn SoftBttn5 
      Height          =   270
      Left            =   2640
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   2400
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   476
      Picture         =   "Playlist.frx":030A
      BackColor       =   -2147483627
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn3 
      Height          =   270
      Left            =   840
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2400
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   476
      Picture         =   "Playlist.frx":0824
      BackColor       =   -2147483627
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn2 
      Height          =   270
      Left            =   480
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   2400
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   476
      Picture         =   "Playlist.frx":0D3E
      BackColor       =   -2147483627
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn SoftBttn1 
      Height          =   270
      Left            =   120
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   2400
      Width           =   375
      _ExtentX        =   661
      _ExtentY        =   476
      Picture         =   "Playlist.frx":1258
      BackColor       =   -2147483627
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.ListBox List3 
      BackColor       =   &H00000000&
      ForeColor       =   &H0000FF00&
      Height          =   2205
      Left            =   80
      MultiSelect     =   2  'Extended
      TabIndex        =   0
      ToolTipText     =   "Play list"
      Top             =   120
      Width           =   3135
   End
   Begin VB.ListBox List1 
      Height          =   1815
      Left            =   240
      TabIndex        =   1
      Top             =   360
      Visible         =   0   'False
      Width           =   1455
   End
   Begin MSComDlg.CommonDialog SaveM3Ulis 
      Left            =   120
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
      DefaultExt      =   "*.m3u"
      DialogTitle     =   "Open"
      Filter          =   "M3U Files|*.m3u"
   End
   Begin VB.Menu Playlism 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Playli 
         Caption         =   "LoadM3UFile"
         Index           =   0
      End
      Begin VB.Menu Playli 
         Caption         =   "SaveM3UFile"
         Index           =   1
      End
      Begin VB.Menu Playli 
         Caption         =   "Play/Pause"
         Index           =   2
      End
   End
   Begin VB.Menu Volume3D 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Volume3D1 
         Caption         =   "SwapSpeakers"
         Index           =   1
      End
      Begin VB.Menu Volume3D1 
         Caption         =   "Exit"
         Index           =   2
      End
   End
   Begin VB.Menu AddM 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Add1 
         Caption         =   "Add"
         Index           =   0
      End
      Begin VB.Menu Add1 
         Caption         =   "Add URL"
         Index           =   1
      End
      Begin VB.Menu Add1 
         Caption         =   "AddDir"
         Index           =   2
      End
   End
   Begin VB.Menu RemM 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Rem1 
         Caption         =   "RemAll"
         Index           =   0
      End
      Begin VB.Menu Rem1 
         Caption         =   "Crop"
         Index           =   1
      End
      Begin VB.Menu Rem1 
         Caption         =   "RemSel"
         Index           =   2
      End
   End
   Begin VB.Menu SelM 
      Caption         =   ""
      Visible         =   0   'False
      Begin VB.Menu Sel1 
         Caption         =   "SelAll"
         Index           =   0
      End
      Begin VB.Menu Sel1 
         Caption         =   "SelZero"
         Index           =   1
      End
      Begin VB.Menu Sel1 
         Caption         =   "InvSel"
         Index           =   2
      End
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Add1_Click(index As Integer)
  On Error Resume Next
  Dim s As String
    Select Case index
    Case 0:
         Form1.Openbo.ShowOpen
         If Err.Number <> 32755 Then
         Add 0, Form1.Openbo.Filename
         End If
    Case 1:
         s = "Open URL:" + vbCr + "Enter Like This www.mp3.com/l.mp3"
         s = InputBox(s, "Open URL")
        If s <> "" Then
           Add 0, s
        End If
    Case 2:
        Form8.Show
    End Select
End Sub
Function Add(op As Byte, Optional str As String)
    Dim i As Long
    Select Case (op)
     Case 0:
      List1.AddItem str
      List3.AddItem Right(str, Len(str) - InStrRev(str, "\"))
     Case 2:
        For i = 0 To Form8.File1.ListCount - 1
            Form8.File1.ListIndex = i
            Form8.addlis
        Next
    End Select
End Function
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    Form3.Hide
    Cancel = 20
End Sub
Sub remove(op As Byte)
    On Error Resume Next
    Dim i As Long
    Select Case op
    Case 0:
        List1.RemoveItem (List3.ListIndex)
        List3.RemoveItem (List3.ListIndex)
    Case 1:
        For i = List1.ListCount - 1 To 0 Step -1
            List1.ListIndex = i
            List3.ListIndex = i
            If List3.Selected(i) = True Then
                List1.RemoveItem i
                List3.RemoveItem i
            End If
        Next i
    Case 2:
        List1.Clear
        List3.Clear
    Case 3:
        For i = List1.ListCount - 1 To 0 Step -1
            List1.ListIndex = i
            List3.ListIndex = i
            If List3.Selected(i) <> True Then
                List1.RemoveItem i
                List3.RemoveItem i
            End If
        Next i
    End Select
End Sub
Sub SelectList(op As Integer)
    Dim i As Integer
    Select Case op
    Case 0:
        For i = List1.ListCount - 1 To 0 Step -1
            List1.ListIndex = i
            List3.ListIndex = i
            List3.Selected(i) = True
        Next i
    Case 1:
        For i = List1.ListCount - 1 To 0 Step -1
            List1.ListIndex = i
            List3.ListIndex = i
            List3.Selected(i) = False
        Next i
    Case 2:
        For i = List1.ListCount - 1 To 0 Step -1
            List1.ListIndex = i
            List3.ListIndex = i
            If List3.Selected(i) = False Then
                List3.Selected(i) = True
            Else
                List3.Selected(i) = False
            End If
        Next i
    End Select
End Sub
Private Sub List3_Click()
    List1.ListIndex = List3.ListIndex
End Sub
Private Sub List3_DblClick()
    OpenOk
End Sub
Function SaveM3U(Optional Filename As String)
    On Error Resume Next
    If List1.ListCount > 0 Then
        If Filename = "" Then
            SaveM3Ulis.DialogTitle = "Save M3U List"
            SaveM3Ulis.ShowSave
            If Err.Number <> 32755 Then
                M3usave SaveM3Ulis.Filename
            End If
        Else
            M3usave Filename
        End If
    End If
End Function
Function M3usave(ByVal Filename As String)
    On Error Resume Next
    Dim i As Long
    Open Filename For Output As #1
    Print #1, "#EXTM3U"
    For i = 0 To List1.ListCount - 1
        List1.ListIndex = i
        Print #1, List1.Text
    Next
    Close #1
End Function
Function M3uload(ByVal Filename As String)
    On Error Resume Next
    Dim s As String
    Dim l1 As Long
    Open Filename For Input As #1
    Line Input #1, s
    If Left(s, 1) <> "#" Then
        List1.AddItem (s)
        l1 = InStrRev(s, "\")
        s = Right(s, (Len(s) - l1))
        List3.AddItem (s)
    End If
    While Not EOF(1)
       Line Input #1, s
        If Left(s, 1) <> "#" Then
            List1.AddItem (s)
            l1 = InStrRev(s, "\")
            s = Right(s, (Len(s) - l1))
            List3.AddItem (s)
        End If
    Wend
    Close #1
End Function
Sub OpenOk()
    On Error Resume Next
    If List1.ListCount > 0 Then
        List1.ListIndex = List3.ListIndex
        If List1.Text <> Form2.x1.Filename Then
            Form2.openmedia (List1.Text)
            Form1.fl.Plflag = True
        End If
    End If
End Sub
Private Sub List3_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error Resume Next
    If Button = 1 Then
        List1.ListIndex = List3.ListIndex
    Else
        PopupMenu Form3.Playlism
    End If
End Sub
Private Sub Playli_Click(index As Integer)
    ResPlayli index
End Sub
Sub ResPlayli(index As Integer)
    On Error Resume Next
    Dim t As String
    Select Case index
    Case 0:
        Form1.Openbo.Filename = ""
        t = Form1.Openbo.Filter
        Form1.Openbo.Filter = "M3U|*.m3u"
        Form1.Openbo.ShowOpen
        If Err.Number <> 32755 Then
            Form1.ope Form1.Openbo.Filename
        End If
        Form1.Openbo.Filter = t
    Case 1:
        SaveM3U
    Case 2:
        If List3.ListIndex < 0 Then
            List3.ListIndex = 0
            List1.ListIndex = 0
        End If
        Form1.fl.PlCount = List1.ListCount
        OpenOk
        Form1.fl.PlCount = List1.ListCount
    End Select
End Sub
Private Sub Rem1_Click(index As Integer)
    Select Case index
    Case 0:
        remove 2
        Form1.fl.PlCount = List1.ListCount
    Case 1:
        remove 3
    Case 2:
        remove 1
        Form1.fl.PlCount = List1.ListCount
    End Select
End Sub
Private Sub Sel1_Click(index As Integer)
    Select Case index
    Case 0:
        SelectList 0
    Case 1:
        SelectList 1
    Case 2:
        SelectList 2
    End Select
End Sub
Private Sub SoftBttn1_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    PopupMenu Me.AddM
End Sub
Private Sub SoftBttn2_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    PopupMenu Me.RemM
End Sub
Private Sub SoftBttn3_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    PopupMenu Me.SelM
End Sub
Private Sub SoftBttn5_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    PopupMenu Form3.Playlism
End Sub
Private Sub Volume3D1_Click(index As Integer)
    Form31.MenuRes index
End Sub
Function LoadFilter(op As Integer) As String
 Select Case op
  Case 0:
    LoadFilter = "*.thu;*.wmv;*.wma;*.asf;*.wav;*.dat;*.mp3;*.mpg;*.mpv;*.mp2;*.au;*.mid;*.midi;*.mov;*.avi"
  Case 1:
    LoadFilter = "*.avi"
  Case 2:
    LoadFilter = "*.mov"
  Case 3:
    LoadFilter = "*.dat;*.mpg"
  Case 4:
    LoadFilter = "*.mp3"
  Case 5:
    LoadFilter = "*.*"
 End Select
End Function
