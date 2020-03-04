VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Real tooltip control demo"
   ClientHeight    =   4530
   ClientLeft      =   2070
   ClientTop       =   2010
   ClientWidth     =   3975
   ClipControls    =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   4530
   ScaleWidth      =   3975
   Begin VB.TextBox Text1 
      Height          =   705
      Left            =   780
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   3360
      Width           =   2235
   End
   Begin VB.PictureBox Picture1 
      Height          =   1755
      Left            =   720
      ScaleHeight     =   1695
      ScaleWidth      =   2355
      TabIndex        =   1
      Top             =   1170
      Width           =   2415
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   615
      Left            =   720
      TabIndex        =   0
      Top             =   240
      Width           =   2355
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'
' Copyright © 1997-1999 Brad Martinez, http://www.mvps.org
'
Dim m_cTT As New cTooltip
'

Private Sub Form_Load()
  Dim ctrl As Control
  
  With m_cTT
    
    ' Creat the tooltip window
    Call .Create(Me)

    ' Set the tooltip's width so that it displays multiline text,
    ' and that no tool's line length exceeds roughly 240 pixels.
    .MaxTipWidth = 240

    ' Set the tooltip window to show for 20 secs
    .DelayTime(ttDelayShow) = 20000
    
    ' Add a tooltip tool to each control on the Form
    For Each ctrl In Controls: Call .AddTool(ctrl): Next
    
    ' Set the text for Command1's tool.
    .ToolText(Command1) = "A excessively long line of text just to demonstrate multiple lines of text in a tooltip control." _
                                          & vbCrLf & vbCrLf & vbTab & _
                                          "And if MaxTipWidth isn't set to -1, text formatting characters will be evaluated too..."
    
    ' Set the text for Text1's tool.
    .ToolText(Text1) = " You can make pretty pictures too... :-) " & vbCrLf & vbCrLf & _
      "                          !!!!!!!" & vbCrLf & _
      "                          (ô  ô)" & vbCrLf & _
      "          +-----oOO----(_)----------------+" & vbCrLf & _
      "           |        Got a special        |" & vbCrLf & _
      "           |           message?          |" & vbCrLf & _
      "          +------------------------oOO-----+" & vbCrLf & _
      "                        |__|  |__|" & vbCrLf & _
      "                          ||      ||" & vbCrLf & _
      "                      ooO   Ooo"
  End With   ' m_cTT

End Sub
