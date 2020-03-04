#ifndef CONVERT_H
#define CONVERT_H

#include <windows.h>
#include <commctrl.h>
#include <commdlg.h>
#include "resource.h"


#define MAX_NAME 42
#define MAX_NAMELEN 20
#define ROUNDRECT_CURVESIZE 20
#define RIGHT_BUTTON_WIDTH 20
#define RIGHT_BUTTON_HEIGHT 15
#define COMBO_TEXT_COLOR RGB(0,0,0)
#define COMBO_BK_COLOR RGB(255,255,255)

#define WM_UNKNOWN_MSG 0x00AE

#pragma warning (disable : 4311)
#pragma warning (disable : 4312)

#define ERR(X) MessageBox(0,"Error",X,0)


int LoadComboBox(HWND,HINSTANCE);

LRESULT CALLBACK ComboBoxSubClassProc( HWND, UINT, WPARAM, LPARAM );
LRESULT CALLBACK ButtonSubClassProc( HWND, UINT, WPARAM, LPARAM );
LRESULT CALLBACK EditSubClassProc( HWND, UINT, WPARAM, LPARAM );
BOOL CALLBACK MainProc(HWND,UINT,WPARAM,LPARAM);
BOOL CALLBACK InfoProc(HWND,UINT,WPARAM,LPARAM);
BOOL CALLBACK AboutProc(HWND,UINT,WPARAM,LPARAM);


#endif