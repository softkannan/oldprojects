VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Spider Crawling..."
   ClientHeight    =   3150
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4590
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3150
   ScaleWidth      =   4590
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command3 
      Caption         =   "&Stop"
      Height          =   375
      Left            =   2880
      TabIndex        =   2
      Top             =   2640
      Width           =   735
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Exit"
      Height          =   375
      Left            =   3720
      TabIndex        =   1
      Top             =   2640
      Width           =   735
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   1560
      Top             =   2640
   End
   Begin VB.CommandButton Command1 
      Caption         =   "&Start"
      Height          =   375
      Left            =   2040
      TabIndex        =   0
      Top             =   2640
      Width           =   735
   End
   Begin VB.Image Image1 
      Height          =   720
      Left            =   3840
      Picture         =   "spider.frx":0000
      Top             =   1800
      Width           =   720
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Copyright Pixnum 2001
'Just try to feel the crawling sequence of spider is quite similar to
'the crawling sequence of an original spider in your garden.Only observe it.
'If you like this code, please vote me and leave your comments !
'Thank you !

Private Sub Command1_Click()
Timer1.Enabled = True
End Sub

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Command3_Click()
Timer1.Enabled = False
End Sub

Private Sub Form_Load()
Timer1.Enabled = False
End Sub

Private Sub Timer1_Timer()
'Here the actual technique is present. You have to change the default setting
'which I have done here for the animation. See the change if you do it and thrill
'the changed sequence.In VB ,you can do whatever you like but only limitation
'is your imagination.
Image1.Move Image1.Left + ScaleWidth * (Rnd - 1) / 50, Image1.Top + ScaleHeight * (Rnd - 1) / 50
End Sub

