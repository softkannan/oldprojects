VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FF0000&
   Caption         =   "Text Editor"
   ClientHeight    =   3195
   ClientLeft      =   510
   ClientTop       =   1725
   ClientWidth     =   5160
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   3195
   ScaleWidth      =   5160
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer1 
      Interval        =   3000
      Left            =   3960
      Top             =   2520
   End
   Begin RichTextLib.RichTextBox rtftext 
      Height          =   1600
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3000
      _ExtentX        =   5292
      _ExtentY        =   2831
      _Version        =   393217
      BorderStyle     =   0
      ScrollBars      =   2
      DisableNoScroll =   -1  'True
      TextRTF         =   $"Form1.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Andalus"
         Size            =   14.25
         Charset         =   178
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Sub Form_Paint()
Dim I As Integer, X As Integer, Y As Integer
Dim C As String
Cls

X = CurrentX
Y = CurrentY
C = Chr(I)
'Line -(X + TextWidth(C), Y = TextHeight(C)), _
QBColor(Rnd * 16), BF
CurrentX = X
CurrentY = Y
Form1.BackColor = RGB(Rnd * 256, Rnd * 256, Rnd * 256)


End Sub


Private Sub Timer1_Timer()
 Form_Paint
End Sub



Private Sub Form_Load()
Form_Resize
End Sub


Private Sub Form_Resize()
    On Error Resume Next
    rtftext.Move 100, 100, Me.ScaleWidth - 200, Me.ScaleHeight - 200
    rtftext.RightMargin = Text1.Width - 400
    
End Sub




