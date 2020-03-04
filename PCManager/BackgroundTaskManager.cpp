#include "StdAfx.h"
#include "Globals.h"
#include "BackgroundTaskManager.h"
#include "UtilityMethods.h"

BackgroundTaskManager* BackgroundTaskManager::m_pThis;


BackgroundTaskManager::BackgroundTaskManager(UINT abortTimeout) :m_abortTimeout(0),m_abort(FALSE),m_shutdownprogress(FALSE)
{
	m_pThis = this;
	m_abortTimeout = abortTimeout;
}

BackgroundTaskManager::~BackgroundTaskManager()
{
}

BOOL BackgroundTaskManager::CheckTriggerFlag()
{
	return m_abort;
}
BOOL BackgroundTaskManager::IsShutdownProgress()
{
    return m_shutdownprogress;
}
void BackgroundTaskManager::Reset()
{
    m_shutdownprogress = TRUE;
    m_abort = FALSE;
}
void BackgroundTaskManager::Abort()
{
    m_abort = TRUE;
}
BOOL BackgroundTaskManager::ShutDown(HWND hwnd, UINT opCode, BOOL forceShutdown, BOOL forceHung, BOOL showAbort, BOOL autoTrigger)
{
    if (IsShutdownProgress())
    {
        return FALSE;
    }

    m_thread = make_shared<thread>();

    m_thread->Run([=]() { ShutdownLocal(hwnd, opCode, forceShutdown, forceHung, showAbort, autoTrigger);});

    return TRUE;
}
BOOL BackgroundTaskManager::ShutdownLocal(HWND hwnd, UINT opCode, BOOL forceShutdown, BOOL forceHung, BOOL showAbort, BOOL autoTrigger)
{
    BOOL retVal = FALSE;

    Reset();

    auto dlgRelVal = DialogBox(0, MAKEINTRESOURCE(IDD_SHUTDOWNABORT), hwnd, (DLGPROC)ShutdownWindowProc);

    if (dlgRelVal == SHU_UI_ABORT || dlgRelVal != SHU_UI_CONTINUE)
    {
        m_shutdownprogress = FALSE;
        return FALSE;
    }

    if (autoTrigger)
    {
        if (CheckTriggerFlag())
        {
            m_shutdownprogress = FALSE;
            return FALSE;
        }
    }

    
    return retVal;
}
BOOL BackgroundTaskManager::ShutDownInternal(HWND hwnd, UINT opCode, BOOL forceShutdown, BOOL forceHung)
{

	return TRUE;
}
INT BackgroundTaskManager::ShowDialog()
{
	return 0;
}
BOOL CALLBACK BackgroundTaskManager::ShutdownWindowProcInternal(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	UINT tempRetVal;

	switch (msg)
	{
	case WM_INITDIALOG:
		SetTimer(hwnd, 5001, 1000, 0);
		SendDlgItemMessage(hwnd, IDC_SHUTDOWNPROGRESS, PBM_SETRANGE, 0, MAKELPARAM(0, m_abortTimeout));
		SendDlgItemMessage(hwnd, IDC_SHUTDOWNPROGRESS, PBM_SETPOS, 0, 0);
		break;
	case WM_TIMER:
		tempRetVal = (UINT)SendDlgItemMessage(hwnd, IDC_SHUTDOWNPROGRESS, PBM_GETPOS, 0, 0);

        {
            CHAR tempBuff[1024];
            wsprintf(tempBuff, "Your system will shutdown in %d secs......................", m_abortTimeout - tempRetVal);
            SendDlgItemMessage(hwnd, IDC_SHUTDOWNLABEL, WM_SETTEXT, 0, (LPARAM)tempBuff);
        }

        SendDlgItemMessage(hwnd, IDC_SHUTDOWNPROGRESS, PBM_SETPOS, tempRetVal + 1, 0);

		if (tempRetVal > (m_abortTimeout - 1))
		{
			EndDialog(hwnd, SHU_UI_CONTINUE);
			return TRUE;
		}
		break;
	case WM_COMMAND:
		switch (wparam)
		{
		case IDC_BTTNABORT:
			EndDialog(hwnd, SHU_UI_ABORT);
			return TRUE;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd, SHU_UI_CONTINUE);
		return TRUE;
	case WM_QUERYENDSESSION:
		EndDialog(hwnd, 0);
		return TRUE;
	}
	return FALSE;
}
BOOL CALLBACK BackgroundTaskManager::ShutdownWindowProc(HWND hwnd, UINT msg, WPARAM wparam, LPARAM lparam)
{
	if (m_pThis)
	{
		return m_pThis->ShutdownWindowProcInternal(hwnd, msg, wparam, lparam);
	}

	return FALSE;
}