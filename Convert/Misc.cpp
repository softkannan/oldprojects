#include "misc.h"

#pragma warning(disable:4100)
extern HINSTANCE ghInstance;
extern HBRUSH hBrGlobalBk;


BOOL CALLBACK FrequencyProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadFrequencyComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadFrequencyComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcFrequency(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadFrequencyComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"1/second","cycle/second","degree/hour","degree/minute","degree/second",
		"gigahertz","hertz","kilohertz","megahertz","millihertz","radian/hour","radian/minute",
		"radian/second","revolution/hour","revolution/minute","revolution/second","terrahertz"};

	for(iIndex = 0 ; iIndex < 17 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcFrequency(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[17]={1.0,1.0,1.0/1296000.0,1.0/21600.0,1.0/360.0,1000000000.0,1.0,
		1000.0,1000000.0,1.0/1000.0,1.0/22619.467,1.0/376.99112,1.0/6.2831853,
		1.0/3600.0,1.0/60.0,1.0,1000000000000.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}


BOOL CALLBACK ViscosityDynProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadViscosityDynComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadViscosityDynComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcViscosityDyn(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadViscosityDynComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][23]={"centipoise","decipoise","dyne second/cm²","gram-force sec/cm²",
        "gram/cm sec","hyl/meter sec","kg-force sec/m²","Kg/meter hour","kg/meter sec",
		"millipascal sec","millipoise","newton second/m²","pascal second","poise",
		"poiseuille [France]","pound-force sec/ft²","pound-force sec/in²",
		"pound/foot hour","pound/foot sec","poundal hour/ft²","poundal sec/ft²",
		"reyn","slug/foot sec"};

	for(iIndex = 0 ; iIndex < 23 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcViscosityDyn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[23]={0.001,0.01,0.1,98.0665,0.1,9.80665,9.80665,1.0/3600.0,1.0,0.001,0.0001,
		1.0,1.0,0.1,1.0,47.880259,6894.75729,0.00041337887,1.4881639,0.00041337887,
		 1.4881639,6894.75729,47.880259};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}



BOOL CALLBACK ViscosityKinaticProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadViscosityKinaticComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadViscosityKinaticComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcViscosityKinatic(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadViscosityKinaticComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"centistokes","lentor","liter/cm day","liter/cm hour",
		"liter/cm minute","liter/cm second","poise cm³/gram","cm²/day","cm²/hour",
		"cm²/minute","cm²/second","ft²/day","ft²/hour","ft²/minute","ft²/second",
		"in²/day","in²/hour","in²/minute","in²/second","m²/day","m²/hour","m²/minute",
        "m²/second","mm²/day","mm²/hour","mm²/minute","mm²/second","stokes"};

	for(iIndex = 0 ; iIndex < 28 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcViscosityKinatic(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[28]={0.000001,0.0001,1.0/864000.0,1.0/36000.0,1.0/600.0,0.1,0.0001,
		1.0/864000000.0,1.0/36000000.0,1.0/600000.0,0.0001,0.0000010752667,
		0.00002580640,2.4,0.09290304,7.4671296e-9,0.00000017921111,0.000010752667,
		0.00064516,1.0/86400.0,1.0/3600.0,1.0/60.0,1.0,1.0/86400000000.0,
		1.0/3600000000.0,1.0/60000000.0,0.000001,0.0001};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}




BOOL CALLBACK AcclProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadAcclComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadAcclComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcAccl(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadAcclComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"celo","centigal","cm/square sec","decigal",
		"decimeter/square sec","dekameter/square sec","foot/square sec","g-unit (G)",
		"gal","galileo","gn","grav","hectometer/square sec","inch/square sec",
        "kilometer/hour sec","kilometer/square sec","leo","meter/square sec",
        "mile/hour min","mile/hour sec","mile/square sec","milligal",
		"millimeter/square sec"};

	for(iIndex = 0 ; iIndex < 23 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcAccl(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[23]={0.3048,0.0001,0.01,0.001,0.1,10.0,0.3048,9.80665,0.01,0.01,
		9.80665,9.80665,100.0,0.0254,0.277777777777778,1000.0,10.0,1.0,
		0.0074506666666666667,0.44704,1609.344,0.00001,0.001};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}





BOOL CALLBACK IlluminanceProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadIlluminanceComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadIlluminanceComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcIlluminance(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadIlluminanceComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"Footcandle","Lumen / cm²","Lumen / ft²","Lumen / m²","Lux",
        "Phot","Nox","Meter Candle"};

	for(iIndex = 0 ; iIndex < 8 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcIlluminance(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[8]={10.7639104,10000.0,10.7639104,1.0,1.0,.001,10000,1.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}



BOOL CALLBACK LuminanceProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadLuminanceComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadLuminanceComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcLuminance(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadLuminanceComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"Nit","Stilb","Lambert","Footlambert","Candela / m²",
		"Candela / cm²","Candela / ft²","Candela / in²"};

	for(iIndex = 0 ; iIndex < 8 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcLuminance(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[8]={1.0,10000.0,3183.098862,3.4262591,1.0,10180.0,10.9576608,
		1577.903156};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}



BOOL CALLBACK LengthExProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
		LoadLengthExComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadLengthExComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
		break;
	case WM_DRAWITEM: 
		{
			lpdis = (LPDRAWITEMSTRUCT) lparam; 
			if(lpdis->CtlType == ODT_COMBOBOX)
			{
				if(lpdis->CtlID == IDC_INPUTCB || lpdis->CtlID == IDC_OUTPUTCB)
				{
					CHAR strTemp[MAX_PATH];
					HBRUSH hbr = CreateSolidBrush(GetBkColor(lpdis->hDC));
					FillRect(lpdis->hDC,&lpdis->rcItem,hbr);
					DeleteObject(hbr);
					SendMessage(lpdis->hwndItem, CB_GETLBTEXT,lpdis->itemID,(LPARAM) strTemp);
					
					DrawText(lpdis->hDC,strTemp,-1,&lpdis->rcItem,DT_VCENTER | DT_SINGLELINE);
				}
			}
		}
		break;
	case WM_CTLCOLORLISTBOX:
	case WM_CTLCOLORSTATIC:
	case WM_CTLCOLORDLG:
		{
			SetBkColor((HDC)wparam,COMBO_TEXT_COLOR);
			SetTextColor((HDC)wparam,COMBO_BK_COLOR);
			return (BOOL)hBrGlobalBk;
		}
	case WM_COMMAND:
		switch(LOWORD(wparam))
		{
		case IDC_INPUT:
		case IDC_ENTER:
		case IDC_INPUTCB:
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iInputIndex,iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					iInputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_INPUTCB),CB_GETCURSEL,0,0);
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcLengthEx(&dinput,&doutput,iInputIndex,iOutputIndex);

					sprintf(szBuf,"%g",dinput);
					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					sprintf(szBuf,"%g",doutput);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_SETTEXT,sizeof(szBuf),(LPARAM)szBuf);
				}
			}
			break;
		}
		break;
	case WM_CLOSE:
		EndDialog(hwnd,0);
		return TRUE;
	}
	return FALSE;
}

int LoadLengthExComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][32]={"alen [Danish]","alen [Scandinavia]","alen [Swedish]","angstrom",
        "arms-length","arpent [Canada]","arpent [France]","arsheen [Russia]",
		"arshin [iran]","arshin [iraq]","astronomical unit","attometer","bamboo",
		"barleycorn","bee space","bicron","bohr","braccio [Italy]","braza [Argentina]",
		"braza [Spain]","braza [Texas]","button measure","cable [US]","cable [British]",
		"caliber","cana (canna, canne)","cape foot","cape inch","cape rood",
		"centimeter","chain [Gunter, survey]","chain [Ramsden, engineer]",
		"ch'ih [China]","chinese foot","chinese inch","chinese mile","chinese yard",
		"city block [East US]","city block [Midwest US]","city block [South, West US]",
		"click [US military]","cuadra","cuadra [Argentina]","cubit [Egyption]",
		"cubit [Royal Egyptian]","cubit [English]","cubit [Roman]","cuerda",
		"decimeter","dekameter","didot point","digit","diraa [Egypt]","dong [Vietnam]",
		"douzième [watchmaking]","douzième [print]","dra [Iraq]","dra [Russia]",
		"el [Dutch]","ell [English]","ell [Scotland]","elle [Germany]","elle [Vienna]",
		"em","estadio [Portugal]","estadio [Spain]","exameter","faden [Austria]",
		"faden [Switzerland]","fall [English]","fall [Scotland]","fathom",
		"fathom [ancient]","faust [Hungary]","feet [pre- Canada]","feet [Egypt]",
		"feet [France]","feet [international, US]","feet [iraq]","feet [Netherlands]",
		"feet [Rome]","feet [survey]","femtometer","fermi","finger","fingerbreadth",
		"fist","fod","foot [pre- Canada]","foot [Egypt]","foot [France]",
		"foot [international, US]","foot [iraq]","foot [Netherlands]","foot [Rome]",
		"foot [survey]","football field [Canada]","football field [US]",
		"football field [US, complete]","furlong [survey]","fuss [German]","gigameter",
		"gigaparsec","gnat's eye","goad","gry","hair's breadth","hand [non-equine]",
		"handbreadth","hat [Cambodia]","hectometer","heer","hubble","hvat [Croatia]",
		"inch [international, US]","iron","ken [Japan]","kerat","kilofoot",
		"kilometer","kiloparsec","kiloyard","kind","klafter [Austria]",
		"klafter [Switzerland]","klick","kyu","lap [old]","lap [competition]",
		"lap [olympic pool]","league [ancient Celtic]","league [nautical]",
		"league [UK nautical]","league [UK]","league [US statute]","leap","legoa",
		"legua","legua [Texas]","legua [Spanish, pre-]","legua [Spanish, post-]",
		"li [ancient China]","li [imperial China]","li [modern China]",
		"lieue [France]","lieue [France, metric]","lieue [France, nautical]",
		"light year","ligne [France]","ligne [Swiss]","line","line [small]",
		"link [Gunter, survey]","link [Ramden, engineer]","lug","lug [great]",
		"marathon","mark twain","megameter","megaparsec","meile [Austria]",
		"meile [geographische]","meile [North Germany]","meter","metre","metric mile",
		"metric mile [high school]","microinch","micrometer","micromicron","micron",
		"miglio","miil (mijl) [Danish]","miil (mijl) [Denmark]",
		"miil (mijl) [Sweden, ancient]","mil","mil [Sweden]","mile [Britain, ancient]",
		"mile [Irish]","mile [international]","mile [nautical, international]",
		"mile [nautical, UK]","mile [nautical, US]","mile [Roman, ancient]",
		"mile [Scottish]","mile [statute, UK]","mile [statute, US]","mile [survey, US]",
		"milha [Portuguese]","military pace","military pace [double time]",
		"milla [Spanish]","mille [French]","milliare [Rome]","millimeter","millimicron",
		"mkono [Africa]","moot [India]","myriameter","nail","nanometer","nanon",
		"pace [great]","pace [Roman]","palm [Dutch]","palm [Britain, Roman minor]",
		"palm [US, Roman major]","palmo [Portuguese]","palmo [Spanish]","palmo [Texas]",
		"parasang","Paris foot","parsec","pe [Portuguese]","pearl","perch",
		"perch [Ireland]","pertica","pes","petameter","pica","picometer",
		"pie [Argentina]","pie [Italian]","pie [Spanish]","pie [Texas]","pied de roi",
		"pik","pike [Greece]","point [Adobe]","point [Britain, US]","point [Didot]",
		"point [TeX]","pole","polegada [Portuguese]","pouce","pu [China]","pulgada",
		"pygme [Greece]","Q","quadrant","quarter","quarter [cloth]","quarter [print]",
		"range","reed [Israel]","ri [Japan]","ridge","river [Egypt]","rod","roede",
		"rood","rope","royal foot","rute [Germany]","sadzhen","sagene","Scots foot",
		"Scots mile","seemeile","shackle","shaftment","shaftment [ancient]",
		"shaku","siriometer","smoot","span","spat","stadium","step","stick","story",
		"stride [great]","stride [Roman]","tenthmeter","terameter","thou","toise",
		"township","t'sun","tu","twain","twip","U","vara [California]","vara [Mexico]",
		"vara [Portuguese]","vara [South America]","vara [Spanish]","vara [Texas]",
		"verge","vershok","verst","wah [Thailand]","werst","X unit","yard","yoctometer",
        "yottameter","zeptometer","zettameter","zoll [Germany]","zoll [Switzerland]"};

	for(iIndex = 0 ; iIndex < 303 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcLengthEx(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[303]={0.6277,0.6,0.5938,1.0e-10,0.70,58.47,58.471308,0.7112,1.04,
        74.5,149597870691,1.0e-18,3.2,0.0085,0.0065,1.0e-12,52.918e-12,0.70,1.733,
        1.67,1.693,0.000635,720.0*0.3048,608.0*0.3048,0.3048/12.0,2.0,0.314858,
		0.314858/12.0,3.778296,0.01,66.0*0.3048,100.0*0.3048,0.35814,0.371475,
		0.0371475,557.21,0.89154,(0.3048*5280.0)/20.0,(0.3048*5280.0)/16.0,
		(0.3048*5280.0)/10.0,1000.0,84.0,130.0,0.45,0.5235,0.4572,0.444,21.0,0.10,
		10.0,0.000377,0.019,0.58,(2.0 + (1.0/3.0))/100.0,0.000188,0.00017638888889,
		0.745,0.7112,0.69,1.143,0.945,0.6,0.7793,0.0042175176,261.0,174.0,1.0e+18,
		1.8965,1.8,6.858,5.67,6.0*0.3048,1.829,0.10536,0.325,0.36,0.3248406,0.3048,
		0.316,0.28313,0.296,1200.0/3937.0,1.0e-15,1.0e-15,(0.3048/12.0)*4.5,
		(0.3048/12.0)*0.75,0.1,0.3141,0.325,0.36,0.3248406,0.3048,0.316,0.28313,0.296,
		1200.0/3937.0,100.584,91.44,0.9144 * 120.0,(1200.0/3937.0)*660.0,0.31608,
		1.0e+9,30.85678e+24,0.000125,1.3716,0.000211667,0.0001,0.1016,0.08,0.5,100.0,
		73.152,9.4605e+24,1.8965,0.3048/12.0,(0.3048/12.0)/48.0,1.818,0.0286,304.8,
        1000.0,3.0856776e+19,914.4,0.5,1.8965,1.8,1000.0,0.00025,402.336,400.0,100.0,
        2275.0,5556.0,5559.552,4828.0,4828.0417,2.0574,6174.1,4200.0,4233.4,4179.4,
		6680.0,500.0,644.65,500.0,3898.0,4000.0,5556.0,9.460528405e+15,0.0021167,
		0.002256,0.0021167,0.000635,0.201168,0.3048,5.0292,6.4008,42194.988,3.6576074,
        1000000.0,3.0856776e+22,7586.0,7412.7,7532.5,1.0,1.0,1500.0,1600.0,2.54e-08,
        0.000001,1.0e-12,0.000001,1488.6,7500,7532.5,10687,0.0000254,10000,1609,2048,
		0.3048*5280.0,1852,0.3048*6080.0,1852.0,1520.0,1814.0,1609.344,
		(1200.0/3937.0)*5280.0,(1200.0/3937.0)*5280.0,2087.3,0.762,0.9144,1392,1949,
		0.001478,0.001,1.0e-9,0.4572,0.0762,10000,0.05715,1.0e-9,1.0e-9,1.524,1.48,
        0.10,0.075,0.2286,0.22,0.20,0.2117,6000,0.3248406,3.0856776e+16,0.33324,
        0.001757299,5.0292,6.4008,2.96,0.2967,1.0e+15,0.0042175176,1.0e-12,0.2889,
        0.298,0.2786,0.2822,0.3248406,0.71,0.71,(0.3048/12.0)/72.0,0.00035,0.000377,
        0.0003514598035,5.0292,0.02777,0.02707,1.7907,0.02365,0.346,0.00025,10001300,
        402.336,0.2286,0.00025,(1200.0/3937.0)*31680.0,2.679,3927,6.1722,2000,5.0292,
        10,3.7783,3.7783,0.3248406,3.75,2.1336,2.1336,0.30645,1814.2,1852,27.432,
        0.15124,0.165,0.3030,1.4959787e+17,1.7018,0.2286,1.0e+12,185,0.762,3.048,3.3,
        1.524,1.48,1.0e-10,1.0e+12,0.0000254,1.949,(1200.0/3937.0)*31680.0,0.0358,
        161130,3.6576074,0.000017639,0.04445,0.83820168,0.83802,1.10,0.864,0.83587,
        0.84666836,0.9144,0.04445,1066.8,2,1066.8,1.0020722e-13,0.9144,1.0e-24,
		1.0e+24,1.0e-21,1.0e+21,0.02634,0.03};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}