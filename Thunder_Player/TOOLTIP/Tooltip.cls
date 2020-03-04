VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "cTooltip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'
' Copyright © 1997-1999 Brad Martinez, http://www.mvps.org
'
' Defaults:
' DelayInitial = 500  (1/2 sec)
' DelayAutoPopup = 5000  (5 secs)
' DelayReshow = 100 (1/10 sec)
' MaxTipWidth = 0
' all Margins = 0

Public Enum ttDelayTimeConstants
  ttDelayDefault = TTDT_AUTOMATIC '= 0
  ttDelayInitial = TTDT_INITIAL '= 3
  ttDelayShow = TTDT_AUTOPOP '= 2
  ttDelayReshow = TTDT_RESHOW '= 1
  ttDelayMask = 3
End Enum

Public Enum ttMarginConstants
  ttMarginLeft = 0
  ttMarginTop = 1
  ttMarginRight = 2
  ttMarginBottom = 3
End Enum

Private m_hwndTT As Long
Private m_cMaxTip As Long
'

' ========================================================================
' public methods

Public Function Create(frm As Form) As Boolean
  
  If (m_hwndTT = 0) Then
    Call InitCommonControls
    
    ' Filling the hwndParent param below allows the tooltip window to
    ' be owned by the specified form and be destroyed along with it,
    ' but we'll cleanup in Class_Terminate anyway.
    ' No WS_EX_TOPMOST or TTS_ALWAYSTIP per Win95 UI rules...
    m_hwndTT = CreateWindowEx(0, TOOLTIPS_CLASS, _
                                                      vbNullString, TTS_ALWAYSTIP, _
                                                      0, 0, _
                                                      0, 0, _
                                                      frm.hWnd, 0, _
                                                      App.hInstance, ByVal 0)
   End If
  
  Create = CBool(m_hwndTT)

End Function

Private Sub Class_Terminate()
  If m_hwndTT Then Call DestroyWindow(m_hwndTT)
End Sub

Public Function AddTool(ctrl As Control, Optional sText As String) As Boolean
  Dim ti As TOOLINFO
  
  If (m_hwndTT = 0) Then Exit Function
  
  If (GetToolInfo(ctrl.hWnd, ti) = False) Then
    With ti
      .cbSize = Len(ti)
      ' TTF_IDISHWND must be specified to tell the tooltip control
      ' to retrieve the control's rect from it's hWnd specified in uId.
      .uFlags = TTF_SUBCLASS Or TTF_IDISHWND
      .hWnd = ctrl.Container.hWnd
      .uId = ctrl.hWnd
      
      If Len(sText) Then
        .lpszText = sText
      Else
        .lpszText = "Tool" & ToolCount + 1
      End If
      
      ' Maintain the maximun tip text length for GetToolInfo
      m_cMaxTip = Max(m_cMaxTip, Len(.lpszText) + 1)
    
    End With
    
    ' Returns 1 on success, 0 on failure
    AddTool = SendMessage(m_hwndTT, TTM_ADDTOOL, 0, ti)
  
  End If   ' GetToolInfo
  
End Function

Public Function RemoveTool(ctrl As Control) As Boolean
  Dim ti As TOOLINFO

  If (m_hwndTT = 0) Then Exit Function
  
  If GetToolInfo(ctrl.hWnd, ti) Then
    Call SendMessage(m_hwndTT, TTM_DELTOOL, 0, ti)   ' no rtn val
    RemoveTool = True
  End If

End Function

' ========================================================================
' public properties

' OLE_COLOR is defined in stdole2.tlb

Public Property Get BackColor() As OLE_COLOR
  If (m_hwndTT = 0) Then Exit Property
  BackColor = SendMessage(m_hwndTT, TTM_GETTIPBKCOLOR, 0, 0)
End Property

Public Property Let BackColor(clr As OLE_COLOR)
  If (m_hwndTT = 0) Then Exit Property
  Call SendMessage(m_hwndTT, TTM_SETTIPBKCOLOR, clr, 0)   ' no rtn val
End Property

Public Property Get DelayTime(dwType As ttDelayTimeConstants) As Long
  If (m_hwndTT = 0) Then Exit Property
  DelayTime = SendMessage(m_hwndTT, TTM_GETDELAYTIME, (dwType And ttDelayMask), 0&)
End Property

Public Property Let DelayTime(dwType As ttDelayTimeConstants, dwMilliSecs As Long)
  If (m_hwndTT = 0) Then Exit Property
  Call SendMessage(m_hwndTT, TTM_SETDELAYTIME, (dwType And ttDelayMask), ByVal dwMilliSecs)  ' no rtn val
End Property

Public Property Get ForeColor() As OLE_COLOR
  If (m_hwndTT = 0) Then Exit Property
  ForeColor = SendMessage(m_hwndTT, TTM_SETTIPTEXTCOLOR, 0, 0)
End Property

Public Property Let ForeColor(clr As OLE_COLOR)
  If (m_hwndTT = 0) Then Exit Property
  Call SendMessage(m_hwndTT, TTM_SETTIPTEXTCOLOR, clr, 0)   ' no rtn val
End Property

Public Property Get hWnd() As Long   ' read-only
  hWnd = m_hwndTT
End Property

Public Property Get Margin(dwType As ttMarginConstants) As Long
  Dim rc As RECT
  
  If (m_hwndTT = 0) Then Exit Property
  
  Call SendMessage(m_hwndTT, TTM_GETMARGIN, 0, rc) ' no rtn val
  Select Case dwType
    Case ttMarginLeft:     Margin = rc.Left
    Case ttMarginTop:     Margin = rc.Top
    Case ttMarginRight:   Margin = rc.Right
    Case ttMarginBottom: Margin = rc.Bottom
  End Select

End Property

Public Property Let Margin(dwType As ttMarginConstants, cPixels As Long)
  Dim rc As RECT
  
  If (m_hwndTT = 0) Then Exit Property
  
  Call SendMessage(m_hwndTT, TTM_GETMARGIN, 0, rc) ' no rtn val
  Select Case dwType
    Case ttMarginLeft:      rc.Left = cPixels
    Case ttMarginTop:      rc.Top = cPixels
    Case ttMarginRight:    rc.Right = cPixels
    Case ttMarginBottom: rc.Bottom = cPixels
  End Select
  Call SendMessage(m_hwndTT, TTM_SETMARGIN, 0, rc) ' no rtn val

End Property

' If MaxTipWidth is -1, there's no word wrapping and text controls chars
' in lpszText are printed and not evaluated (i.e. a vbCrLf shows up as "||")

Public Property Get MaxTipWidth() As Integer
  If (m_hwndTT = 0) Then Exit Property
  MaxTipWidth = LOWORD(SendMessage(m_hwndTT, TTM_GETMAXTIPWIDTH, 0, 0))
End Property

Public Property Let MaxTipWidth(ByVal cx As Integer)
  If (m_hwndTT = 0) Then Exit Property
  If (cx < 1) Then cx = -1
  Call SendMessage(m_hwndTT, TTM_SETMAXTIPWIDTH, 0, ByVal CLng(cx))
End Property

Public Property Get ToolCount() As Integer   ' read-only
  If (m_hwndTT = 0) Then Exit Property
  ToolCount = SendMessage(m_hwndTT, TTM_GETTOOLCOUNT, 0, 0)
End Property

' For the life of me I couldn't get TTM_GETTEXT to work. So
' we'll use the TTM_ENUMTOOLS message in GetToolInfo
' instead, which does retrieve the specifed tool's text... (?)

Public Property Get ToolText(ctrl As Control) As String
  Dim ti As TOOLINFO
  
  If (m_hwndTT = 0) Then Exit Property
  
  If GetToolInfo(ctrl.hWnd, ti, True) Then
    ToolText = GetStrFromBufferA(ti.lpszText)
  End If

End Property

Public Property Let ToolText(ctrl As Control, sText As String)
  Dim ti As TOOLINFO
  
  If (m_hwndTT = 0) Then Exit Property
  
  If GetToolInfo(ctrl.hWnd, ti) Then
    ti.lpszText = sText
    m_cMaxTip = Max(m_cMaxTip, Len(sText) + 1)
    ' The tooltip won't appear for the control if lpszText is an empty string
    Call SendMessage(m_hwndTT, TTM_UPDATETIPTEXT, 0, ti)   ' no rtn val
  End If

End Property

' ========================================================================
' private members

Private Function IsWindow(ctrl As Control) As Boolean
  On Error GoTo Out
  IsWindow = CBool(ctrl.hWnd)
Out:
End Function

Private Function GetToolInfo(hwndTool As Long, _
                                              ti As TOOLINFO, _
                                              Optional fGetText As Boolean = False) As Boolean
  Dim nItems As Integer
  Dim i As Integer
  
  ti.cbSize = Len(ti)
  If fGetText Then ti.lpszText = String$(m_cMaxTip, 0)
    
  nItems = ToolCount
  
  For i = 0 To nItems - 1
    ' call returns 1 on success, 0 on failure...
    If SendMessage(m_hwndTT, TTM_ENUMTOOLS, (i), ti) Then
      If (hwndTool = ti.uId) Then
        GetToolInfo = True
        Exit Function
      End If
    End If
  Next

End Function
