// Memory.cpp : Defines the entry point for the application.
//
#include "StdAfx.h"

#define DEFINE_GLOBALS_VARIABLES
#include "Globals.h"

#include "UtilityMethods.h"


int APIENTRY WinMain(HINSTANCE hInstance,
    HINSTANCE hPrevInstance,
    LPSTR     lpCmdLine,
    int       nCmdShow)
{
    WNDCLASS wndClass;
    HANDLE hMutex = CreateMutex(NULL, TRUE, "HTPCManagerByKannan");
    //If the mutex is a named mutex and the object existed before this function call,
    //the return value is a handle to the existing object, GetLastError returns ERROR_ALREADY_EXISTS,
    //bInitialOwner is ignored, and the calling thread is not granted ownership.However, if the caller has limited access rights,
    //the function will fail with ERROR_ACCESS_DENIED and the caller should use the OpenMutex function.
    if (GetLastError() != ERROR_ALREADY_EXISTS) 
    {

        InitCommonControls();
        memset(&wndClass, 0, sizeof(wndClass));

        wndClass.style = CS_DBLCLKS;
        wndClass.lpfnWndProc = DefDlgProc;
        wndClass.cbWndExtra = 0;
        wndClass.hCursor = LoadCursor(0, IDC_ARROW);
        wndClass.hInstance = hInstance;
        wndClass.hbrBackground = (HBRUSH)COLOR_WINDOW;
        wndClass.lpszClassName = "HTPCManagerByKannan";

        if (!RegisterClass(&wndClass))
        {
            return 0;
        }
		auto mainWindow = make_shared<MemoryWindow>(hInstance);
		auto retVal = mainWindow->ShowDialog();
		mainWindow = NULL;
		return (INT)retVal;
    }
    return 0;
}

MemoryWindow::MemoryWindow(HINSTANCE hInstance) :m_hInstance(hInstance)
{
	m_pThis = this;
}

MemoryWindow::~MemoryWindow()
{
   
}

INT_PTR MemoryWindow::ShowDialog()
{
	return DialogBox(m_hInstance, MAKEINTRESOURCE(IDD_MAIN), 0, (DLGPROC)MainWindowProc);
}

void MemoryWindow::CloseApplication(INT_PTR result)
{
    m_settings = NULL;
    m_trayWindow = NULL;
    m_hInstance = NULL;
	m_pluginMgr = NULL;
	m_Timers = NULL;

    if (m_menu != NULL)
    {
        DestroyMenu(m_menu);
        m_menu = NULL;
    }
   
	EndDialog(m_hwnd, result);
}

BOOL CALLBACK MemoryWindow::MainWindowProcInternal(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	switch (msg)
	{
	case WM_INITDIALOG:
        {
            m_hwnd = hwnd;
            m_Timers = make_shared<WindowsTimer>();
            m_settings = make_shared<UserSettings>(m_hInstance, hwnd);
            m_Timers->CreateTimer(1000, [&](shared_ptr<TimerInfo> timerInfo) {

                ShowWindow(this->m_hwnd, SW_HIDE);
                timerInfo->KillTimer();

            }, hwnd);

            if (m_settings->AutoShutdownType == MEM_AUTOSHUTDOWNONTIME)
            {
                m_Timers->CreateTimer(1000, [&](shared_ptr<TimerInfo> timerInfo) {

                    //HandleAutoshutdown(timerInfo->Hwnd);

                }, hwnd);
            }

            m_menu = LoadMenu(m_hInstance, MAKEINTRESOURCE(IDR_MENU_MAIN6));

            m_trayWindow = make_shared<TrayWindow>(TRAY_CALLBACK_MSG, hwnd, m_hInstance, m_menu);
            m_shutdownMgr = make_shared<BackgroundTaskManager>(m_settings->AbortTimeout);
            m_pluginMgr = make_shared<PluginManager>(m_menu, m_settings->ExecPath);
        }
		break;
	case WM_POWERBROADCAST:
        {
            switch (wParam)
            {
            case PBT_APMPOWERSTATUSCHANGE:
                if (m_settings->AutoShutdownType == MEM_AUTOSHUTDOWNONBATTERY)
                {
                    SYSTEM_POWER_STATUS syspwr;
                    ZeroMemory(&syspwr, sizeof(syspwr));
                    GetSystemPowerStatus(&syspwr);
                    if (syspwr.ACLineStatus == 0)
                    {
                        m_shutdownMgr->ShutDown(hwnd, MEM_POWEROFF, TRUE, TRUE, TRUE, TRUE);
                    }
                    else
                    {
                        if (m_shutdownMgr->IsShutdownProgress())
                        {
                            m_shutdownMgr->Abort();
                        }
                    }
                }
                break;
            default:
                break;
            }
        }
		break;
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
            case ID_MENU_OPTIONS:
            {
                if (m_settings)
                {
                    m_settings->ShowDialog();
                }
            }
            break;
            default:
                if (m_pluginMgr)
                {
                    m_pluginMgr->ProcessPluginMenu(wParam, !HIWORD(GetKeyState(VK_SHIFT)));
                }
            }
        }
		break;
	case WM_LBUTTONDOWN:
	case WM_RBUTTONDOWN:
		ShowWindow(hwnd, SW_HIDE);
		break;
	case TRAY_CALLBACK_MSG:
		if (m_trayWindow)
		{
			m_trayWindow->TrayWindowProc(wParam, lParam);
		}
		break;
	case WM_QUERYENDSESSION:
	case WM_DESTROY:
	case WM_CLOSE:
		CloseApplication();
		return TRUE;
	}
	return FALSE;
}

MemoryWindow* MemoryWindow::m_pThis;

BOOL CALLBACK MemoryWindow::MainWindowProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	if (m_pThis)
	{
		return m_pThis->MainWindowProcInternal(hwnd, msg, wParam, lParam);
	}

	return FALSE;
}
