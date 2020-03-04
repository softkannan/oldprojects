// Memory.cpp : Defines the entry point for the application.
//
#include "StdAfx.h"

#define DEFINE_GLOBALS_VARIABLES
#include "Globals.h"

#include "UtilityMethods.h"
#include <Shlwapi.h>
#include "mutex.h"
#include "ProcessExec.h"

int APIENTRY WinMain(HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR     lpCmdLine,
    int       nCmdShow)
{
    WNDCLASS wndClass;
	mutex g_Mutex("ProxyChangeNotifierByKannan");
    //If the mutex is a named mutex and the object existed before this function call,
    //the return value is a handle to the existing object, GetLastError returns ERROR_ALREADY_EXISTS,
    //bInitialOwner is ignored, and the calling thread is not granted ownership.However, if the caller has limited access rights,
    //the function will fail with ERROR_ACCESS_DENIED and the caller should use the OpenMutex function.


    if (GetLastError() != ERROR_ALREADY_EXISTS) 
    {
		if(ENABLE_AUTO_RUN_CHECK)
        {
            CHAR tempBuff[MAX_PATH];
            GetModuleFileName(hInstance, tempBuff, MAX_PATH);
            HKEY regHKey;
            string moduleName = tempBuff;
            DWORD tempBuffSize = MAX_PATH;

            auto retVal = RegGetValue(HKEY_LOCAL_MACHINE, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", "ProxyChangeNotifier", RRF_RT_REG_SZ, NULL, tempBuff, &tempBuffSize);

            if (retVal == ERROR_SUCCESS)
            {
                string tempRegVal = tempBuff;

                if (tempRegVal == moduleName)
                {
                    retVal = ERROR_SUCCESS;
                }
                else
                {
                    retVal = 1;
                }
            }
            
            if (retVal != ERROR_SUCCESS)
            {
                auto regRet = RegOpenKey(HKEY_LOCAL_MACHINE, "Software\\Microsoft\\Windows\\CurrentVersion\\Run", &regHKey);
                if (regRet != ERROR_SUCCESS)
                {
                    ERRORM("Please run the application with administrator privilege so that it can create necessary registry startup entries. If you already running this application with administrator privilege please go ahead and ignore.");
                    return 0;
                }
                regRet = RegSetValueEx(regHKey, "ProxyChangeNotifier", 0, REG_SZ, (CONST BYTE*)moduleName.c_str(), (DWORD) moduleName.length());
                if (regRet != ERROR_SUCCESS)
                {
                    ERRORM("Please run the application with administrator privilege so that it can create necessary registry startup entries. If you already running this application with administrator privilege please go ahead and ignore.");
                    return 0;
                }
                RegCloseKey(regHKey);
                ERRORM("Required automatic startup entries are created. Thank you.");
            }
        }

        InitCommonControls();
        memset(&wndClass, 0, sizeof(wndClass));

        wndClass.style = CS_DBLCLKS;
        wndClass.lpfnWndProc = DefDlgProc;
        wndClass.cbWndExtra = 0;
        wndClass.hCursor = LoadCursor(0, IDC_ARROW);
        wndClass.hInstance = hInstance;
        wndClass.hbrBackground = (HBRUSH)COLOR_WINDOW;
        wndClass.lpszClassName = "ProxyChangeNotifierByKannan";

        if (!RegisterClass(&wndClass))
        {
            return 0;
        }
		auto mainWindow = make_shared<ProxyChangeNotifierWindow>(hInstance);
		//create get message loop and wait for window closure
		auto retVal = mainWindow->ShowDialog();
		mainWindow = NULL;
		return (INT)retVal;
    }

    return 0;
}

ProxyChangeNotifierWindow::ProxyChangeNotifierWindow(HINSTANCE hInstance) :m_hInstance(hInstance)
{
	m_pThis = this;
    char tempBuff[MAX_PATH];
    GetModuleFileName(m_hInstance, tempBuff, MAX_PATH);
    PathRemoveFileSpec(tempBuff);
    ExecPath = tempBuff;
    ExecPath += "\\";
}

ProxyChangeNotifierWindow::~ProxyChangeNotifierWindow()
{
   
}

INT_PTR ProxyChangeNotifierWindow::ShowDialog()
{
	return DialogBox(m_hInstance, MAKEINTRESOURCE(IDD_MAIN), 0, (DLGPROC)MainWindowProc);
}

void ProxyChangeNotifierWindow::CloseApplication(INT_PTR result)
{

#ifdef ENABLE_SETTINGS_FEATURE
	m_settings = NULL;
#endif // ENABLE_SETTINGS_FEATURE
#ifdef ENABLE_TRAY_WINDOW
	m_trayWindow = NULL;

	if (m_menu != NULL)
	{
		DestroyMenu(m_menu);
		m_menu = NULL;
	}
#endif // ENABLE_TRAY_WINDOW
    m_hInstance = NULL;
#ifdef ENABLE_PLUGIN_FEATURE
	m_pluginMgr = NULL;
#endif // ENABLE_PLUGIN_FEATURE
#ifdef ENABLE_FLASH_WINDOW
	m_Timers = NULL;
#endif // ENABLE_FLASH_WINDOW
	

    
   
	EndDialog(m_hwnd, result);
}

BOOL CALLBACK ProxyChangeNotifierWindow::MainWindowProcInternal(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
	case WM_INITDIALOG:
        {
            m_hwnd = hwnd;

#ifdef ENABLE_SETTINGS_FEATURE
			m_settings = make_shared<UserSettings>(m_hInstance, hwnd);
#endif // ENABLE_SETTINGS_FEATURE
#ifdef ENABLE_FLASH_WINDOW
			m_Timers = make_shared<WindowsTimer>();
			m_Timers->CreateTimer(1000, [&](shared_ptr<TimerInfo> timerInfo) {

				ShowWindow(this->m_hwnd, SW_HIDE);
				timerInfo->KillTimer();

	}, hwnd);
#endif // ENABLE_FLASH_WINDOW
#ifdef ENABLE_TRAY_WINDOW
			m_menu = LoadMenu(m_hInstance, MAKEINTRESOURCE(IDR_MENU_MAIN6));
			m_trayWindow = make_shared<TrayWindow>(TRAY_CALLBACK_MSG, hwnd, m_hInstance, m_menu);
#endif // ENABLE_TRAY_WINDOW
#ifdef ENABLE_PLUGIN_FEATURE
			m_pluginMgr = make_shared<PluginManager>(m_menu, m_settings->ExecPath);
#endif // ENABLE_PLUGIN_FEATURE
            
			m_proxyManager = make_shared<ProxyManager>();
			m_proxyManager->WaitForProxyChange();
        }
		break;
#ifdef ENABLE_TRAY_WINDOW
	case WM_COMMAND:
        {
            switch (wParam)
            {
            case ID_MENU_ABOUT:
                ShowWindow(hwnd, SW_SHOW);
                break;
            case ID_MENU_EXIT:
                CloseApplication();
                return TRUE;

#ifdef ENABLE_SETTINGS_FEATURE
            case ID_MENU_OPTIONS:
            {
                if (m_settings)
                {
                    m_settings->ShowDialog();
                }
            }
            break;
#endif // ENABLE_SETTINGS_FEATURE
#ifdef ENABLE_PLUGIN_FEATURE
            default:
                if (m_pluginMgr)
                {
                    m_pluginMgr->ProcessPluginMenu(wParam, !HIWORD(GetKeyState(VK_SHIFT)));
                }
#endif // ENABLE_PLUGIN_FEATURE
            }
        }
		break;
#endif // ENABLE_TRAY_WINDOW
	case WM_LBUTTONDOWN:
	case WM_RBUTTONDOWN:
		ShowWindow(hwnd, SW_HIDE);
		break;
#ifdef ENABLE_TRAY_WINDOW
	case TRAY_CALLBACK_MSG:
		if (m_trayWindow)
		{
			m_trayWindow->TrayWindowProc(wParam, lParam);
		}
		break;
#endif // ENABLE_TRAY_WINDOW
	case WM_DESTROY:
	case WM_CLOSE:
		CloseApplication();
		return TRUE;
	}
	return FALSE;
}

ProxyChangeNotifierWindow* ProxyChangeNotifierWindow::m_pThis;

BOOL CALLBACK ProxyChangeNotifierWindow::MainWindowProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	if (m_pThis)
	{
		return m_pThis->MainWindowProcInternal(hwnd, msg, wParam, lParam);
	}

	return FALSE;
}
