VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "shdocvw.dll"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{38911DA0-E448-11D0-84A3-00DD01104159}#1.1#0"; "COMCT332.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form frmKool 
   Caption         =   "Developer IQ Browser"
   ClientHeight    =   6780
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   10305
   HasDC           =   0   'False
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6780
   ScaleWidth      =   10305
   StartUpPosition =   2  'CenterScreen
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   960
      Top             =   4320
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin MSComDlg.CommonDialog Com 
      Left            =   240
      Top             =   4320
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Frame Frame1 
      Height          =   265
      Left            =   0
      TabIndex        =   15
      Top             =   5040
      Width           =   7275
      Begin MSComctlLib.StatusBar StatusBar1 
         Height          =   270
         Left            =   0
         TabIndex        =   17
         Top             =   0
         Width           =   5895
         _ExtentX        =   10398
         _ExtentY        =   476
         _Version        =   393216
         BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
            NumPanels       =   3
            BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               AutoSize        =   1
               Object.Width           =   6617
               MinWidth        =   2
            EndProperty
            BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               Style           =   5
               Object.Width           =   1940
               MinWidth        =   1940
               TextSave        =   "3:31 PM"
            EndProperty
            BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
               AutoSize        =   2
               Object.Width           =   1773
               MinWidth        =   1764
            EndProperty
         EndProperty
      End
      Begin MSComctlLib.ProgressBar ProgressBar1 
         Height          =   255
         Left            =   5880
         TabIndex        =   16
         Top             =   0
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   450
         _Version        =   393216
         Appearance      =   1
         Scrolling       =   1
      End
   End
   Begin MSComctlLib.ImageList ImageList2 
      Left            =   5400
      Top             =   2160
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":030A
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":0624
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":093E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":0C58
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":0F72
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":128C
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":15A6
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":18C0
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":1BDA
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4680
      Top             =   2160
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   16
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":202C
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":2346
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":2660
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":297A
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":2C94
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":2FAE
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":32C8
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":35E2
            Key             =   ""
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":38FC
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.VScrollBar VScroll2 
      Height          =   30
      Left            =   9720
      TabIndex        =   0
      Top             =   6840
      Visible         =   0   'False
      Width           =   375
   End
   Begin ComCtl3.CoolBar cbrBrowser 
      Height          =   750
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   9135
      _ExtentX        =   16113
      _ExtentY        =   1323
      BandCount       =   2
      _CBWidth        =   9135
      _CBHeight       =   750
      _Version        =   "6.0.8141"
      Child1          =   "Toolbar1"
      MinHeight1      =   330
      Width1          =   5010
      NewRow1         =   0   'False
      AllowVertical1  =   0   'False
      Caption2        =   "Address"
      Child2          =   "tbrUrl"
      MinHeight2      =   330
      Width2          =   6195
      NewRow2         =   -1  'True
      AllowVertical2  =   0   'False
      Begin MSComctlLib.Toolbar tbrUrl 
         Height          =   330
         Left            =   795
         TabIndex        =   3
         Top             =   390
         Width           =   8250
         _ExtentX        =   14552
         _ExtentY        =   582
         ButtonWidth     =   1138
         ButtonHeight    =   582
         Style           =   1
         TextAlignment   =   1
         _Version        =   393216
         Begin VB.ComboBox cmbUrl 
            Height          =   315
            Left            =   0
            TabIndex        =   5
            Top             =   0
            Width           =   1215
         End
         Begin MSComctlLib.Toolbar tbrGo 
            Height          =   330
            Left            =   5640
            TabIndex        =   4
            Top             =   0
            Width           =   975
            _ExtentX        =   1720
            _ExtentY        =   582
            ButtonWidth     =   1296
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "GO  "
                  Key             =   "go"
                  Object.ToolTipText     =   "Go to Website"
                  ImageIndex      =   9
               EndProperty
            EndProperty
         End
      End
      Begin MSComctlLib.Toolbar Toolbar1 
         Height          =   330
         Left            =   165
         Negotiate       =   -1  'True
         TabIndex        =   6
         Top             =   30
         Width           =   8880
         _ExtentX        =   15663
         _ExtentY        =   582
         ButtonWidth     =   1455
         ButtonHeight    =   582
         Wrappable       =   0   'False
         Style           =   1
         TextAlignment   =   1
         _Version        =   393216
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   7
            Left            =   6650
            TabIndex        =   14
            Top             =   0
            Width           =   825
            _ExtentX        =   1455
            _ExtentY        =   582
            ButtonWidth     =   1349
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Print "
                  Key             =   "print"
                  Object.ToolTipText     =   "Print"
                  ImageIndex      =   8
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   6
            Left            =   5520
            TabIndex        =   13
            Top             =   0
            Width           =   1125
            _ExtentX        =   1984
            _ExtentY        =   582
            ButtonWidth     =   1931
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Favorites "
                  Key             =   "favorites"
                  Object.ToolTipText     =   "Favorites"
                  ImageIndex      =   7
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   2
            Left            =   1920
            TabIndex        =   12
            Top             =   0
            Width           =   780
            _ExtentX        =   1376
            _ExtentY        =   582
            ButtonWidth     =   1376
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Stop "
                  Key             =   "stop"
                  Object.ToolTipText     =   "Stop"
                  ImageIndex      =   3
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   3
            Left            =   2760
            TabIndex        =   11
            Top             =   0
            Width           =   1020
            _ExtentX        =   1799
            _ExtentY        =   582
            ButtonWidth     =   1773
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Refresh "
                  Key             =   "refresh"
                  Object.ToolTipText     =   "Refresh"
                  ImageIndex      =   4
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   4
            Left            =   3720
            TabIndex        =   10
            Top             =   0
            Width           =   855
            _ExtentX        =   1508
            _ExtentY        =   582
            ButtonWidth     =   1535
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Home "
                  Key             =   "home"
                  Object.ToolTipText     =   "Home"
                  ImageIndex      =   5
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   5
            Left            =   4580
            TabIndex        =   9
            Top             =   0
            Width           =   945
            _ExtentX        =   1667
            _ExtentY        =   582
            ButtonWidth     =   1693
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Search "
                  Key             =   "search"
                  Object.ToolTipText     =   "Search"
                  ImageIndex      =   6
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   1
            Left            =   835
            TabIndex        =   8
            Top             =   0
            Width           =   1095
            _ExtentX        =   1931
            _ExtentY        =   582
            ButtonWidth     =   1799
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Forward "
                  Key             =   "forward"
                  Object.ToolTipText     =   "Go Forward"
                  ImageIndex      =   2
               EndProperty
            EndProperty
         End
         Begin MSComctlLib.Toolbar Toolbar2 
            Height          =   330
            Index           =   0
            Left            =   0
            TabIndex        =   7
            Top             =   0
            Width           =   855
            _ExtentX        =   1508
            _ExtentY        =   582
            ButtonWidth     =   1535
            ButtonHeight    =   582
            Style           =   1
            TextAlignment   =   1
            ImageList       =   "ImageList1"
            HotImageList    =   "ImageList2"
            _Version        =   393216
            BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
               NumButtons      =   1
               BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
                  Caption         =   "Back  "
                  Key             =   "back"
                  Object.ToolTipText     =   "Go Back"
                  ImageIndex      =   1
               EndProperty
            EndProperty
         End
      End
   End
   Begin SHDocVwCtl.WebBrowser WebBrowser 
      Height          =   2895
      Left            =   0
      TabIndex        =   1
      Top             =   720
      Width           =   3975
      ExtentX         =   7011
      ExtentY         =   5106
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   1
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuFileNew 
         Caption         =   "New Window"
      End
      Begin VB.Menu mnuFileOpen 
         Caption         =   "Open"
      End
      Begin VB.Menu mnuFileSave 
         Caption         =   "Save"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuFileSaveAs 
         Caption         =   "Save As"
      End
      Begin VB.Menu sep 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFilepagesetup 
         Caption         =   "Page Setup"
      End
      Begin VB.Menu mnuFilePrint 
         Caption         =   "Print"
      End
      Begin VB.Menu mnuFilePrintPreview 
         Caption         =   "Print Preview"
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileProperties 
         Caption         =   "Properties"
      End
      Begin VB.Menu mnuFileWorkOffline 
         Caption         =   "Work Offline"
      End
      Begin VB.Menu mnuFileClose 
         Caption         =   "Close"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Edit"
      Begin VB.Menu mnuEditCut 
         Caption         =   "Cut"
      End
      Begin VB.Menu mnuEditCopy 
         Caption         =   "Copy"
      End
      Begin VB.Menu mnuEditPaste 
         Caption         =   "Paste"
      End
      Begin VB.Menu sep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSelectAll 
         Caption         =   "Select All"
      End
   End
   Begin VB.Menu mnuview 
      Caption         =   "&View"
      Begin VB.Menu mnuViewToolbars 
         Caption         =   "Toolbars"
         Begin VB.Menu mnuViewToolbarsStandard 
            Caption         =   "Standard Buttons"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuViewToolbarsAdress 
            Caption         =   "Adress Bar"
            Checked         =   -1  'True
         End
      End
      Begin VB.Menu mnuViewStatusBar 
         Caption         =   "Status Bar"
         Checked         =   -1  'True
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuViewGoTo 
         Caption         =   "Go To"
         Begin VB.Menu mnuViewGoToBack 
            Caption         =   "Back"
         End
         Begin VB.Menu mnuViewGoToForward 
            Caption         =   "Forward"
         End
         Begin VB.Menu sep4 
            Caption         =   "-"
         End
         Begin VB.Menu mnuViewGoToHome 
            Caption         =   "Home Page"
         End
         Begin VB.Menu mnuViewGoToSearch 
            Caption         =   "Search"
         End
      End
      Begin VB.Menu mnuViewStop 
         Caption         =   "Stop"
      End
      Begin VB.Menu mnuViewRefresh 
         Caption         =   "Refresh"
      End
      Begin VB.Menu sep7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuViewSource 
         Caption         =   "Source"
      End
      Begin VB.Menu mnuviewFullScreen 
         Caption         =   "Full Screen"
      End
   End
   Begin VB.Menu mnuFavorites 
      Caption         =   "&Favorites"
      Begin VB.Menu mnuFavoritesAdd 
         Caption         =   "Add to Favorites"
      End
      Begin VB.Menu sep8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFavoritesView 
         Caption         =   "View Favorites"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuHelpAbout 
         Caption         =   "Developer IQ Browser"
      End
   End
   Begin VB.Menu mnuFav 
      Caption         =   "Fav"
      Begin VB.Menu mnuFavAdd 
         Caption         =   "Add"
      End
      Begin VB.Menu sep11 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFavView 
         Caption         =   "View"
      End
   End
   Begin VB.Menu exit 
      Caption         =   "Exit"
   End
   Begin VB.Menu developer 
      Caption         =   "Developeriq"
   End
End
Attribute VB_Name = "frmKool"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim a
Dim blnFull As Boolean
Dim OriginalFormTitle As String

Private Sub cbrBrowser_HeightChanged(ByVal NewHeight As Single)

'******************************************************
    'Resize the Browser when the coolbar height changes
    Not_Toolbars
    Not_Statusbar
    Form_Resize
'******************************************************
End Sub

Private Sub cmbUrl_KeyPress(KeyAscii As Integer)

'******************************************************
    On Error Resume Next
    
    'Navigate to the Url typed when the return key _
    is pressed
    If KeyAscii = vbKeyReturn Then
        WebBrowser.Navigate (cmbUrl.Text)
        cmbUrl.AddItem (cmbUrl.Text)
    End If
'******************************************************
End Sub

Private Sub developer_Click()
 On Error Resume Next
    'Navigate when the button is pressed
    'Select Case Button.Key
    
    'Case "go"
        WebBrowser.Navigate ("www.developeriq.com")
        'WebBrowser.Navigate (cmbUrl.Text)
        'cmbUrl.AddItem (cmbUrl.Text)
    'End Select
End Sub

Private Sub exit_Click()
End
End Sub

Private Sub Form_Load()
        
'******************************************************
    'Set mnuFav to not visible because it will be use _
    as a popup menu
    mnuFav.Visible = False
    
    'Set the with, left and height for some controls _
    so they won't be changed
    ProgressBar1.Width = 1500
    StatusBar1.Panels(3).Text = "Online"

    Toolbar2(0).Width = 855
    Toolbar2(1).Width = 1095
    Toolbar2(2).Width = 781
    Toolbar2(3).Width = 1021
    Toolbar2(4).Width = 855
    Toolbar2(5).Width = 945
    Toolbar2(6).Width = 1130
    Toolbar2(7).Width = 825

    Toolbar2(0).Left = 0
    Toolbar2(1).Left = 835
    Toolbar2(2).Left = 1910
    Toolbar2(3).Left = 2700
    Toolbar2(4).Left = 3720
    Toolbar2(5).Left = 4580
    Toolbar2(6).Left = 5520
    Toolbar2(7).Left = 6650
    
    With tbrGo
        .Width = 735
        .Left = 5880
        .Height = 330
    End With
    
    Frame1.Height = 265
    ProgressBar1.Height = 255
    ProgressBar1.Top = 15
    
    OriginalFormTitle = Me.Caption
    
    'This boolean will help me return the browser back _
    to normal view when it is in full screen mode and _
    the "restore window" button is pressed
    blnFull = False
    
    'Go to home page
    WebBrowser.GoHome
'******************************************************
End Sub

Private Sub Form_Resize()

'******************************************************
    On Error Resume Next

'Check if the full screen option is checked so it can _
resize the form and the browser
If mnuviewFullScreen.Checked = True Then
    WebBrowser.Height = Me.ScaleHeight
    WebBrowser.Width = Me.ScaleWidth
    WebBrowser.Top = Me.ScaleTop
    mnuviewFullScreen.Checked = False
    blnFull = True
    
'Check if blnFull is true then the form resizes back to _
normal
ElseIf blnFull = True Then
    Not_FullScreen
    Form_Resize0
    blnFull = False
    Me.WindowState = 2
    
Else
    'check if the statusbar check isn't checked so the _
    form resized with out the statusbar
    If mnuViewStatusBar.Checked = False Then
        
        'check to see if neither toolbar check is _
        checked and the statusbar check isn't checked _
        so the form will resize with none of them
        If mnuViewToolbarsStandard.Checked = False And _
            mnuViewToolbarsAdress.Checked = False Then
            Not_StatusbarorToolbars
        Else
            'Resize without statusbar
            Not_Statusbar
        End If
        
    Else
            
    
            If mnuViewToolbarsStandard.Checked = False Then
                
                'Resize the form with out any toolbar or the _
                statusbar
                If mnuViewToolbarsAdress.Checked = False Then
                Not_BothToolbars
                
                Else
                'As long as one toolbar is visible it doesn't _
                matter wich one it is
                Not_Toolbars
                End If
    
            Else
            'Resize with both toolbars and without the _
            statusbar
            Form_Resize1
            End If
    
    End If
    'Default resize
    Form_Resize0
End If
'******************************************************
End Sub

Private Sub Form_Unload(Cancel As Integer)

'******************************************************
    On Error Resume Next
    'Unload frmFav and frmAbout when the browser is closed
    Unload frmFav
    Unload frmAbout
'******************************************************
End Sub

Private Sub kishore_Click()
a = "www.developeriq.com"

  cmbUrl.AddItem (cmbUrl.Text)
End Sub

Private Sub mnuEditCopy_Click()

'******************************************************
    On Error Resume Next
    'Copy selected text/picture etc...
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_COPY, OLECMDEXECOPT_DODEFAULT
'******************************************************
End Sub

Private Sub mnuEditCut_Click()
    
'******************************************************
    On Error Resume Next
    'Cut selected text/picture etc... only if it's not _
    read only
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_CUT, OLECMDEXECOPT_DODEFAULT
'******************************************************
End Sub

Private Sub mnuEditPaste_Click()

'******************************************************
    On Error Resume Next
    'Paste on selected area
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_PASTE, OLECMDEXECOPT_DODEFAULT
'******************************************************
End Sub

Private Sub mnuFavAdd_Click()

'******************************************************
    'Add current webpage to favorites list
    Dim add
    add = cmbUrl.Text
        If add = "" Then
        add = InputBox("Enter website you wish to add to favorites", "Add", "www.")
            If add = "" Then
                Exit Sub
            End If
        Else
                frmFav.List1.AddItem (add)
            
        End If
'*******************************************************
End Sub

Private Sub mnuFavoritesAdd_Click()

'*******************************************************
    'Add current webpage to favorites list
    mnuFavAdd_Click
'*******************************************************
End Sub

Private Sub mnuFavoritesView_Click()
    
'*******************************************************
    'Display frmFav
    frmFav.Show
'*******************************************************
End Sub

Private Sub mnuFavView_Click()
    
'*******************************************************
    'Display frmFav
    frmFav.Show
'*******************************************************
End Sub

Private Sub mnuFileNew_Click()

'*******************************************************
    'Display a new frmKool
    Dim F As Form
        Set F = New frmKool
        F.Show
'*******************************************************
End Sub

Private Sub mnuFileOpen_Click()

'*******************************************************
    On Error Resume Next
    'Open html files
        Com.Filter = "All Internet Files (*.hmt,*.html,*.asp,*.shtml,*.js,*.dhtml) | *.htm;*.html;*.asp;*.shtml;*.js;*.dhtml"
        Com.ShowOpen
    If Com.Filename = "" Then
        Exit Sub
    Else
        WebBrowser.Navigate (Com.Filename)
    End If
'*******************************************************
End Sub

Private Sub mnuFilepagesetup_Click()

'*******************************************************
    On Error Resume Next
    'call page setup function
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_PAGESETUP, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuFilePrint_Click()

'*******************************************************
    On Error Resume Next
    'Print current page
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_PRINT, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuFilePrintPreview_Click()

'*******************************************************
    On Error Resume Next
    'Call the print preview function
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuFileProperties_Click()

'*******************************************************
    On Error Resume Next
    'View Properties of current page
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_PROPERTIES, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuFileSave_Click()

'*******************************************************
    On Error Resume Next
    'Save page(it's disabled cause you really don't use it _
    you always use save as for webpages
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_SAVE, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuFileSaveAs_Click()

'*******************************************************
    On Error Resume Next
    'Save current page as
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_SAVEAS, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuFileWorkOffline_Click()

'******************************************************
    'Change work modes
    If mnuFileWorkOffline.Checked = False Then
        WebBrowser.Offline = True
        StatusBar1.Panels(3).Text = "Offline"
        StatusBar1.Panels(1).Text = "You can now work offline"
        mnuFileWorkOffline.Checked = True
    Else
        WebBrowser.Offline = False
        StatusBar1.Panels(3).Text = "Online"
        StatusBar1.Panels(1).Text = ""
        mnuFileWorkOffline.Checked = False
    End If
'*******************************************************
End Sub

Private Sub mnuHelpAbout_Click()

'*******************************************************
    'Show frmAbout
    frmAbout.Show vbModal
'*******************************************************
End Sub

Private Sub mnuSelectAll_Click()

'*******************************************************
    On Error Resume Next
    'Select all webpage
    WebBrowser.SetFocus
    WebBrowser.ExecWB OLECMDID_SELECTALL, OLECMDEXECOPT_DODEFAULT
'*******************************************************
End Sub

Private Sub mnuviewFullScreen_Click()

'*******************************************************
    'Hide coolbar, and Frame1
    cbrBrowser.Visible = False
    Frame1.Visible = False
    mnuviewFullScreen.Checked = True
    
    'Hide all menus
    mnuFile.Visible = False
    mnuEdit.Visible = False
    mnuview.Visible = False
    mnuFavorites.Visible = False
    mnuHelp.Visible = False
    Me.WindowState = 2
'*******************************************************
End Sub

Private Sub mnuViewGoToBack_Click()

'*******************************************************
    On Error Resume Next
    'Go to previous page
    WebBrowser.GoBack
'*******************************************************
End Sub

Private Sub mnuViewGoToForward_Click()

'*******************************************************
    On Error Resume Next
    'Go to forward
    WebBrowser.GoForward
'*******************************************************
End Sub

Private Sub mnuViewGoToHome_Click()

'*******************************************************
    On Error Resume Next
    'Go to homepage
    WebBrowser.GoHome
'*******************************************************
End Sub

Private Sub mnuViewGoToSearch_Click()

'*******************************************************
    On Error Resume Next
    'Go to msn search engine
    WebBrowser.GoSearch
'*******************************************************
End Sub

Private Sub mnuViewRefresh_Click()

'*******************************************************
    On Error Resume Next
    'Refresh webpage
    WebBrowser.Refresh
'*******************************************************
End Sub

Private Sub mnuViewSource_Click()

'*******************************************************
    On Error Resume Next
    'View source using notepad
    Open App.Path & "/source.tmp" For Output As #1
        Print #1, Inet1.OpenURL(WebBrowser.LocationURL)
    Close #1
        Shell "C:\windows\notepad.exe " & App.Path & "/source.tmp", vbNormalFocus
        Kill App.Path & "/source.tmp"
'*******************************************************
End Sub

Private Sub mnuViewStatusBar_Click()

'*******************************************************
    'check if user wants to see the statusbar if not _
    resize acoordinly
    If mnuViewStatusBar.Checked = True Then
        mnuViewStatusBar.Checked = False
        StatusBar1.Visible = False
        Frame1.Visible = False
        ProgressBar1.Visible = False
        Not_Statusbar
    
    Else
        mnuViewStatusBar.Checked = True
        Frame1.Visible = True
        StatusBar1.Visible = True
        ProgressBar1.Visible = True
        Form_Resize1
                
    End If
    'I put this here so the browser will resize as soon _
    as they check the statusbar check
    Form_Resize
'*******************************************************
End Sub

Private Sub mnuViewStop_Click()

'*******************************************************
    On Error Resume Next
    'Stop loading
    WebBrowser.Stop
'*******************************************************
End Sub

Private Sub mnuViewToolbarsAdress_Click()

'*******************************************************
    'this where I had a few probles I had to check what _
    the user wanted to se and make the form and everythin _
    in it resize acording to that offcourse I could have _
    use different forms for each case, but I would have _
    been to easy and what's the point of that if I'm _
    trying to learn.
    If mnuViewToolbarsStandard.Checked = True Then
    
        If mnuViewToolbarsAdress.Checked = False Then
            mnuViewToolbarsAdress.Checked = True
            cbrBrowser.Bands(2).Visible = True
            Form_Resize1
            
        Else
            mnuViewToolbarsAdress.Checked = False
            cbrBrowser.Bands(2).Visible = False
            Not_Toolbars
            
        End If
            
    Else
    
        If mnuViewToolbarsAdress.Checked = False Then
            mnuViewToolbarsAdress.Checked = True
            cbrBrowser.Visible = True
            cbrBrowser.Bands(1).Visible = False
            cbrBrowser.Bands(2).Visible = True
            Not_Toolbars
            
        Else
            mnuViewToolbarsAdress.Checked = False
            cbrBrowser.Visible = False
            Not_BothToolbars
            
        End If
    End If
    Form_Resize
'*******************************************************
End Sub

Private Sub mnuViewToolbarsStandard_Click()

'*******************************************************
'Continuing from pevious, but now with the other band
    If mnuViewToolbarsAdress.Checked = True Then
    
        If mnuViewToolbarsStandard.Checked = False Then
            mnuViewToolbarsStandard.Checked = True
            cbrBrowser.Bands(1).Visible = True
            Form_Resize1
            
        Else
            mnuViewToolbarsStandard.Checked = False
            cbrBrowser.Bands(1).Visible = False
            Not_Toolbars
                    
        End If
    
    Else
        If mnuViewToolbarsStandard.Checked = False Then
            mnuViewToolbarsStandard.Checked = True
            cbrBrowser.Visible = True
            cbrBrowser.Bands(1).Visible = True
            cbrBrowser.Bands(2).Visible = False
            Not_Toolbars
            
        Else
            mnuViewToolbarsStandard.Checked = False
            cbrBrowser.Visible = False
            Not_BothToolbars
        End If
    End If
      Form_Resize
'*******************************************************
End Sub

Private Sub tbrGo_ButtonClick(ByVal Button As MSComctlLib.Button)

'*******************************************************
    On Error Resume Next
    'Navigate when the button is pressed
    Select Case Button.Key
    
    Case "go"
        WebBrowser.Navigate (cmbUrl.Text)
        cmbUrl.AddItem (cmbUrl.Text)
    End Select
'*******************************************************
End Sub

Private Sub Toolbar2_ButtonClick(index As Integer, ByVal Button As MSComctlLib.Button)
'*******************************************************
    On Error Resume Next
    'I created an array of toolbars for each button cause _
    if I would have used only one each button would be the _
    same size and I don't know any other way to make them _
    different size.
    With WebBrowser
    
    Select Case Button.Key
    
    Case "back"
    .GoBack
     
    Case "forward"
    .GoForward
     
    Case "stop"
    .Stop
     
    Case "refresh"
    .Refresh
    
    Case "home"
    .GoHome
    
    Case "search"
    .GoSearch
    
    Case "print"
    mnuFilePrint_Click
    
    Case "favorites"
    PopupMenu mnuFav
    
    End Select
    End With
'*******************************************************
End Sub

Private Sub WebBrowser_ProgressChange(ByVal Progress As Long, ByVal ProgressMax As Long)

'*******************************************************
    On Error Resume Next
    'Set Prgress bar to the browsers progress
    ProgressBar1.Max = ProgressMax
    ProgressBar1.Value = Progress
    ProgressBar1.Refresh
'*******************************************************
End Sub

Private Sub WebBrowser_StatusTextChange(ByVal Text As String)

'*******************************************************
    On Error Resume Next
    'Display status on statusbar
    StatusBar1.Panels(1).Text = Text
'*******************************************************
End Sub

Private Sub WebBrowser_TitleChange(ByVal Text As String)

'*******************************************************
    'Make the webpages caption display on forms caption
    Me.Caption = OriginalFormTitle & " - " & Text
    cmbUrl.Text = WebBrowser.LocationURL
'*******************************************************
End Sub


Public Sub Form_Resize1()

'*******************************************************
    'set the size of the browser with everything in view
    WebBrowser.Top = Me.ScaleTop + cbrBrowser.Height + 25
    WebBrowser.Height = Me.ScaleHeight - cbrBrowser.Height - StatusBar1.Height - 25
'*******************************************************
End Sub

Public Sub Not_Toolbars()

'*******************************************************
    'set the size of the browser without one toolbar
    WebBrowser.Height = Me.ScaleHeight - cbrBrowser.Height - StatusBar1.Height - 25
    WebBrowser.Top = Me.ScaleTop + cbrBrowser.Height + 25
'*******************************************************
End Sub

Public Sub Not_BothToolbars()
    
'******************************************************
    'set the size of the browser without any of the toolbars
    WebBrowser.Height = Me.ScaleHeight - StatusBar1.Height
    WebBrowser.Top = Me.ScaleTop
'*******************************************************
End Sub

Public Sub Not_Statusbar()

'*******************************************************
    'set the size of the browser without the statusbar
    WebBrowser.Height = Me.ScaleHeight - cbrBrowser.Height - 25
'*******************************************************
End Sub

Public Sub Not_StatusbarorToolbars()

'*******************************************************
    'set the browsers size without the status bar or _
    toolbars
    WebBrowser.Height = Me.ScaleHeight
'*******************************************************
End Sub

Public Sub Not_FullScreen()

'*******************************************************
    'restore to normal view
    mnuFile.Visible = True
    mnuEdit.Visible = True
    mnuview.Visible = True
    mnuFavorites.Visible = True
    mnuHelp.Visible = True
    cbrBrowser.Visible = True
    Frame1.Visible = True
'*******************************************************
End Sub

Public Sub Form_Resize0()

'*******************************************************
    On Error Resume Next
    'set the starting layout for the whole form
    WebBrowser.Width = Me.ScaleWidth
    
    cbrBrowser.Width = Me.ScaleWidth
    cmbUrl.Width = Me.ScaleWidth - tbrGo.Width - 925
    
    tbrGo.Left = cbrBrowser.Width + cbrBrowser.Left - tbrGo.Width - 880
    
    Frame1.Width = Me.ScaleWidth
    Frame1.Top = WebBrowser.Height + WebBrowser.Top - Frame1.Height + 265
    
    
    ProgressBar1.Left = Frame1.Width + Frame1.Left - ProgressBar1.Width
    StatusBar1.Width = Me.ScaleWidth - ProgressBar1.Width
'*******************************************************
End Sub
