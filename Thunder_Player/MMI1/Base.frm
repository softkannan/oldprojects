VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Port Communication"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   Icon            =   "Base.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Recive 
      Caption         =   "Recive"
      Height          =   375
      Left            =   1680
      TabIndex        =   10
      Top             =   2520
      Width           =   1335
   End
   Begin VB.CommandButton Send 
      Caption         =   "Send"
      Height          =   375
      Left            =   1680
      TabIndex        =   7
      Top             =   1200
      Width           =   1335
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      ItemData        =   "Base.frx":030A
      Left            =   840
      List            =   "Base.frx":031D
      TabIndex        =   3
      Top             =   1920
      Width           =   1095
   End
   Begin VB.TextBox Text2 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1033
         SubFormatType   =   1
      EndProperty
      Height          =   285
      Left            =   3000
      TabIndex        =   2
      Text            =   "0"
      Top             =   1920
      Width           =   1095
   End
   Begin VB.TextBox Text1 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "0"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1033
         SubFormatType   =   1
      EndProperty
      Height          =   285
      Left            =   3000
      TabIndex        =   1
      Text            =   "0"
      Top             =   600
      Width           =   1095
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "Base.frx":033F
      Left            =   840
      List            =   "Base.frx":0352
      TabIndex        =   0
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Data:"
      Height          =   255
      Left            =   2280
      TabIndex        =   9
      Top             =   1970
      Width           =   615
   End
   Begin VB.Label Label4 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Port:"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   1965
      Width           =   495
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Port Communication"
      Height          =   255
      Left            =   1200
      TabIndex        =   6
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Data:"
      Height          =   255
      Left            =   2280
      TabIndex        =   5
      Top             =   650
      Width           =   615
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Port:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   650
      Width           =   495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public add1 As Integer
Public add2 As Integer
Private Sub Combo1_Click()
Select Case Combo1.Text
 Case "COM1":
  add1 = &H3F8 ' 1016
 Case "COM2":
  add1 = &H2F8 '760
 Case "LPT1":
  add1 = &H378 '888
 Case "LPT2":
  add1 = &H379
 Case "LPT3":
  add1 = &H37A
End Select
'MsgBox Str(add1)
End Sub
Private Sub Combo2_Click()
Select Case Combo2.Text
 Case "COM1":
  add2 = &H3F8 ' 1016
 Case "COM2":
  add2 = &H2F8 '760
 Case "LPT1":
  add2 = &H378 '888
 Case "LPT2":
  add2 = &H379
 Case "LPT3":
  add2 = &H37A
End Select
End Sub
Private Sub Form_Load()
'MsgBox Str(InPort(888))
Combo1.ListIndex = 0
Combo2.ListIndex = 0
End Sub
Private Sub Recive_Click()
Text2.Text = Str(InPort(add2))
End Sub
Private Sub Send_Click()
 OutPort &H378, CInt(Text1.Text)
 'out
 'Print
End Sub
