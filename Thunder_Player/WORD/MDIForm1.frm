VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.MDIForm MDIForm1 
   AutoShowChildren=   0   'False
   BackColor       =   &H00C0C0C0&
   Caption         =   "Word proccessor"
   ClientHeight    =   4305
   ClientLeft      =   1845
   ClientTop       =   1785
   ClientWidth     =   6045
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   2760
      Top             =   3000
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483624
      ImageWidth      =   16
      ImageHeight     =   15
      MaskColor       =   65280
      UseMaskColor    =   0   'False
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   35
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":0000
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":0544
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":2EA8
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":32FC
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":3840
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":3C94
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":40F0
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":4544
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":4860
            Key             =   ""
         EndProperty
         BeginProperty ListImage10 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":4CB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage11 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":5330
            Key             =   ""
         EndProperty
         BeginProperty ListImage12 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":5874
            Key             =   ""
         EndProperty
         BeginProperty ListImage13 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":6AF8
            Key             =   ""
         EndProperty
         BeginProperty ListImage14 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":86BC
            Key             =   ""
         EndProperty
         BeginProperty ListImage15 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":8D38
            Key             =   ""
         EndProperty
         BeginProperty ListImage16 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":8E4C
            Key             =   ""
         EndProperty
         BeginProperty ListImage17 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":94C8
            Key             =   ""
         EndProperty
         BeginProperty ListImage18 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":9D04
            Key             =   ""
         EndProperty
         BeginProperty ListImage19 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":9F98
            Key             =   ""
         EndProperty
         BeginProperty ListImage20 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":A22C
            Key             =   ""
         EndProperty
         BeginProperty ListImage21 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":A4C0
            Key             =   ""
         EndProperty
         BeginProperty ListImage22 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":BCFC
            Key             =   ""
         EndProperty
         BeginProperty ListImage23 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":C578
            Key             =   ""
         EndProperty
         BeginProperty ListImage24 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":CDF4
            Key             =   ""
         EndProperty
         BeginProperty ListImage25 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":D670
            Key             =   ""
         EndProperty
         BeginProperty ListImage26 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":DEEC
            Key             =   ""
         EndProperty
         BeginProperty ListImage27 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E008
            Key             =   ""
         EndProperty
         BeginProperty ListImage28 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E11C
            Key             =   ""
         EndProperty
         BeginProperty ListImage29 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E230
            Key             =   ""
         EndProperty
         BeginProperty ListImage30 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E344
            Key             =   ""
         EndProperty
         BeginProperty ListImage31 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E458
            Key             =   ""
         EndProperty
         BeginProperty ListImage32 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E56C
            Key             =   ""
         EndProperty
         BeginProperty ListImage33 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E680
            Key             =   ""
         EndProperty
         BeginProperty ListImage34 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":E794
            Key             =   ""
         EndProperty
         BeginProperty ListImage35 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MDIForm1.frx":EAB0
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComDlg.CommonDialog dlgCommonDialog 
      Left            =   1320
      Top             =   3000
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.Toolbar tbToolbar 
      Align           =   1  'Align Top
      Height          =   2190
      Left            =   0
      Negotiate       =   -1  'True
      TabIndex        =   0
      Top             =   0
      Width           =   6045
      _ExtentX        =   10663
      _ExtentY        =   3863
      ButtonWidth     =   1693
      ButtonHeight    =   926
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   22
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Open"
            Key             =   "open"
            Object.ToolTipText     =   "Open Documents ,text,etc.."
            ImageIndex      =   16
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "New"
            Key             =   "new"
            Object.ToolTipText     =   "New Document"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Save"
            Key             =   "save"
            ImageIndex      =   10
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Close"
            Key             =   "close"
            ImageIndex      =   9
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Clear"
            Key             =   "clear"
            Object.ToolTipText     =   "Bold Font  For selected"
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Italic"
            Key             =   "i"
            Object.ToolTipText     =   "Italic Font  For selected"
            ImageIndex      =   27
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Undeline"
            Key             =   "u"
            Object.ToolTipText     =   "Undelined Font For selected"
            ImageIndex      =   32
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Copy"
            Key             =   "copy"
            Object.ToolTipText     =   "Copy selected "
            ImageIndex      =   11
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Paste"
            Key             =   "paste"
            Object.ToolTipText     =   "Paste selected"
            ImageIndex      =   14
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Cut"
            Key             =   "cut"
            Object.ToolTipText     =   "Cut selected"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Delete"
            Key             =   "del"
            Object.ToolTipText     =   "Delete selected"
            ImageIndex      =   15
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Select all"
            Key             =   "all"
            Object.ToolTipText     =   "Select All"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Font size"
            Key             =   "size"
            Object.ToolTipText     =   "Change Font Size"
         EndProperty
         BeginProperty Button14 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "End"
            Key             =   "end"
            Object.ToolTipText     =   "Go to the end of text"
         EndProperty
         BeginProperty Button15 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Home"
            Key             =   "home"
            Object.ToolTipText     =   "go to the begining of text"
         EndProperty
         BeginProperty Button16 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Align Left"
            Key             =   "left"
            Object.ToolTipText     =   "Align text left"
            ImageIndex      =   29
         EndProperty
         BeginProperty Button17 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Align Right"
            Key             =   "right"
            Object.ToolTipText     =   "Align text right"
            ImageIndex      =   30
         EndProperty
         BeginProperty Button18 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Center"
            Key             =   "center"
            Object.ToolTipText     =   "Align text in the center"
            ImageIndex      =   28
         EndProperty
         BeginProperty Button19 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Blod"
            Key             =   "bold"
            Object.ToolTipText     =   "Clear Text"
            ImageIndex      =   26
         EndProperty
         BeginProperty Button20 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Font color"
            Key             =   "color"
            ImageIndex      =   34
         EndProperty
         BeginProperty Button21 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Find"
            Key             =   "find"
            ImageIndex      =   33
         EndProperty
         BeginProperty Button22 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Caption         =   "Spell Check"
            Key             =   "d"
            ImageIndex      =   31
         EndProperty
      EndProperty
      BorderStyle     =   1
      MouseIcon       =   "MDIForm1.frx":F38C
      OLEDropMode     =   1
   End
   Begin VB.Menu mnufile 
      Caption         =   "&File"
      WindowList      =   -1  'True
      Begin VB.Menu mnunew 
         Caption         =   "New"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuopen 
         Caption         =   "Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuclose 
         Caption         =   "Close"
         Shortcut        =   ^Q
      End
      Begin VB.Menu mnusaveas 
         Caption         =   "Save As"
         Shortcut        =   ^T
      End
      Begin VB.Menu mnusave 
         Caption         =   "Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuexit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu mnuedit 
      Caption         =   "&Edit"
      Begin VB.Menu mnucut 
         Caption         =   "Cut"
         Shortcut        =   +{DEL}
      End
      Begin VB.Menu mnupaste 
         Caption         =   "Paste"
         Shortcut        =   ^V
      End
      Begin VB.Menu mnucopy 
         Caption         =   "Copy"
         Shortcut        =   +{INSERT}
      End
      Begin VB.Menu mnudelete 
         Caption         =   "&Delete"
         Shortcut        =   {DEL}
      End
      Begin VB.Menu mnuselectall 
         Caption         =   "Sellect All"
         Shortcut        =   {F5}
      End
      Begin VB.Menu mnuc 
         Caption         =   "Clear"
         Shortcut        =   ^D
      End
   End
   Begin VB.Menu mnucredite 
      Caption         =   "&Credits"
   End
End
Attribute VB_Name = "MDIForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hWnd As Long, ByVal wMsg As Long, ByVal wParam As Long, ByVal lParam As Any) As Long
Const EM_UNDO = &HC7
Private Declare Function OSWinHelp% Lib "user32" Alias "WinHelpA" (ByVal hWnd&, ByVal HelpFile$, ByVal wCommand%, dwData As Any)

Dim SpellCheck As Object
Public NewText As String
Public Function SpellChecker(Textbox As String) As String
On Error GoTo Errorhandler
 
 Set SpellCheck = CreateObject("Word.Application")      'Set Up Reference To WORD
  SpellCheck.Visible = False                            'Hide WORD From User
  SpellCheck.Documents.Add                              'Open New Document (Hidden)
  Clipboard.Clear
  Clipboard.SetText ActiveForm.rtftext.Text                       'Copy Text To Clipboard
  SpellCheck.Selection.Paste                            'Paste Text Into WORD
  SpellCheck.ActiveDocument.CheckSpelling               'Activate The Spell Checker
  SpellCheck.Visible = False                            'Hide WORD From User
  SpellCheck.ActiveDocument.Select                      'Select The Corrected Text
  SpellCheck.Selection.Cut                              'Cut The Text To Clipboard
  SpellChecker = Clipboard.GetText                      'Assign Text To SPELLCHECKER Function
  SpellCheck.ActiveDocument.Close SaveChanges:= _
   wdDoNotSaveChanges                                   'Close & DO NOT Save Changes
  SpellCheck.Quit                                       'Quit
                              'Release Reference
 Set SpellCheck = Nothing
  NewText = SpellChecker                                'Transfer Spell Checker Results
 

Exit Function    'Exit To Avoid ErrorHandler.

Errorhandler:
  SpellCheck.ActiveDocument.Close SaveChanges:= _
   wdDoNotSaveChanges                                   'Close & DO NOT Save Changes
  SpellCheck.Quit                                       'Quit
 Set SpellCheck = Nothing
 
 MsgBox "Error: " & Err.Number & "  " & Err.Description, vbExclamation, "School Report Card Spell Check Error"

End Function

Private Sub LoadNewDoc()
    Static lDocument As Long
    Dim frmD As Form1
    lDocument = lDocument + 1
    Set frmD = New Form1
    frmD.Caption = "Document " & lDocument
    frmD.Show
End Sub
Private Sub MDIForm_Load()
   Me.Left = GetSetting(App.Title, "Settings", "MainLeft", 1000)
    Me.Top = GetSetting(App.Title, "Settings", "MainTop", 1000)
    Me.Width = GetSetting(App.Title, "Settings", "MainWidth", 6500)
    Me.Height = GetSetting(App.Title, "Settings", "MainHeight", 6500)
End Sub
Private Sub mnuc_Click()
  ActiveForm.rtftext = " "
End Sub
Private Sub mnuclose_Click()
If MsgBox("Do You Whant To Save Changes?", vbYesNo) = vbYes Then
 mnusaveas_Click
   Else
Unload ActiveForm
End If

End Sub
Private Sub mnucopy_Click()
   On Error Resume Next
 Clipboard.SetText ActiveForm.rtftext.SelRTF
      
End Sub

Private Sub mnucredite_Click()
Form2.Show 1
End Sub

Private Sub mnucut_Click()
   On Error Resume Next
 Clipboard.SetText ActiveForm.rtftext.SelRTF
 ActiveForm.rtftext.SelText = vbNullString
 End Sub
Private Sub mnudelete_Click()
 ActiveForm.rtftext.SelRTF = ""
End Sub
Private Sub mnuexit_Click()

If MsgBox("Do You Whant To Save Changes?", vbYesNo) = vbYes Then
 mnusaveas_Click
   Else
End
End If
End Sub
Private Sub mnunew_Click()
LoadNewDoc
End Sub
Private Sub mnuopen_Click()
   Dim sFile As String
    If ActiveForm Is Nothing Then LoadNewDoc
     With dlgCommonDialog
        .DialogTitle = "Open"
        .CancelError = False
        .Filter = "All Files (*.*)|*.*"
        .ShowOpen
        If Len(.FileName) = 0 Then
            Exit Sub
        End If
        sFile = .FileName
    End With
    ActiveForm.rtftext.LoadFile sFile
    ActiveForm.Caption = sFile
End Sub
Private Sub mnupaste_Click()
  On Error Resume Next
      ActiveForm.rtftext.SelRTF = Clipboard.GetText
End Sub
Private Sub mnusaveas_Click()
    Dim sFile As String
    If ActiveForm Is Nothing Then Exit Sub
     With dlgCommonDialog
        .DialogTitle = "Save As"
        .CancelError = False
        .Filter = "All Files (*.*)|*.*"
        .ShowSave
        If Len(.FileName) = 0 Then
            Exit Sub
        End If
        sFile = .FileName
    End With
    ActiveForm.Caption = sFile
    ActiveForm.rtftext.SaveFile sFile
End Sub
Private Sub mnusave_Click()
    Dim sFile As String
    If Left$(ActiveForm.Caption, 5) = "Form1" Then
        With dlgCommonDialog
            .DialogTitle = "Save"
            .CancelError = False
            .Filter = "All Files (*.*)|*.*"
            .ShowSave
            If Len(.FileName) = 0 Then
                Exit Sub
            End If
            sFile = .FileName
        End With
        ActiveForm.rtftext.SaveFile sFile
    Else
        sFile = ActiveForm.Caption
        ActiveForm.rtftext.SaveFile sFile
    End If
End Sub
Private Sub mnuselectall_Click()
  ActiveForm.rtftext.SelStart = 0
  ActiveForm.rtftext.SelLength = Len(ActiveForm.rtftext.Text)
  ActiveForm.rtftext.SetFocus
End Sub

Private Sub StatusBar1_PanelClick(ByVal Panel As MSComctlLib.Panel)

End Sub

Private Sub tbToolbar_ButtonClick(ByVal Button As MSComctlLib.Button)
  On Error Resume Next
  Select Case Button.Key
    Case "bold"
            ActiveForm.rtftext.SelBold = Not ActiveForm.rtftext.SelBold
            Button.Value = IIf(ActiveForm.rtftext.SelBold, tbrPressed, tbrUnpressed)
    Case "i"
            ActiveForm.rtftext.SelItalic = Not ActiveForm.rtftext.SelItalic
            Button.Value = IIf(ActiveForm.rtftext.SelItalic, tbrPressed, tbrUnpressed)
    Case "u"
            ActiveForm.rtftext.SelUnderline = Not ActiveForm.rtftext.SelUnderline
            Button.Value = IIf(ActiveForm.rtftext.SelUnderline, tbrPressed, tbrUnpressed)
    Case "copy"
            mnucopy_Click
    Case "cut"
            mnucut_Click
    Case "paste"
            mnupaste_Click
    Case "size"
            ActiveForm.rtftext.SelFontSize = InputBox("enter size")
  Case "all"
           mnuselectall_Click
    Case "del"
           mnudelete_Click
    Case "end"
          ActiveForm.rtftext.SelStart = Len(ActiveForm.rtftext.Text)
          ActiveForm.rtftext.SetFocus
    Case "home"
           ActiveForm.rtftext.SelStart = 0
    Case "left"
           ActiveForm.rtftext.SelAlignment = rtfLeft
    Case "center"
           ActiveForm.rtftext.SelAlignment = rtfCenter
    Case "right"
           ActiveForm.rtftext.SelAlignment = rtfRight
    Case "clear"
           mnuc_Click
    Case "open"
           mnuopen_Click
    Case "save"
          mnusaveas_Click
    Case "new"
          LoadNewDoc
    Case "color"
           dlgCommonDialog.ShowColor
           ActiveForm.rtftext.SelColor = dlgCommonDialog.Color
    Case "close"
            mnuclose_Click
    Case "find"
          Dim X As Integer, Y As String
          Y = InputBox("find", "input")
          X = InStr(ActiveForm.rtftext.Text, Y)
         If X <> 0 Then
   
          ActiveForm.rtftext.SelStart = X - 1
              Do While X > 0
             ActiveForm.rtftext.SelLength = Len(Y)
             ActiveForm.rtftext.SetFocus
           X = X - 1
               Loop
           Else
          MsgBox ("Word Not Found")
           End If
           Case "d"
                 Dim Textbox As String
Dim msg As String
 If ActiveForm.rtftext.Text <> "" Then
  msg = "Spell Checker requires that you have Microsoft WORD 97 or later installed on your system."
  msg = msg + Chr(13) + ""
  msg = msg + "Running Spell Checker on a system without WORD could result in unpredictable behaviour."
  msg = msg + Chr(13)
  msg = msg + Chr(13) + "If you are running Spell Checker for the first time"
  msg = msg + " or if you DO NOT have WORD"
  msg = msg + Chr(13) + "installed on your system it is recommended that you Save your report "
  msg = msg + "before you continue."
  msg = msg + Chr(13)
  msg = msg + Chr(13) + Space(33) + "Are You Sure You Want To Continue?"

   If MsgBox(msg, vbYesNo + vbInformation, "School Report Card Spell Checker") = vbYes Then
    Textbox = ActiveForm.rtftext.Text                       'Assign Contens Of TextBox To Variable "TextBox"
    SpellChecker (Textbox)                     'Call SpellChecking Function ~ Transfer variable
  ActiveForm.rtftext.Text = NewText                       'Ammend Textbox To Resulting Text From Function
   MsgBox "Spell Check Completed", vbOKOnly + vbInformation, "Spell Checker"
   End If
 End If
 
      End Select
End Sub
