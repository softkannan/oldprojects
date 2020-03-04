#include "skin.h"

const RECT CSkin::m_srcmap[MAX_SKIN_MAP] = {
{14,0,50,14}, 
{66,0,13,14},
{81,0,15,14},
{14,16,50,4},
{66,16,13,4},
{81,16,15,4},
{0,16,6,171},
{8,16,5,171}
};
CSkin::CSkin(LPCSTR lpFileName)
{
    ZeroMemory(m_dstmap,sizeof(m_dstmap));
	GetSysSetting();
	m_hbitmap = (HBITMAP)LoadImage(NULL,lpFileName,IMAGE_BITMAP,0,0,LR_DEFAULTSIZE|LR_LOADFROMFILE);
}
CSkin::CSkin(HMODULE hModule,UINT iResourceid)
{
	ZeroMemory(m_dstmap,sizeof(m_dstmap));
	GetSysSetting();
	m_hbitmap = LoadBitmap(hModule,MAKEINTRESOURCE(iResourceid));
}
CSkin::~CSkin(void)
{
	DeleteObject(m_hbitmap);
}
void CSkin::GetSysSetting(void)
{
	m_CaptionBarHeight = GetSystemMetrics(SM_CYSMCAPTION)+ GetSystemMetrics(SM_CYFRAME);
	m_BorderHeight =  GetSystemMetrics(SM_CYFRAME);
	m_BorderWidth = GetSystemMetrics(SM_CXFRAME);
}

int CSkin::DrawSkin(HWND hwnd)
{
	HDC hdc = GetWindowDC(hwnd);
	HDC memdc = CreateCompatibleDC(hdc);
	RECT r;
	LONG lBottom,lWidth;

	GetWindowRect(hwnd,&r);
	lBottom = r.bottom - r.top;
	lWidth = r.right - r.left;

	HBITMAP hOldbitmap = (HBITMAP)SelectObject(memdc,m_hbitmap);
		
	StretchBlt(hdc,0,0,m_srcmap[0].right,m_CaptionBarHeight,memdc,\
		m_srcmap[0].left,m_srcmap[0].top,m_srcmap[0].right,m_srcmap[0].bottom,SRCCOPY);

	StretchBlt(hdc,m_srcmap[0].right,0,lWidth - m_srcmap[2].right - m_srcmap[0].right,m_CaptionBarHeight,memdc,\
		m_srcmap[1].left,m_srcmap[1].top,m_srcmap[1].right,m_srcmap[1].bottom,SRCCOPY);

	StretchBlt(hdc,lWidth - m_srcmap[2].right,0,m_srcmap[2].right,m_CaptionBarHeight,memdc,\
		m_srcmap[2].left,m_srcmap[2].top,m_srcmap[2].right,m_srcmap[2].bottom,SRCCOPY);

	StretchBlt(hdc,0,lBottom - m_BorderHeight,m_srcmap[3].right,m_BorderHeight,memdc,\
		m_srcmap[3].left,m_srcmap[3].top,m_srcmap[3].right,m_srcmap[3].bottom,SRCCOPY);

	StretchBlt(hdc,m_srcmap[3].right,lBottom - m_BorderHeight,lWidth - m_srcmap[3].right - m_srcmap[5].right,m_CaptionBarHeight,memdc,\
		m_srcmap[4].left,m_srcmap[4].top,m_srcmap[4].right,m_srcmap[4].bottom,SRCCOPY);

	StretchBlt(hdc,lWidth - m_srcmap[5].right,lBottom - m_BorderHeight,m_srcmap[5].right,m_CaptionBarHeight,memdc,\
		m_srcmap[5].left,m_srcmap[5].top,m_srcmap[5].right,m_srcmap[5].bottom,SRCCOPY);

	StretchBlt(hdc,0,m_CaptionBarHeight,m_BorderWidth,lBottom - m_CaptionBarHeight - m_BorderHeight,memdc,\
		m_srcmap[6].left,m_srcmap[6].top,m_srcmap[6].right,m_srcmap[6].bottom,SRCCOPY);

	StretchBlt(hdc,lWidth - m_BorderWidth,m_CaptionBarHeight,m_BorderWidth,lBottom - m_CaptionBarHeight - m_BorderHeight,memdc,\
		m_srcmap[7].left,m_srcmap[7].top,m_srcmap[7].right,m_srcmap[7].bottom,SRCCOPY);

	SelectObject(memdc,hOldbitmap);

	DeleteDC(memdc);
	ReleaseDC(hwnd,hdc);
	InvalidateRect(hwnd,NULL,FALSE);
	return 0;
}
