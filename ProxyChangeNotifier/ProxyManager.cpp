#include "stdafx.h"
#include "ProxyManager.h"


ProxyManager::ProxyManager()
{
}


ProxyManager::~ProxyManager()
{
}


void ProxyManager::WaitForProxyChange()
{
	m_waitThread.Run(*this);
}

void ProxyManager::operator()()
{
	bool retflag = true;

	UpdateProxySetting(retflag);
	if (retflag) return;

	while (true)
	{
		retflag = true;
		WaitForProxySettingChange(retflag);
		if (retflag) return;

		Sleep(10000);

		retflag = true;
		UpdateProxySetting(retflag);
		if (retflag) return;
	}
}

void ProxyManager::UpdateProxySetting(bool &retflag)
{
	retflag = true;
	{
		HKEY   hKey;
		LONG   lErrorCode;
		auto strKey = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Connections";

		// Open a key.
		lErrorCode = RegOpenKeyEx(HKEY_CURRENT_USER, strKey, 0, KEY_WRITE | KEY_READ, &hKey);
		if (lErrorCode != ERROR_SUCCESS)
		{
			return;
		}

		vector<BYTE> regReadBuffer;
		regReadBuffer.resize(4096);
		std::fill(regReadBuffer.begin(), regReadBuffer.end(), 0);
		DWORD dwRegReadBufferSize = (DWORD)regReadBuffer.size();
		lErrorCode = RegQueryValueEx(hKey, "DefaultConnectionSettings", 0, 0, (LPBYTE)regReadBuffer.data(), &dwRegReadBufferSize);
		if (lErrorCode == ERROR_MORE_DATA)
		{
			regReadBuffer.resize(dwRegReadBufferSize + 1024);
			std::fill(regReadBuffer.begin(), regReadBuffer.end(), 0);
			dwRegReadBufferSize = (DWORD)regReadBuffer.size();
			lErrorCode = RegQueryValueEx(hKey, "DefaultConnectionSettings", 0, 0, (LPBYTE)regReadBuffer.data(), &dwRegReadBufferSize);
		}

		if (lErrorCode == ERROR_SUCCESS)
		{
			vector<BYTE> regWriteBuffer;
			regWriteBuffer.resize(16);
			std::fill(regWriteBuffer.begin(), regWriteBuffer.end(), 0);
			std::copy(regReadBuffer.begin(), regReadBuffer.begin() + 8, regWriteBuffer.begin());
			regWriteBuffer[8] = 01;

			RegSetValueEx(hKey, "DefaultConnectionSettings", 0, REG_BINARY, regWriteBuffer.data(), (DWORD)regWriteBuffer.size());
		}

	}
	retflag = false;
}

void ProxyManager::WaitForProxySettingChange(bool &retflag)
{
	retflag = true;

	{
		DWORD  dwFilter = REG_NOTIFY_CHANGE_NAME |
			REG_NOTIFY_CHANGE_ATTRIBUTES |
			REG_NOTIFY_CHANGE_LAST_SET |
			REG_NOTIFY_CHANGE_SECURITY;

		HANDLE hEvent;
		HKEY   hKey;
		LONG   lErrorCode;

		auto strKey = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\Connections";

		// Open a key.
		lErrorCode = RegOpenKeyEx(HKEY_CURRENT_USER, strKey, 0, KEY_NOTIFY, &hKey);
		if (lErrorCode != ERROR_SUCCESS)
		{
			return;
		}

		// Create an event.
		hEvent = CreateEvent(NULL, TRUE, FALSE, NULL);
		if (hEvent == NULL)
		{
			return;
		}
		// Watch the registry key for a change of value.
		lErrorCode = RegNotifyChangeKeyValue(hKey,
			TRUE,
			dwFilter,
			hEvent,
			TRUE);
		if (lErrorCode != ERROR_SUCCESS)
		{
			return;
		}
		// Wait for an event to occur.
		if (WaitForSingleObject(hEvent, INFINITE) == WAIT_FAILED)
		{
			return;
		}



		// Close the key.
		lErrorCode = RegCloseKey(hKey);
		if (lErrorCode != ERROR_SUCCESS)
		{
			return;
		}

		// Close the handle.
		if (!CloseHandle(hEvent))
		{
			return;
		}
	}

	retflag = false;
}

