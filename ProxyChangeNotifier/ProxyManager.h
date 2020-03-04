#pragma once

#include "thread.h"

class ProxyManager
{
private:
	thread m_waitThread;
public:
	ProxyManager();
	~ProxyManager();
	void WaitForProxyChange();
	void operator() ();
	void UpdateProxySetting(bool &retflag);
	void WaitForProxySettingChange(bool &retflag);
};

