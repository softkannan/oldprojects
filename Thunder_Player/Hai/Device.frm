VERSION 5.00
Begin VB.Form Form7 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Form7"
   ClientHeight    =   630
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2655
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form7"
   ScaleHeight     =   630
   ScaleWidth      =   2655
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.ComboBox Dev1 
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   315
      Left            =   120
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   120
      Width           =   2415
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H0000FF00&
      BorderWidth     =   3
      Height          =   615
      Left            =   0
      Top             =   0
      Width           =   2655
   End
End
Attribute VB_Name = "Form7"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Dev1_Click()
 Formm.OpenbyDevice Dev1.Text
 Form7.Hide
End Sub
Private Sub Dev1_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyEscape Then
  Form7.Hide
 ElseIf KeyCode = vbKeyReturn Then
  Formm.OpenbyDevice Dev1.Text
  Form7.Hide
 End If
End Sub
Private Sub Form_Activate()
 Form7.Top = Form1.Top - Form7.Height
 Form7.Left = Form1.Left + Form1.Width
End Sub
Private Sub Form_DblClick()
 Formm.OpenbyDevice Dev1.Text
 Form7.Hide
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyEscape Then
  Form7.Hide
 End If
End Sub
Private Sub Form_Load()
 Form7.Top = Form1.Top - Form7.Height
 Form7.Left = Form1.Left + Form1.Width
End Sub
Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
 If Button = 2 Then
  Form7.Hide
 End If
End Sub
