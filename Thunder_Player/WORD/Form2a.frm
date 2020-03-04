VERSION 5.00
Begin VB.Form Form2 
   BackColor       =   &H00FF0000&
   Caption         =   "Form2"
   ClientHeight    =   3195
   ClientLeft      =   4365
   ClientTop       =   2820
   ClientWidth     =   4680
   BeginProperty Font 
      Name            =   "Comic Sans MS"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form2"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   2880
      Top             =   720
   End
   Begin VB.PictureBox Picture1 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3255
      Left            =   0
      ScaleHeight     =   3195
      ScaleWidth      =   4635
      TabIndex        =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   4695
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   178
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   3135
         Left            =   0
         TabIndex        =   1
         Top             =   0
         Visible         =   0   'False
         Width           =   4695
      End
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   18
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Index           =   1
      Left            =   0
      TabIndex        =   2
      Top             =   480
      Width           =   4695
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Initialize()

On Error Resume Next
Dim X As Integer
For X = 1 To 9
Load Label1(X)
Label1(X).Visible = True
Label1(X).Top = Picture1.Height + Label1(X).Height
Label1(X).Alignment = vbCenter
Label1(X).ForeColor = vbGreen
Label1(X).BackStyle = 0
Next X
Picture1.BackColor = vbGreen
Label1(1).Caption = "     DESIGNED BY"
Label1(2).Caption = "   Kishore from Developer IQ"
Label1(3).Caption = "****************************"
Label1(4).Caption = "    e- mail "
Label1(5).Caption = "kishore@iqresearch.net"
Label1(6).Caption = ""
Label1(7).Caption = " "
Label1(8).Caption = " "
Label1(9).Caption = "  "
For X = 1 To 9
Label1(X).Left = (Picture1.Width + (Label1(X).Width)) / 2
Next X
End Sub

Private Sub Timer1_Timer()
On Error Resume Next
Dim v
Text1.Text = Val(Text1.Text) + 25
X = Val(Text1.Text)
v = 400
For I = 1 To 9
Label1(I).Top = Picture1.Height - X + v
v = v + 500
Next I
If Label1(9).Top < -200 Then
For I = 1 To 9
Label1(I).Top = Picture1.Height + Label1(I).Height
Label1(I).FontSize = 20
Label1(I).Left = (Picture1.Width + (Label1(I).Width)) / 2
Text1.Text = "0"
Next I
End If
For I = 1 To 9
If Int(Label1(I).Top) < Int(Picture1.Height * 0.75) And Int(Label1(I).Top) > Int(Picture1.Height * 0.9) Then
Label1(I).FontSize = 15
Label1(I).Left = (Picture1.Width + (Label1(I).Width)) / 2
End If
If Int(Label1(I).Top) < Int(Picture1.Height * 0.5) And Int(Label1(I).Top) > Int(Picture1.Height * 0.9) Then
Label1(I).FontSize = 15
Label1(I).Left = (Picture1.Width + (Label1(I).Width)) / 2
End If
If Int(Label1(I).Top) < Int(Picture1.Height * 0.2) Then
Label1(I).FontSize = 15
Label1(I).Left = (Picture1.Width + (Label1(I).Width)) / 2
End If
Next I
End Sub



