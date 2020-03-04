#include "StdAfx.h"
#include "Globals.h"
#include "TrayWindow.h"
#include "UtilityMethods.h"

//////////////////////////////////////////////////////////////////////////
/// ctor
//////////////////////////////////////////////////////////////////////////
TrayWindow::TrayWindow(UINT callbackMsg, HWND hwnd, HINSTANCE hInstance, HMENU hmenu) : m_hwnd(hwnd), m_hInstance(hInstance), m_hmenu(hmenu), m_callbackMsg(callbackMsg)
{
	TrayHelper(NIM_ADD);
}
//////////////////////////////////////////////////////////////////////////
/// dtor
//////////////////////////////////////////////////////////////////////////
TrayWindow::~TrayWindow()
{
	TrayHelper(NIM_DELETE);
}
//////////////////////////////////////////////////////////////////////////
/// Internal Helper method to add and remove the Tray icon
//////////////////////////////////////////////////////////////////////////
void TrayWindow::TrayHelper(UINT msg)
{
	NOTIFYICONDATA nIconData;

	ZeroMemory(&nIconData, sizeof(nIconData));

	switch (msg)
	{
	case NIM_ADD:
		lstrcpy(nIconData.szTip, "Thunder Shutdown");
		nIconData.uFlags = NIF_MESSAGE | NIF_ICON | NIF_TIP;
		break;

	case NIM_MODIFY:
		nIconData.uFlags = NIF_TIP;
		break;

	case NIM_DELETE:
		nIconData.uFlags = 0;
		//g_State1 = FALSE;
		break;
	}

	nIconData.cbSize = sizeof(NOTIFYICONDATA);
	nIconData.hIcon = LoadIcon(m_hInstance, MAKEINTRESOURCE(IDI_ICON1));
	nIconData.hWnd = m_hwnd;
	nIconData.uCallbackMessage = m_callbackMsg;
	nIconData.uID = IDI_ICON1;

	Shell_NotifyIcon(msg, &nIconData);
}
//////////////////////////////////////////////////////////////////////////
/// Called from main window proc, primarly this method is used to launch the tray icon menu
//////////////////////////////////////////////////////////////////////////
void TrayWindow::TrayWindowProc(WPARAM wParam, LPARAM lParam)
{
	UINT uID, msg;
	uID = (UINT)wParam;
	msg = (UINT)lParam;
	switch (msg)
	{
	case WM_RBUTTONDOWN:
	{
		POINT p;
		GetCursorPos(&p);
		SetForegroundWindow(m_hwnd);
		HMENU popupmenu = GetSubMenu(m_hmenu, 0);
		TrackPopupMenu(popupmenu, TPM_CENTERALIGN | TPM_BOTTOMALIGN, p.x, p.y, 0, m_hwnd, NULL);
		SendMessage(m_hwnd, WM_NULL, 0, 0);
	}
	break;
	}

}
