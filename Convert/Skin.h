#pragma once

#include <windows.h>

#define MAX_MAP 40
#define MAX_IM_MAP 40
#define MAX_SKIN_MAP 8

#define IN_CAPTIONBAR 0
#define IN_LEFTBORDER 1
#define IN_RIGHTBORDER 2
#define IN_BOTTOMBORDER 3
#define IN_CLOSEBOX 4
#define IN_MINBOX 5

class CSkin
{
private:
	RECT m_dstmap[MAX_MAP];
	LONG m_CaptionBarHeight;
	LONG m_BorderWidth;
	LONG m_BorderHeight;
	static const RECT m_srcmap[MAX_SKIN_MAP];
	HBITMAP m_hbitmap;
public:
	CSkin(LPCTSTR lpFileName);
	CSkin(HMODULE hModule,UINT iResourceid);
	~CSkin(void);
	void GetSysSetting(void);
	int DrawSkin(HWND hwnd);
};
