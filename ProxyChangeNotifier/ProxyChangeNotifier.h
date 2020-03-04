#pragma once


#include "StdAfx.h"
#include <commctrl.h>
#include <string.h>
#include <stdlib.h>
#include "resource.h"
#include <shellapi.h>
#include <conio.h>
#include <stdio.h>
#include <commdlg.h>
#include <mmsystem.h>
//#include <stdlib.h>
#include "WindowsTimer.h"
#include "PluginManagement.h"
#include "TrayWindow.h"
#include "UserSettings.h"
#include "ProcessClean.h"
#include "ProxyManager.h"


#define ENABLE_AUTO_RUN_CHECK 1
//#define ENABLE_TRAY_WINDOW
//#defein ENABLE_PLUGIN_FEATURE
//#define ENABLE_SETTINGS_FEATURE
#define ENABLE_FLASH_WINDOW

#define TRAY_CALLBACK_MSG	WM_USER + 101

#define ID_PLUGIN 2000


class  ProxyChangeNotifierWindow
{
public:
	ProxyChangeNotifierWindow(HINSTANCE hInstance);
	~ ProxyChangeNotifierWindow();
	
	INT_PTR ShowDialog();
private:
	static ProxyChangeNotifierWindow* m_pThis;

#ifdef ENABLE_FLASH_WINDOW
	shared_ptr<WindowsTimer> m_Timers;
#endif // ENABLE_FLASH_WINDOW
#ifdef ENABLE_TRAY_WINDOW
	shared_ptr<TrayWindow> m_trayWindow;
#endif // ENABLE_TRAY_WINDOW
#ifdef ENABLE_PLUGIN_FEATURE
	shared_ptr<PluginManager> m_pluginMgr;
#endif // ENABLE_PLUGIN_FEATURE
#ifdef ENABLE_SETTINGS_FEATURE
	shared_ptr<UserSettings> m_settings;
#endif // ENABLE_SETTINGS_FEATURE

	shared_ptr<ProxyManager> m_proxyManager;

	HWND m_hwnd;
	HINSTANCE m_hInstance;
	HMENU m_menu; // main menu handle
    string ExecPath;

	static BOOL CALLBACK MainWindowProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
	BOOL CALLBACK MainWindowProcInternal(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam);
	void CloseApplication(INT_PTR result = 0);
};


