VERSION 5.00
Begin VB.Form frmFav 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   6015
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7110
   LinkTopic       =   "Form1"
   ScaleHeight     =   6015
   ScaleWidth      =   7110
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdGotoFav 
      Caption         =   "&Go to Url"
      Height          =   375
      Left            =   4080
      TabIndex        =   3
      Top             =   5160
      Width           =   975
   End
   Begin VB.CommandButton cmdRemove 
      Caption         =   "&Remove"
      Height          =   375
      Left            =   3000
      TabIndex        =   2
      Top             =   5160
      Width           =   975
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "&Close"
      Height          =   375
      Left            =   1920
      TabIndex        =   1
      Top             =   5160
      Width           =   975
   End
   Begin VB.ListBox List1 
      ForeColor       =   &H80000006&
      Height          =   5130
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7095
   End
End
Attribute VB_Name = "frmFav"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdGotoFav_Click()

'*******************************************************
    'Navigate to the selected Url
    Dim Go
    Go = List1.ListIndex
        frmKool.cmbUrl.Text = List1.list(Go)
        frmKool.WebBrowser.Navigate List1.list(Go)
        Me.Hide
'*******************************************************
End Sub

Private Sub cmdClose_Click()

'*******************************************************
    On Error Resume Next
    'Call the procedure and unload the form
    Call WriteList(List1, App.Path & "\fav.Dat")
    Unload Me
'*******************************************************
End Sub

Private Sub cmdRemove_Click()

'*******************************************************
    On Error Resume Next
    'Remove the selected Url from favorites list
    Dim out
        out = List1.ListIndex
            List1.RemoveItem (out)
'*******************************************************
End Sub

Private Sub Form_Load()

'*******************************************************
    'call the procedure to read the list and load the _
    frmFav form on top
    Ontop Me
    On Error Resume Next
        Call ReadList(List1, App.Path & "\fav.Dat", True)
    cmdGotoFav.Enabled = False
'*******************************************************
End Sub

Private Sub List1_Click()

'*******************************************************
    'enable button
    cmdGotoFav.Enabled = True
'*******************************************************
End Sub

Private Sub List1_DblClick()

'*******************************************************
    'Go to the Url when double clicked
    Dim Go
    Go = List1.ListIndex
        frmKool.cmbUrl.Text = List1.list(Go)
        frmKool.WebBrowser.Navigate List1.list(Go)
        Me.Hide
'*******************************************************
End Sub

