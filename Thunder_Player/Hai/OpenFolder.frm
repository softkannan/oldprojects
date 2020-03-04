VERSION 5.00
Begin VB.Form Form8 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Open Directory"
   ClientHeight    =   3240
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2910
   Icon            =   "OpenFolder.frx":0000
   LinkTopic       =   "Form8"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3240
   ScaleWidth      =   2910
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.FileListBox File1 
      Height          =   2040
      Left            =   120
      TabIndex        =   4
      Top             =   480
      Visible         =   0   'False
      Width           =   2655
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1680
      TabIndex        =   3
      Top             =   2760
      Width           =   1095
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Ok"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   2760
      Width           =   975
   End
   Begin VB.DirListBox Dir1 
      Height          =   2115
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   2655
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2655
   End
End
Attribute VB_Name = "Form8"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Command1_Click()
addlis
Form8.Hide
End Sub
Private Sub Command2_Click()
Form8.Hide
End Sub
Private Sub Dir1_Change()
On Error Resume Next
 File1.Path = Dir1.Path
End Sub
Private Sub Drive1_Change()
On Error Resume Next
 Dir1.Path = Drive1.Drive
 File1.Path = Dir1.Path
End Sub
Private Sub Form_Load()
 File1.Pattern = "*.thu;*.wmv;*.wma;*.asf;*.wav;*.dat;*.mp3;*.mpg;*.mpv;*.mp2;*.au;*.mid;*.midi;*.mov;*.avi"
End Sub
Private Sub Form_Unload(Cancel As Integer)
 Unload Me
End Sub
Sub addlis()
Dim i As Integer
  For i = 0 To File1.ListCount - 1
    File1.ListIndex = i
    If Right(File1.Path, 1) = "\" Then
     Form3.List1.AddItem (File1.Path + File1.Filename)
     Form3.List3.AddItem (File1.Filename)
    Else
     Form3.List1.AddItem (File1.Path + "\" + File1.Filename)
     Form3.List3.AddItem (File1.Filename)
    End If
  Next
End Sub
