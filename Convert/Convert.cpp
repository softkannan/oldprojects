#include "convert.h"
#include "area.h"
#include "Misc.h"
#include "skin.h"

HINSTANCE ghInstance;
HWND gcHwnd;
DLGPROC gfAdr[MAX_NAME]={InfoProc,AnglesProc,AreaProc,AreaForignProc,AstroProc,
DensityProc,EnergyProc,ForceProc,FlowProc,KitchenProc,LengthProc,LengthAnProc,
LengthFnProc,MassProc,MetricPrfxProc,NumbersProc,PowerProc,
PressureProc,SpeedProc,SpringProc,TempProc,TimeConvProc,TorqueProc,TypoProc,
ViscosityProc,VolumeAnProc,VolumeFnProc,WeightProc,WeightAnProc,WeightFnProc,
WeightSpaProc,WineProc,VolumeProc,DiffWorldProc,FrequencyProc,ViscosityDynProc,
ViscosityKinaticProc,AcclProc,IlluminanceProc,LuminanceProc,LengthExProc,AboutProc};

WNDPROC lpfnComboBoxProc = NULL; // original wndproc for the combo box 
WNDPROC lpfnButtonProc = NULL; //Original Button proc
WNDPROC lpfnEditBoxProc = NULL;//Original Edit Box Proc
HBITMAP hCBLeft,hCBCenter,hCBRight;
HBITMAP hDlgBack;
HBRUSH hBrGlobalBk;
CSkin *pSkin;

#pragma warning(disable:4100)

int APIENTRY WinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPSTR     lpCmdLine,
                     int       nCmdShow)
{
    // TODO: Place code here.
  
    
    ghInstance = hInstance;
    DialogBox(hInstance,MAKEINTRESOURCE(IDD_MAINDIALOG),0,(DLGPROC)MainProc);
    return 0;
}

BOOL CALLBACK MainProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
    LPDRAWITEMSTRUCT lpdis; 
    int iDlgIndex;
    switch(msg)
    {
    case WM_INITDIALOG:
        hBrGlobalBk = CreateSolidBrush(COMBO_TEXT_COLOR);
        SetWindowLong(hwnd,GWL_EXSTYLE,WS_EX_APPWINDOW | WS_EX_TOOLWINDOW);
        LoadComboBox(GetDlgItem(hwnd,IDC_NAME),ghInstance);
        gcHwnd=CreateDialog(ghInstance,MAKEINTRESOURCE(IDD_START),hwnd,(DLGPROC)InfoProc);
        ShowWindow(gcHwnd,SW_SHOW);
        SendMessage(GetDlgItem(hwnd,IDC_FRAMEDLG),WM_SETTEXT,0,(LPARAM)"Info");
        hCBLeft = LoadBitmap(ghInstance,MAKEINTRESOURCE(IDB_CBLEFT));
        hCBCenter = LoadBitmap(ghInstance,MAKEINTRESOURCE(IDB_CBCENTER));
        hCBRight = LoadBitmap(ghInstance,MAKEINTRESOURCE(IDB_CBRIGHT));
        hDlgBack = LoadBitmap(ghInstance,MAKEINTRESOURCE(IDB_BACKGROUND));
        pSkin = NULL;
        pSkin = new CSkin(ghInstance,IDB_SKIN);

        lpfnComboBoxProc = (WNDPROC) SetClassLong(GetDlgItem(hwnd,IDC_NAME),GCL_WNDPROC, reinterpret_cast<DWORD>(ComboBoxSubClassProc));  
        SetWindowLong(GetDlgItem(hwnd,IDC_NAME),GWL_WNDPROC, reinterpret_cast<DWORD>(ComboBoxSubClassProc));
        lpfnButtonProc = (WNDPROC) SetClassLong(GetDlgItem(hwnd,IDC_MAINBUTTON),GCL_WNDPROC, reinterpret_cast<DWORD>(ButtonSubClassProc));  
        lpfnEditBoxProc = (WNDPROC) SetClassLong(GetDlgItem(hwnd,IDC_MAINEDIT),GCL_WNDPROC, reinterpret_cast<DWORD>(EditSubClassProc));  

        break;
    case WM_NCLBUTTONDOWN:
        if(wparam == HTCLOSE)
        {
            PostQuitMessage(0);
            return TRUE;
        }
        break;
    case WM_SYSCOMMAND:
        if(wparam == SC_CLOSE)
        {
            PostQuitMessage(0);
            return TRUE;
        }
        break;
    case WM_UNKNOWN_MSG:
    case WM_NCACTIVATE:
    case WM_NCPAINT:
        {
            pSkin->DrawSkin(hwnd);
        }
        return TRUE;
    case WM_DRAWITEM: 
        {
            lpdis = (LPDRAWITEMSTRUCT) lparam; 
            if(lpdis->CtlType == ODT_COMBOBOX)
            {
                if(lpdis->CtlID == IDC_NAME)
                {
                    CHAR strTemp[MAX_PATH];
                    HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
                    FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
                    DeleteObject(hbr);
                    SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
                    SetBkMode(lpdis->hDC , TRANSPARENT);
                    DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
                }
            }
        }
        break;
    case WM_CTLCOLORLISTBOX:
    case WM_CTLCOLORSTATIC:
    case WM_CTLCOLORDLG:
        {
            SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
            SetTextColor((HDC)wparam,COMBO_BK_COLOR);
            return (BOOL)hBrGlobalBk;
        }
    case WM_COMMAND:
        switch(LOWORD(wparam))
        {
        case IDC_NAME:
            if(HIWORD(wparam) == CBN_SELCHANGE)
            {
                TCHAR szBuf[MAX_NAMELEN];
                iDlgIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_NAME),CB_GETCURSEL,0,0);
                LoadString(ghInstance,(IDS_START + iDlgIndex),szBuf,sizeof(szBuf));
                if(iDlgIndex < MAX_NAME)
                {
                    DestroyWindow(gcHwnd);
                    gcHwnd=CreateDialog(ghInstance,MAKEINTRESOURCE((IDD_START + iDlgIndex)),hwnd,(DLGPROC)gfAdr[iDlgIndex]);
                    ShowWindow(gcHwnd,SW_SHOW);
                }
                SendMessage(GetDlgItem(hwnd,IDC_FRAMEDLG),WM_SETTEXT,0,(LPARAM)szBuf);
                ShowWindow(gcHwnd,SW_SHOW);
            }
            break;
        }
        break;
    case WM_CLOSE:
        delete []pSkin;
        EndDialog(hwnd,0);
        return TRUE;
    case WM_DESTROY:
        DeleteObject(hCBLeft);
        DeleteObject(hCBCenter);
        DeleteObject(hCBRight);
        DeleteObject(hBrGlobalBk);
        DeleteObject(hDlgBack);
        break;
    }
    return FALSE;
}
BOOL CALLBACK InfoProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
    RECT r;
    POINT stPoint;
    switch(msg)
    {
    case WM_INITDIALOG:
        GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
        stPoint.x = r.left;
        stPoint.y = r.top;
        ScreenToClient(GetParent(hwnd),&stPoint);
        SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
        break;
    case WM_CTLCOLORLISTBOX:
    case WM_CTLCOLORSTATIC:
    case WM_CTLCOLORDLG:
        {
            SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
            SetTextColor((HDC)wparam,COMBO_BK_COLOR);
            return (BOOL)hBrGlobalBk;
        }
    case WM_CLOSE:
        EndDialog(hwnd,0);
        return TRUE;
    }
    return FALSE;
}
BOOL CALLBACK AboutProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
    RECT r;
    POINT stPoint;
    TCHAR strAbout[] = "Developed By,\n\n\t\tKannan.K\n\t\tsoftkannan@gmail.com\n\t\tPerundurai\n\t\tErode\n\t\tIndia.";
    switch(msg)
    {
    case WM_INITDIALOG:
        GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
        stPoint.x = r.left;
        stPoint.y = r.top;
        ScreenToClient(GetParent(hwnd),&stPoint);
        SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
        SetWindowText(GetDlgItem(hwnd,IDC_DATA),strAbout);
        break;
    case WM_CTLCOLORLISTBOX:
    case WM_CTLCOLORSTATIC:
    case WM_CTLCOLORDLG:
        {
            SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
            SetTextColor((HDC)wparam,COMBO_BK_COLOR);
            return (BOOL)hBrGlobalBk;
        }
    case WM_CLOSE:
        EndDialog(hwnd,0);
        return TRUE;
    }
    return FALSE;
}




int LoadComboBox(HWND hwnd,HINSTANCE hInstance)
{
    int iIndex;
    TCHAR szBuf[MAX_NAMELEN];
    for(iIndex = IDS_START ; iIndex <= IDS_END ; iIndex++)
    {
        LoadString(hInstance,iIndex,szBuf,sizeof(szBuf));
        SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf);
    }
    SendMessage(hwnd,CB_SETCURSEL,0,0);
    return 0;
}

LRESULT CALLBACK ComboBoxSubClassProc( HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam )
{
    PAINTSTRUCT ps;
    TCHAR strTemp[MAX_PATH];
    HDC memdc;
    HFONT hFont,hOldFont;
    BITMAP bmpc,bmpl,bmpr;
    HBITMAP hOldBitmap;
    RECT r;
    // Call the original window procedure for default processing. 
    switch(msg)
    {
    case WM_PAINT:
        BeginPaint(hwnd,&ps);
        
        memdc = CreateCompatibleDC(ps.hdc);

        hFont = (HFONT) SendMessage(hwnd,WM_GETFONT,0,0);
        hOldFont = (HFONT)SelectObject(ps.hdc,hFont);

        GetClientRect(hwnd,&r);

        SetTextColor(ps.hdc,COMBO_BK_COLOR);

        GetObject(hCBLeft, sizeof(BITMAP), (LPSTR)&bmpl);
        hOldBitmap = (HBITMAP)SelectObject(memdc,hCBLeft);
        StretchBlt(ps.hdc, r.left,r.top,bmpl.bmWidth,r.bottom,memdc,0,0,bmpl.bmWidth,bmpl.bmHeight,SRCCOPY);

        GetObject(hCBRight, sizeof(BITMAP), (LPSTR)&bmpr);
        SelectObject(memdc,hCBRight);
        StretchBlt(ps.hdc , r.right - bmpr.bmWidth,r.top,bmpr.bmWidth,r.bottom,memdc,0,0,bmpr.bmWidth,bmpr.bmHeight,SRCCOPY);

        GetObject(hCBCenter, sizeof(BITMAP), (LPSTR)&bmpc);
        SelectObject(memdc,hCBCenter);
        StretchBlt(ps.hdc, r.left + bmpl.bmWidth,r.top,r.right - bmpl.bmWidth - bmpr.bmWidth,r.bottom,memdc,0,0,bmpc.bmWidth,bmpc.bmHeight,SRCCOPY);
        
        GetWindowText(hwnd,strTemp,MAX_PATH);
        SetBkMode(ps.hdc,TRANSPARENT);

        r.left += 5;
        r.right -= RIGHT_BUTTON_WIDTH;
        DrawText(ps.hdc,strTemp,-1,&r,DT_VCENTER|DT_SINGLELINE|DT_WORD_ELLIPSIS);
        
        SelectObject(ps.hdc,hOldFont);
        SelectObject(memdc,hOldBitmap);
        DeleteDC(memdc);
        EndPaint(hwnd,&ps);
        return TRUE;

    case WM_KILLFOCUS:
        {
            //
            HDC hdc = GetDC(hwnd);

            memdc = CreateCompatibleDC(hdc);

            hFont = (HFONT) SendMessage(hwnd,WM_GETFONT,0,0);
            hOldFont = (HFONT)SelectObject(hdc,hFont);

            SetTextColor(hdc,COMBO_BK_COLOR);

            GetClientRect(hwnd,&r);

            GetObject(hCBLeft, sizeof(BITMAP), (LPSTR)&bmpl);
            hOldBitmap = (HBITMAP)SelectObject(memdc,hCBLeft);
            StretchBlt(hdc, r.left,r.top,bmpl.bmWidth,r.bottom,memdc,0,0,bmpl.bmWidth,bmpl.bmHeight,SRCCOPY);

            GetObject(hCBRight, sizeof(BITMAP), (LPSTR)&bmpr);
            SelectObject(memdc,hCBRight);
            StretchBlt(hdc , r.right - bmpr.bmWidth,r.top,bmpr.bmWidth,r.bottom,memdc,0,0,bmpr.bmWidth,bmpr.bmHeight,SRCCOPY);

            GetObject(hCBCenter, sizeof(BITMAP), (LPSTR)&bmpc);
            SelectObject(memdc,hCBCenter);
            StretchBlt(hdc, r.left + bmpl.bmWidth,r.top,r.right - bmpl.bmWidth - bmpr.bmWidth,r.bottom,memdc,0,0,bmpc.bmWidth,bmpc.bmHeight,SRCCOPY);
            
            GetWindowText(hwnd,strTemp,MAX_PATH);
            SetBkMode(hdc,TRANSPARENT);
            r.left += 5;
            r.right -= RIGHT_BUTTON_WIDTH;
            DrawText(hdc,strTemp,-1,&r,DT_VCENTER|DT_SINGLELINE|DT_WORD_ELLIPSIS);
            
            SelectObject(hdc,hOldFont);
            SelectObject(memdc,hOldBitmap);
            DeleteDC(memdc);
            ReleaseDC(hwnd,hdc);
        }
        return TRUE;
    case WM_COMMAND:
        {
        switch(HIWORD(wparam))
        {
        case CBN_SETFOCUS:
        case CBN_SELCHANGE:
            CallWindowProc(lpfnComboBoxProc, hwnd,msg, wparam, lparam);
            HDC hdc = GetDC(hwnd);

            memdc = CreateCompatibleDC(hdc);

            hFont = (HFONT) SendMessage(hwnd,WM_GETFONT,0,0);
            hOldFont = (HFONT)SelectObject(hdc,hFont);

            SetTextColor(hdc,COMBO_BK_COLOR);

            GetClientRect(hwnd,&r);

            GetObject(hCBLeft, sizeof(BITMAP), (LPSTR)&bmpl);
            hOldBitmap = (HBITMAP)SelectObject(memdc,hCBLeft);
            StretchBlt(hdc, r.left,r.top,bmpl.bmWidth,r.bottom,memdc,0,0,bmpl.bmWidth,bmpl.bmHeight,SRCCOPY);

            GetObject(hCBRight, sizeof(BITMAP), (LPSTR)&bmpr);
            SelectObject(memdc,hCBRight);
            StretchBlt(hdc , r.right - bmpr.bmWidth,r.top,bmpr.bmWidth,r.bottom,memdc,0,0,bmpr.bmWidth,bmpr.bmHeight,SRCCOPY);

            GetObject(hCBCenter, sizeof(BITMAP), (LPSTR)&bmpc);
            SelectObject(memdc,hCBCenter);
            StretchBlt(hdc, r.left + bmpl.bmWidth,r.top,r.right - bmpl.bmWidth - bmpr.bmWidth,r.bottom,memdc,0,0,bmpc.bmWidth,bmpc.bmHeight,SRCCOPY);
            
            GetWindowText(hwnd,strTemp,MAX_PATH);
            SetBkMode(hdc,TRANSPARENT);
            r.left += 5;
            r.right -= RIGHT_BUTTON_WIDTH;
            DrawText(hdc,strTemp,-1,&r,DT_VCENTER|DT_SINGLELINE|DT_WORD_ELLIPSIS);
            
            SelectObject(hdc,hOldFont);
            SelectObject(memdc,hOldBitmap);
            DeleteDC(memdc);
            ReleaseDC(hwnd,hdc);
            return TRUE;
        }
        }
        break;

    }
    return CallWindowProc(lpfnComboBoxProc, hwnd,msg, wparam, lparam);
}
LRESULT CALLBACK ButtonSubClassProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
    return CallWindowProc(lpfnButtonProc, hwnd,msg, wparam, lparam);
}
LRESULT CALLBACK EditSubClassProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
    PAINTSTRUCT ps;
    TCHAR strTemp[MAX_PATH];
    HDC memdc;
    HFONT hFont,hOldFont;
    BITMAP bmpc,bmpl,bmpr;
    HBITMAP hOldBitmap;
    RECT r;
    switch(msg)
    {
    //case WM_CREATE:
    //	{
    //		HRGN hRgn;
    //		HDC hdc = GetDC(hwnd);
    //		//SetWindowLong(hwnd,GWL_STYLE,WS_POPUPWINDOW );
    //		GetWindowRect(hwnd,&r);
    //		//MoveWindow(hwnd,0,0,r.right - r.left,r.bottom - r.top ,TRUE);
    //		CreateRoundRectRgn(0,0,20,20,10,10);
    //		SelectClipRgn(hdc,hRgn);
    //		ReleaseDC(hwnd,hdc);
    //	}
    //	break;
    case WM_PAINT:
        BeginPaint(hwnd,&ps);
        
        hFont = (HFONT) SendMessage(hwnd,WM_GETFONT,0,0);
        hOldFont = (HFONT)SelectObject(ps.hdc,hFont);

        GetClientRect(hwnd,&r);

        SetTextColor(ps.hdc,COMBO_BK_COLOR);

        GetObject(hCBLeft, sizeof(BITMAP), (LPSTR)&bmpl);
        hOldBitmap = (HBITMAP)SelectObject(memdc,hCBLeft);
        StretchBlt(ps.hdc, r.left,r.top,bmpl.bmWidth,r.bottom,memdc,0,0,bmpl.bmWidth,bmpl.bmHeight,SRCCOPY);

        GetObject(hCBRight, sizeof(BITMAP), (LPSTR)&bmpr);
        SelectObject(memdc,hCBRight);
        StretchBlt(ps.hdc , r.right - bmpr.bmWidth,r.top,bmpr.bmWidth,r.bottom,memdc,0,0,bmpr.bmWidth,bmpr.bmHeight,SRCCOPY);

        GetObject(hCBCenter, sizeof(BITMAP), (LPSTR)&bmpc);
        SelectObject(memdc,hCBCenter);
        StretchBlt(ps.hdc, r.left + bmpl.bmWidth,r.top,r.right - bmpl.bmWidth - bmpr.bmWidth,r.bottom,memdc,0,0,bmpc.bmWidth,bmpc.bmHeight,SRCCOPY);
        
        GetWindowText(hwnd,strTemp,MAX_PATH);
        SetBkMode(ps.hdc,TRANSPARENT);

        r.left += 5;
        r.right -= RIGHT_BUTTON_WIDTH;
        DrawText(ps.hdc,strTemp,-1,&r,DT_VCENTER|DT_SINGLELINE|DT_WORD_ELLIPSIS);
        
        SelectObject(ps.hdc,hOldFont);
        SelectObject(memdc,hOldBitmap);
        DeleteDC(memdc);
        EndPaint(hwnd,&ps);
        return TRUE;
    case WM_NCPAINT:
        return TRUE;
    case WM_CHAR:
        {
            GetWindowText(hwnd,strTemp,MAX_PATH);
            if(strlen(strTemp) < MAX_PATH - 2)
            {
                if(isdigit((INT)wparam) || iscntrl((INT)wparam))
                {
                    break;
                }
                else if ((INT)wparam == '.')
                {
                    if(strchr(strTemp,'.') == NULL)
                    {
                        break;
                    }
                    else
                    {
                        return TRUE;
                    }
                }
                else if( (INT)wparam == 'e' || (INT)wparam == 'E')
                {
                    wparam = tolower((INT)wparam);
                    if(strchr(strTemp,'e') == NULL)
                    {
                        break;
                    }
                    else
                    {
                        return TRUE;
                    }
                }
            }
            return TRUE;
        }
    }
    return CallWindowProc(lpfnEditBoxProc, hwnd,msg, wparam, lparam);
}