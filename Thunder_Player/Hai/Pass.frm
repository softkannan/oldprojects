VERSION 5.00
Object = "{84D1EEB7-556A-11D1-8118-B7B45FE6C56E}#1.0#0"; "LIBBTN.OCX"
Begin VB.Form Form8 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Login"
   ClientHeight    =   1230
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3030
   LinkTopic       =   "Form8"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1230
   ScaleWidth      =   3030
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin Insert_Project_Name.SoftBttn Shutdownbt 
      Height          =   255
      Left            =   1560
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   720
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   450
      Picture         =   "Pass.frx":0000
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin Insert_Project_Name.SoftBttn LoginBt 
      Height          =   255
      Left            =   360
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   720
      Width           =   975
      _ExtentX        =   1720
      _ExtentY        =   450
      Picture         =   "Pass.frx":0DD2
      BackColor       =   0
      Enabled         =   -1  'True
      MaskColor       =   0
      UseMaskColor    =   0   'False
      PlaySounds      =   0   'False
      Object.ToolTipText     =   ""
   End
   Begin VB.TextBox Login 
      BackColor       =   &H00000000&
      ForeColor       =   &H0080FF80&
      Height          =   285
      IMEMode         =   3  'DISABLE
      Left            =   360
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   240
      Width           =   2295
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H0000FF00&
      BorderWidth     =   3
      Height          =   1215
      Left            =   0
      Top             =   0
      Width           =   3015
   End
End
Attribute VB_Name = "Form8"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub Login_KeyDown(KeyCode As Integer, Shift As Integer)
 If KeyCode = vbKeyReturn Then
  CheckPass Login.Text
 End If
End Sub
Sub CheckPass(str As String)
On Error Resume Next
 Dim t As Variant
 Dim t1 As String
 Open App.Path + "\Password.pwd" For Input As #2
 Input #2, t
 Close #2
 t1 = t
 If t1 = str Then
  Unload Me
  Form1.Show
 End If
End Sub
Private Sub LoginBt_Click()
 CheckPass Login.Text
End Sub
Private Sub Shutdownbt_Click()
 End
End Sub
