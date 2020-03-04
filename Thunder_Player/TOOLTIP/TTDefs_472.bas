Attribute VB_Name = "mTooltipDefs_472"
Option Explicit
'
' Copyright © 1997-1999 Brad Martinez, http://www.mvps.org
'
' ========================================================================
' private tooltip related window definitions

' can also be set in the make tab of the Project Properties dialog
#Const WIN32_IE = &H400   ' 1024

Private Const WM_USER = &H400

Private Type POINTAPI   ' pt
  x As Long
  y As Long
End Type

Private Type RECT   ' rct
  Left As Long
  Top As Long
  Right As Long
  Bottom As Long
End Type

' The NMHDR structure contains information about a notification message. The pointer
' to this structure is specified as the lParam member of the WM_NOTIFY message.
Private Type NMHDR
  hwndFrom As Long   ' Window handle of control sending message
  idFrom As Long        ' Identifier of control sending message
  code  As Long          ' Specifies the notification code
End Type

' ========================================================================
' tooltip definitions

Public Const TOOLTIPS_CLASS = "tooltips_class32"

' Styles
Public Const TTS_ALWAYSTIP = &H1
Public Const TTS_NOPREFIX = &H2

Public Type TOOLINFO
  cbSize As Long
  uFlags As TT_Flags
  hWnd As Long
  uId As Long
  RECT As RECT
  hinst As Long
  lpszText As String   ' Long
#If (WIN32_IE >= &H300) Then
  lParam As Long
#End If
End Type   ' TOOLINFO

Public Enum TT_Flags
  TTF_IDISHWND = &H1
  TTF_CENTERTIP = &H2
  TTF_RTLREADING = &H4
  TTF_SUBCLASS = &H10
#If (WIN32_IE >= &H300) Then
  TTF_TRACK = &H20
  TTF_ABSOLUTE = &H80
  TTF_TRANSPARENT = &H100
  TTF_DI_SETITEM = &H8000&        ' valid only on the TTN_NEEDTEXT callback
#End If     ' WIN32_IE >= =&H0300
End Enum   ' TT_Flags

Public Enum TT_DelayTime
  TTDT_AUTOMATIC = 0
  TTDT_RESHOW = 1
  TTDT_AUTOPOP = 2
  TTDT_INITIAL = 3
End Enum

Public Type TTHITTESTINFO
  hWnd As Long
  pt As POINTAPI
  ti As TOOLINFO
End Type

' ========================================================================
' messages

Public Enum TT_Msgs
  TTM_ACTIVATE = (WM_USER + 1)
  TTM_SETDELAYTIME = (WM_USER + 3)
  TTM_RELAYEVENT = (WM_USER + 7)
  TTM_GETTOOLCOUNT = (WM_USER + 13)
  TTM_WINDOWFROMPOINT = (WM_USER + 16)
    
#If UNICODE Then
  TTM_ADDTOOL = (WM_USER + 50)
  TTM_DELTOOL = (WM_USER + 51)
  TTM_NEWTOOLRECT = (WM_USER + 52)
  TTM_GETTOOLINFO = (WM_USER + 53)
  TTM_SETTOOLINFO = (WM_USER + 54)
  TTM_HITTEST = (WM_USER + 55)
  TTM_GETTEXT = (WM_USER + 56)
  TTM_UPDATETIPTEXT = (WM_USER + 57)
  TTM_ENUMTOOLS = (WM_USER + 58)
  TTM_GETCURRENTTOOL = (WM_USER + 59)
#Else
  TTM_ADDTOOL = (WM_USER + 4)
  TTM_DELTOOL = (WM_USER + 5)
  TTM_NEWTOOLRECT = (WM_USER + 6)
  TTM_GETTOOLINFO = (WM_USER + 8)
  TTM_SETTOOLINFO = (WM_USER + 9)
  TTM_HITTEST = (WM_USER + 10)
  TTM_GETTEXT = (WM_USER + 11)
  TTM_UPDATETIPTEXT = (WM_USER + 12)
  TTM_ENUMTOOLS = (WM_USER + 14)
  TTM_GETCURRENTTOOL = (WM_USER + 15)
#End If   ' UNICODE

#If (WIN32_IE >= &H300) Then
  TTM_TRACKACTIVATE = (WM_USER + 17)       ' wParam = TRUE/FALSE start end  lparam = LPTOOLINFO
  TTM_TRACKPOSITION = (WM_USER + 18)       ' lParam = dwPos
  TTM_SETTIPBKCOLOR = (WM_USER + 19)
  TTM_SETTIPTEXTCOLOR = (WM_USER + 20)
  TTM_GETDELAYTIME = (WM_USER + 21)
  TTM_GETTIPBKCOLOR = (WM_USER + 22)
  TTM_GETTIPTEXTCOLOR = (WM_USER + 23)
  TTM_SETMAXTIPWIDTH = (WM_USER + 24)
  TTM_GETMAXTIPWIDTH = (WM_USER + 25)
  TTM_SETMARGIN = (WM_USER + 26)           ' lParam = lprc
  TTM_GETMARGIN = (WM_USER + 27)           ' lParam = lprc
  TTM_POP = (WM_USER + 28)
#End If   ' (WIN32_IE >= &H300)

#If (WIN32_IE >= &H400) Then
  TTM_UPDATE = (WM_USER + 29)
#End If
End Enum   ' TT_Msgs

' ========================================================================
' notifications

Public Enum TT_Notifications
  TTN_FIRST = -520&   '   (0U-520U)
  TTN_LAST = -549&    '   (0U-549U)
#If UNICODE Then
  TTN_NEEDTEXT = (TTN_FIRST - 10)   ' is now TTN_GETDISPINFO
#Else
  TTN_NEEDTEXT = (TTN_FIRST - 0)
#End If   ' UNICODE
  TTN_SHOW = (TTN_FIRST - 1)
  TTN_POP = (TTN_FIRST - 2)
End Enum   ' TT_Notifications

Public Type NMTTDISPINFO
  hdr As NMHDR
  lpszText As Long
#If UNICODE Then
  szText As String * 160
#Else
  szText As String * 80
#End If   ' UNICODE
  hinst As Long
  uFlags As Long
#If (WIN32_IE >= &H300) Then
  lParam As Long
#End If
End Type   ' NMTTDISPINFO
