Attribute VB_Name = "Paint"
Public Type BITMAP '14 bytes
        bmType As Long
        bmWidth As Long
        bmHeight As Long
        bmWidthBytes As Long
        bmPlanes As Integer
        bmBitsPixel As Integer
        bmBits As Long
End Type

Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
'Public Declare Function LoadImage Lib "user32" Alias "LoadImageA" (ByVal hInst As Long, ByVal lpsz As String, ByVal un1 As Long, ByVal n1 As Long, ByVal n2 As Long, ByVal un2 As Long) As Long
'Public Declare Function LoadBitmap Lib "user32" Alias "LoadBitmapA" (ByVal hInstance As Long, ByVal lpBitmapName As String) As Long
Public Declare Function CreateBitmap Lib "gdi32" (ByVal nWidth As Long, ByVal nHeight As Long, ByVal nPlanes As Long, ByVal nBitCount As Long, lpBits As Any) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function GetWindowDC Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long
Public Declare Function ReleaseDC Lib "user32" (ByVal hwnd As Long, ByVal hdc As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function GetObject Lib "gdi32" Alias "GetObjectA" (ByVal hObject As Long, ByVal nCount As Long, lpObject As Any) As Long
Public Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Public Declare Function SetBkColor Lib "gdi32" (ByVal hdc As Long, ByVal crColor As Long) As Long
Sub PaintWnd(hwnd As Long, hdc As Long)
Dim Pic As StdPicture
Dim Col As OLE_COLOR

Col = &HC0C0C0

Set Pic = LoadResPicture(101, vsresbitmap)

TransparentBlt hdc, Pic, Pic.Width, Pic.Height, Col
Form31.Picture = Pic

End Sub
Sub TransparentBlt(DestDC As Long, ByVal SrcBmp As Long, ByVal DestX As Long, ByVal DestY As Long, ByVal TransColor As Long)
'--------------------------------------------------------------------------------
'Copy a bitmap transparently to another
'DestDC     : Destpicture.hDC property
'SrcBmp     : Any .picture property
'DestX,Y    : Origin of destination picture
'TransColor : Transparent Color
'--------------------------------------------------------------------------------
Const vbPixel = 3

Dim SrcDC               'source bitmap (color)
Dim SaveDC              'backup copy of source bitmap
Dim MaskDC              'mask bitmap (monochrome)
Dim InvDC               'inverse of mask bitmap (monochrome)
Dim ResultDC            'combination of source bitmap & background
Dim bmp As BITMAP       'Description of the source bitmap
Dim hResultBmp          'Bitmap combination of source & background
Dim hSaveBmp            'Bitmap stores backup copy of source bitmap
Dim hMaskBmp            'Bitmap stores mask (monochrome)
Dim hInvBmp             'Bitmap holds inverse of mask (monochrome)
Dim hPrevBmp            'Bitmap holds previous bitmap selected in DC
Dim hSrcPrevBmp         'Holds previous bitmap in source DC
Dim hSavePrevBmp        'Holds previous bitmap in saved DC
Dim hDestPrevBmp        'Holds previous bitmap in destination DC
Dim hMaskPrevBmp        'Holds previous bitmap in the mask DC
Dim hInvPrevBmp         'Holds previous bitmap in inverted mask DC
Dim OrigColor As Long   'Holds original background color from source DC
Dim Success             'Stores result of call to Windows API

'Retrieve bitmap to get width (bmp.bmWidth) & height (bmp.bmHeight)
Success = GetObject(SrcBmp, Len(bmp), bmp)
'Create DC to hold stages
SrcDC = CreateCompatibleDC(DestDC)
SaveDC = CreateCompatibleDC(DestDC)
MaskDC = CreateCompatibleDC(DestDC)
InvDC = CreateCompatibleDC(DestDC)
ResultDC = CreateCompatibleDC(DestDC)
'Create monochrome bitmaps for the mask-related bitmaps:
hMaskBmp = CreateBitmap(bmp.bmWidth, bmp.bmHeight, 1, 1, ByVal 0&)
hInvBmp = CreateBitmap(bmp.bmWidth, bmp.bmHeight, 1, 1, ByVal 0&)
'Create color bitmaps for final result & stored copy of source
hResultBmp = CreateCompatibleBitmap(DestDC, bmp.bmWidth, bmp.bmHeight)
hSaveBmp = CreateCompatibleBitmap(DestDC, bmp.bmWidth, bmp.bmHeight)
'Select bitmaps in DC
hSrcPrevBmp = SelectObject(SrcDC, SrcBmp)
hSavePrevBmp = SelectObject(SaveDC, hSaveBmp)
hMaskPrevBmp = SelectObject(MaskDC, hMaskBmp)
hInvPrevBmp = SelectObject(InvDC, hInvBmp)
hDestPrevBmp = SelectObject(ResultDC, hResultBmp)
'Make backup of source bitmap to restore later
Success = BitBlt(SaveDC, 0, 0, bmp.bmWidth, bmp.bmHeight, SrcDC, 0, 0, SRCCOPY)
'Create mask: set background color of source to transparent color.
OrigColor = SetBkColor(SrcDC, TransColor)
Success = BitBlt(MaskDC, 0, 0, bmp.bmWidth, bmp.bmHeight, SrcDC, 0, 0, SRCCOPY)
TransColor = SetBkColor(SrcDC, OrigColor)
'Create inverse of mask to AND w/ source & combine w/ background.
Success = BitBlt(InvDC, 0, 0, bmp.bmWidth, bmp.bmHeight, MaskDC, 0, 0, NOTSRCCOPY)
'Copy background bitmap to result & create final transparent bitmap
Success = BitBlt(ResultDC, 0, 0, bmp.bmWidth, bmp.bmHeight, DestDC, DestX, DestY, SRCCOPY)
'AND mask bitmap w/ result DC to punch hole in the background by
'painting black area for non-transparent portion of source bitmap.
Success = BitBlt(ResultDC, 0, 0, bmp.bmWidth, bmp.bmHeight, MaskDC, 0, 0, SRCAND)
'AND inverse mask w/ source bitmap to turn off bits associated
'with transparent area of source bitmap by making it black.
Success = BitBlt(SrcDC, 0, 0, bmp.bmWidth, bmp.bmHeight, InvDC, 0, 0, SRCAND)
'XOR result w/ source bitmap to make background show through.
Success = BitBlt(ResultDC, 0, 0, bmp.bmWidth, bmp.bmHeight, SrcDC, 0, 0, SRCPAINT)
'Display transparent bitmap on backgrnd
Success = BitBlt(DestDC, DestX, DestY, bmp.bmWidth, bmp.bmHeight, ResultDC, 0, 0, SRCCOPY)
Success = BitBlt(SrcDC, 0, 0, bmp.bmWidth, bmp.bmHeight, SaveDC, 0, 0, SRCCOPY) 'Restore backup of bitmap.

'Select orig objects
hPrevBmp = SelectObject(SrcDC, hSrcPrevBmp)
hPrevBmp = SelectObject(SaveDC, hSavePrevBmp)
hPrevBmp = SelectObject(ResultDC, hDestPrevBmp)
hPrevBmp = SelectObject(MaskDC, hMaskPrevBmp)
hPrevBmp = SelectObject(InvDC, hInvPrevBmp)
'Deallocate system resources.
Success = DeleteObject(hSaveBmp)
Success = DeleteObject(hMaskBmp)
Success = DeleteObject(hInvBmp)
Success = DeleteObject(hResultBmp)
Success = DeleteDC(SrcDC)
Success = DeleteDC(SaveDC)
Success = DeleteDC(InvDC)
Success = DeleteDC(MaskDC)
Success = DeleteDC(ResultDC)

End Sub
