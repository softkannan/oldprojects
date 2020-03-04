#include "area.h"

#pragma warning(disable:4100)
extern HINSTANCE ghInstance;
extern HBRUSH hBrGlobalBk;

BOOL CALLBACK AnglesProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
{
	LPDRAWITEMSTRUCT lpdis; 
	RECT r;
	POINT stPoint;
	switch(msg)
	{
	case WM_INITDIALOG:
		  
		  

		SetWindowLong(GetDlgItem(hwnd,IDC_INPUT),GWL_WNDPROC, reinterpret_cast<DWORD>(EditSubClassProc));  
		SetWindowLong(GetDlgItem(hwnd,IDC_OUTPUT),GWL_WNDPROC, reinterpret_cast<DWORD>(EditSubClassProc));  

		GetWindowRect(GetDlgItem(GetParent(hwnd),IDC_FRAMEDLG),&r);
		stPoint.x=r.left;
		stPoint.y=r.top;
		ScreenToClient(GetParent(hwnd),&stPoint);
		SetWindowPos(hwnd,0,stPoint.x,stPoint.y,r.right-r.left,r.bottom-r.top,SWP_SHOWWINDOW|SWP_NOOWNERZORDER);
		SetWindowText(GetDlgItem(hwnd,IDC_INPUT),"1");
		SetWindowText(GetDlgItem(hwnd,IDC_OUTPUT),"1");
        LoadAngComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadAngComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcAngles(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadAngComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][15]={"radians","mils","gradients","degrees","minutes","seconds",
		"points","1/16 circle","1/10 circle","1/8 circle","1/6 circle","1/4 circle",
		"1/2 circle","full circle"};

	for(iIndex = 0 ; iIndex < 14 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcAngles(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[14]={1.0,PI/3200.0,PI/200.0,PI/180.0,PI/(180.0*60.0),PI/(180.0*3600.0),
		PI/16.0,PI/8.0,PI/5.0,PI/4.0,PI/3.0,PI/2.0,PI,2.0*PI};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);
	return 0;
}




BOOL CALLBACK AreaProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadAreaComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadAreaComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcArea(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadAreaComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"circular mil","sq millimeter","cm dia. circle",
"sq centimeter","inch dia. circle","square inch","foot dia. circle","square foot",
"meter dia. circle","square yard","square meter","square rod","ares","rood","acres",
"hectares","square kilometers","square miles","square league","township"};

	for(iIndex = 0 ; iIndex < 20 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcArea(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[20]={5.067075e-10,.000001,7.8539816e-5,.0001,5.0670748e-4,6.4516e-4,
		.0729659,0.09290304,.78539816,.83612736,1,25.29285264,100.0,1011.7141056,
		4046.8564224,10000.0,1000000.0,2589988.110336,2.3309892993024E7,9.3239571972096E7};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}


BOOL CALLBACK AreaForignProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadAreaForignComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadAreaForignComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcAreaForign(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadAreaForignComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"Sq foot","acre","sq meter","hectare","Flag, pace",
		"roll(wallpaper)","square(roofing)","sq. Scottish ell","fall","arpent",
		"Scottish acre","yoke, joch","Irish acre","Cheshire acre","hide",
		"quarter section","labor(Texas)","barony","sq. pes(Rom)","sq. alen(Den)",
		"ferfet(Ice)","shaku(Jap)","sq. vara(Spn)","donum(Yug)","sahme(Egp)",
		"tavola(Ita)","cuadra(Par)","acaena(Gre)","plethron(Gre)"};

	for(iIndex = 0 ; iIndex < 29 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcAreaForign(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[29]={1.0,43560.0,10.76387,107663.87,25.0,30.0,100.0,1369.0/144.0,1369.0/4.0,
		36956.21958,55350.0,61855.2,70560.0,92160.0,435600.0,6969600.0,7716218.4,
		1.7424e8,.940901,4.10326,1.06,.988,(102.33/16.0),7534.70809,78.48,405.0,
		80586.0,99.0,10236.6};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}


BOOL CALLBACK AstroProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadAstroComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadAstroComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcAstro(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadAstroComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][10]={"meters","km","mil","light-sec",
		"A.U.","light-yr","parsec","solar dia",
		"earth dia"};

	for(iIndex = 0 ; iIndex < 9 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcAstro(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[9]={1e-3,1,1.609344,299792.458,1.49598073e8,9.460753090819e12,
		3.0856780e13,1.3919e6,1.2742630e4};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}


BOOL CALLBACK DensityProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadDensityComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadDensityComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcDensity(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadDensityComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"kg/cm","lbm/cu-foot","lbm/gallon(US-liq)","slug/cu-foot",
		"gram/cu-cm","kg/liter","met-ton/cu-meter","long-ton/cu-yard",
		"lbm/cu-inch","short-ton/cu-foot","kg/cu-cm","aluminum","iron","copper",
        "lead","gold","silver","water"};

	for(iIndex = 0 ; iIndex < 18 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcDensity(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[18]={1.0,16.02,119.8264,515.3788,1000.0,1000.0,1000.0,1328.939,27679.9,
		32040.0,1000000.0,2643.0,7658.0,8906.0,11370.0,19300.0,10510.0,1000.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}






BOOL CALLBACK EnergyProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadEnergyComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadEnergyComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcEnergy(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadEnergyComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"ergs","joules","kilocalories","foot-poundals","foot-lbs",
"Kg force-meters","BTU","kilowatt-hrs","horsepower-hrs","Ton of TNT"};

	for(iIndex = 0 ; iIndex < 10 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcEnergy(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[10]={1e-7,1,4184,.04214011,1.355818,9.80665,1055.056,3600000,
		2686088.6,4.18e9};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}





BOOL CALLBACK ForceProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadForceComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadForceComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcForce(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadForceComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"dyne","gram-force","poundals","newtons","pounds",
		"kilopond(kgm-force)","Kip"};

	for(iIndex = 0 ; iIndex < 7 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcForce(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[7]={1e-5,.00980665,.138255,1.0,4.448222,9.80665,4448.222};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK FlowProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadFlowComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadFlowComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcFlow(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadFlowComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"milliliter/sec","cu in/sec","liter/sec","cu ft/sec",
		"cu meter/sec","milliliter/min","cu in/min","liter/min","cu ft/min",
        "cu meter/min","milliliter/hr","cu in/hr","liter/hr","cu ft/hr",
        "cu meter/hr"};

	for(iIndex = 0 ; iIndex < 15 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcFlow(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[15]={1.0,16.387064,1000,28316.846592,1e6,0.0166666666667,
		0.2731177333334,16.6666666667,471.9474432,16666.6666666667,
        2.777777777778E-4,0.0045519622222223,0.277777777778,7.86579072,
		277.7777777778};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}


BOOL CALLBACK KitchenProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadKitchenComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadKitchenComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcKitchen(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadKitchenComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"drop","dash","pinch","milliliter/cc","coffee spoon",
		"fluid dram","teaspoon (US)","teaspoon (UK)","tablespoon (US)",
		"tablespoon (UK)","fluid ounce (US)","fluid ounce (UK)","cup (US)",
        "cubic inch","gill (US)","gill (UK)","pint (US liq.)","pint (US dry)",
        "pint (UK)","quart (US liq.)","quart (US dry)","liter","gallon (US liq.)",
		"gallon (US dry)","gallon (UK)","peck","bushel (int. std.)"};

	for(iIndex = 0 ; iIndex < 27 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcKitchen(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[27]={.06485423519737,.3080576,.6161152,1.0,1.2322305,3.6966914,
        4.9289219,4.6207343,14.786766,18.482937,29.573531,28.413075,236.58825,
		16.38706,118.2941,142.0654,473.1765,550.6105,568.2615,946.3529,1101.221,
		1000.0,3785.412,4404.884,4546.092,8809.768,35239.07};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK LengthProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadLengthComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadLengthComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcLength(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadLengthComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"Angstroms","nanometers(nm)","microinch","microns",
        "mils","millimeters(mm)","centimeters(cm)","inches","hands","links",
		"spans","feet","US Survey Feet","cubits","varas (Texas)","yards",
		"meters(m)","fathoms","rods,perches,poles","surveyors chains","furlongs",
		"cable lengths","kilometers","miles","nautical mile","league (US survey)",
		"naut league (US&Int.)"};

	for(iIndex = 0 ; iIndex < 27 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcLength(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[27]={1e-10,1e-9,2.54e-8,1e-6,2.54e-5,1e-3,.01,.0254,.1016,.201168,
		.2286,.3048,0.30480060960,.4318,.0254*(33+1.0/3.0),.9144,1,1.8288,5.0292,20.1168,
        201.168,219.456,1000.0,1609.344,1852.0,4828.042,5556.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK LengthAnProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadLengthAnComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadLengthAnComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcLengthAn(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadLengthAnComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"centimeters","inches","feet","meters","miles","Assbaa (Arb)",
		"Arabian Foot","Ghalva (Arb)","Pechya, Cubit (Gre)","Stadion (Gre)",
		"Hasta, Cubit (Ind)","Charac (Per)","Cane (Per)","Chebel (Per)",
		"Stadium (Per)","Assyrian Foot","Pes, Roman Foot","Cubit (Rom)",
		"Roman Pace","Stadium (Rom)"};

	for(iIndex = 0 ; iIndex < 20 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcLengthAn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[20]={.01,.0254,.3048,1,1609.344,.02,.319187188,230.4292536,.462687311,
		185.0749242,.64160526,.260096512,3.84048756,21.0312414,214.5796224,2.630424,
		.295656584,.443484876,1.47828292,184.785365};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK LengthFnProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadLengthFnComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadLengthFnComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcLengthFn(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadLengthFnComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"centimeters","inches","feet","meters","miles","sun (Jap)",
		"paletz (Rus)","elle (Est)","verst (Rus)","pulgada (Spn)","pie (Spn)",
        "linje (Swe)","fot (Swe)","Swedish mile","ligne (Swit)",
		"fuss,schun,pied (Swit)","vara (Arg)","klafter (Arg)","pe (Bra)",
		"covado (Bra)","new ch'ih (Chn)","old li (Chn)","new li #1 (Chn)",
		"new li #2 (Chn)","fod (Den)","theb (Egp)","kassabah (Egp)","fet (Ice)",
		"guz (Ind)","stopa (Pol)","keup (Thai)","sen (Thai)","palaz (Yug)",
		"rif (Yug)","khvat (Yug)"};

	for(iIndex = 0 ; iIndex < 35 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcLengthFn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[35]={.01,.0254,.3048,1,1609.344,.03048006,.012700025,.533401050,
		1065.2752,.023225806,.278709696,.020778511,.296672584,10000,.0020833333,.3,
        .86624331,1.89281173,.32918465,.684785348,.35814071,644.640102,.001,1000,
		.31369163,.018745237,3.55007355,.31394462,.9144018,.288036567,.25,335.24,
        .036307848,.77698794,1.8961137};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK MassProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadMassComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadMassComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcMass(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadMassComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"grains","scruples (Apoth.)","carats","grams","pennyweight",
		"dram (Avoir.)","dram (Apoth.)","ounces (Avoir.)","ounces (Troy,Apoth.)",
        "poundals","pounds (Troy)","pounds (Avoir.)","kilograms","stone",
		"quarter (US)","slugs","100 weight (US cwt.)","short tons",
		"metric tons (tonne)","long tons","cu. in. iron","cu. in. alum.",
		"cu. in. copper","cu. in. lead","cu. in. gold","cu. in. silver"};

	for(iIndex = 0 ; iIndex < 26 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcMass(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[26]={(1.0/7000.0),(20.0/7000.0),(.2/453.59237),(1.0/453.59237),(24.0/7000.0),
		(1.0/256.0),(6.0/700.0),0.0625,(480.0/7000.0),(1.0/32.2),(5760.0/7000.0),1,(1.0/0.45359237),14.0,
		25.0,32.2,100.0,2000.0,(1000.0/0.45359237),2240.0,.2850,.0977,.3232,.4105,.6136,.3799};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK MetricPrfxProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadMetricPrfxComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadMetricPrfxComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcMetricPrfx(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadMetricPrfxComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][15]={"unit","Yotta-unit","Zetta-unit","Exa-unit","Peta-unit",
		"Tera-unit","Giga-unit","Mega-unit","Myria-unit","kilo-unit","hecto-unit",
		"deca-unit","deci-unit","centi-unit","milli-unit","micro-unit","nano-unit",
		"pico-unit","femto-unit","atto-unit","zepto-unit","yocto-unit"};

	for(iIndex = 0 ; iIndex < 22 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcMetricPrfx(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[22]={1.0,1e24,1e21,1e18,1e15,1e12,1e9,1e6,1e5,1e3,1e2,10.0,.1,.01,
		.001,1e-6,1e-9,1e-12,1e-15,1e-18,1e-21,1e-24};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK WineProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadWineComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadWineComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcWine(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadWineComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"milliliters","liters","shot(ounce)","pony","jigger","double",
        "triple","noggin/gill (UK)","fifth","wine bottle","magnum","yard","jeroboam",
		"rehoboam","methusaleh","salmanezer","balthazar","nebuchadnezzar",
		"gallon (US liq)","gallon (ale/beer)","barn gallon","cantaro","arroba",
		"firkin","keg","anker","runlet/kilderkin","octave","british bottle","aum",
		"wine barrel","beer barrel","English beer barrel","tierce",
		"beer/ale hogshead (UK)","wine hogshead (UK)","beer/ale puncheon",
		"wine puncheon","beer/ale butt/pipe","wine butt/pipe","beer/ale tun(UK)",
		"wine tun(UK)"};

	for(iIndex = 0 ; iIndex < 42 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcWine(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[42]={1.0,1000.0,29.5727,22.179525,44.35905,59.1454,88.7181,142.0636,
		757.0611,750.0,1500.0,2365.816,3000.0,4500.0,6000.0,9000.0,12000.0,15000.0,3785.3056,4620.0,
		11365.1663,13521.1108,16125.8644,34067.75,37853.056,45460.662,68135.5008,
		71600.546,95467.3969,113559.1680,119237.1264,136271.0016,163650.0,158982.8352,
		245490.8467,286402.1908,272542.0032,317965.6704,490981.6934,572804.3816,
		981963.3868,1145608.7632};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK VolumeProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadVolumeComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadVolumeComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcVolume(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadVolumeComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"milliliter/cc","fluid ounce (US)","cubic inch","gill (US)",
		"gill (UK)","pint (US liq.)","pint (US dry)","quart (US liq.)",
		"quart (US dry)","liter","board-foot","gallon (US liq.)","gallon (US dry)",
		"gallon (UK)","peck","cubic foot","bushel (int. std.)","barrel (US liq.)",
		"barrel (crude oil)","hogshead","cubic yard","tun","stere (cubic meter)",
		"chaldron","register ton","cord","acre-foot"};

	for(iIndex = 0 ; iIndex < 27 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcVolume(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[27]={.001,.029573531,.01638706,.118294125,.1420654,.4731765,
        .5506105,.9463529,1.101221,1,2.359737,3.785412,4.404884,4.546092,8.809768,
        28.31685,35.23907,119.240478,158.9873,238.480956,764.5549,953.92,1000.0,1268.61,
        2831.685,3624.556,1233489.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK NumbersProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadNumbersComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadNumbersComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcNumbers(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadNumbersComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"units","million","billion","billion(UK obs)","trillion",
		"trillion(UK obs)","quadrillion","quadrillion(UK obs)","quintillion",
		"quintillion(UK obs)","sextillion","sextillion(UK obs)","septillion",
		"septillion(UK obs)","octillion","octillion(UK obs)","nonillion",
		"nonillion(UK obs)","decillion","decillion(UK obs)","undecillion",
		"duodecillion","tredecillion","quatuordecillion","quindecillion",
		"sexdecillion","septendecillion","octodecillion","novemdecillion",
		"vigintillion","googol"};

	for(iIndex = 0 ; iIndex < 31 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcNumbers(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[31]={1.0,1e6,1e9,1e12,1e12,1e18,1e15,1e24,1e18,1e30,1e21,1e36,1e24,
		1e42,1e27,1e48,1e30,1e54,1e33,1e60,1e36,1e39,1e42,1e45,1e48,1e51,1e54,1e57,
		1e60,1e63,1e100};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK PowerProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadPowerComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadPowerComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcPower(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadPowerComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"ergs/sec","watts (joules/sec)","kiloCalories/min",
        "kiloCalories/sec","BTU/hour","foot-lbs/sec","horsepower","kilowatts",
		"megawatts","gigawatts"};

	for(iIndex = 0 ; iIndex < 10 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcPower(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[10]={1e-7,1.0,69.7333,4184.0,.2928751,1.355818,746.0,1e3,1e6,1e9};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK PressureProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadPressureComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadPressureComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcPressure(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadPressureComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"dyne/square cm","Pascal (newton/sq m)","poundal/sq foot",
        "kgf/square meter","lbf/square foot","cm H2O (4 C)","gram force/sq cm",
		"torr (0 C)","inch H2O (60 F)","inch H2O (39.2 F)","cm mercury (0 C)",
		"foot H2O (39.2 F)","foot seawater","inch mercury (60 F)",
		"inch mercury (32 F)","lbf/square inch (PSI)","meter seawater",
		"kgf/square cm","bar","atmosphere","Kip/square inch (KSI)",
		"kgf/sq millimeter","megaPascal(MPa)"};

	for(iIndex = 0 ; iIndex < 23 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcPressure(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[23]={.1,1.0,1.488164,9.80665,47.88026,98.0638,98.0665,133.322,
		248.84,249.082,1333.22,2988.98,3068.167,3376.85,3386.389,6894.757,10066.345,
		98066.5,100000.0,101325.0,6894757.0,9806650.0,1000000.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK SpeedProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadSpeedComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadSpeedComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcSpeed(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadSpeedComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"centimeters/sec","meters/sec","feet/day","meters/day",
		"feet/sec","feet/min","miles/hr","kilometers/hr","furlongs/min","knots",
		"leagues/day","Mach"};

	for(iIndex = 0 ; iIndex < 12 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcSpeed(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[12]={.01,1.0,3.527777777777778e-6,1.1574074074074073E-5,.3048,
		0.3048/60.0,.44704,.27777778,3.3528,.514444,.05588,331.622};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK SpringProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadSpringComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadSpringComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcSpring(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadSpringComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][10]={"lbf/in","lbf/ft","lbf/yd","kip/in","kip/ft","kip/yd",
		"kN/mm","N/mm","N/cm","N/m","gf/mm","gf/cm","gf/m"};

	for(iIndex = 0 ; iIndex < 13 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcSpring(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[13]={1.0000,12.0000,36.0000,0.0010,0.0120,0.0360,0.000175126835246,
		0.175126835246,1.75126835246,175.126835246,17.8579673228,178.579673228,
		17857.9673228};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}


BOOL CALLBACK TempProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadTempComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadTempComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcTemp(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadTempComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"degrees Celcius","degrees Fahrenheit","degrees Kelvin",
		"degrees Rankine","degrees Reamur"};

	for(iIndex = 0 ; iIndex < 5 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcTemp(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	
	switch(iInputIndex)
	{
	case 0:
		switch(iOutputIndex)
		{
		case 0:
			*doutput=(*dinput);
			break;
		case 1:
            *doutput=9.0/5.0 * (*dinput) + 32.0;
			break;
		case 2:
            *doutput= 273.15 + 1.0*(*dinput);
			break;
		case 3:
			*doutput=9.0/5.0*(*dinput)+32.0+459.67;
			break;
		case 4:
			*doutput=0.8*(*dinput);
			break;
		}
		break;
	case 1:
		switch(iOutputIndex)
		{
		case 0:
			*doutput=5.0/9.0*((*dinput)-32.0);
            break;
		case 1:
			*doutput=(*dinput);
            break;
		case 2:
			*doutput=5.0/9.0*((*dinput)-32.0)+273.15;
            break;
		case 3:
			*doutput=459.67 + 1.0*(*dinput);
            break;
		case 4:
			*doutput=4.0/9.0*((*dinput)-32.0);
            break;
		}
		break;
	case 2:
		switch(iOutputIndex)
		{
		case 0:
			*doutput=(*dinput)-273.15;
            break;
		case 1:
			*doutput=9.0/5.0*((*dinput)-273.15)+32.0;
            break;
		case 2:
			*doutput=(*dinput);
            break;
		case 3:
			*doutput=9.0/5.0*((*dinput)-273.15)+32.0+459.67;
            break;
		case 4:
			*doutput=0.8*((*dinput)-273.15);
			break;
		}
		break;
	case 3:
		switch(iOutputIndex)
		{
		case 0:
			*doutput=5.0/9.0*((*dinput)-32.0-459.67);
            break;
		case 1:
			*doutput=(*dinput)-459.67;
            break;
		case 2:
			*doutput=5.0/9.0*((*dinput)-32.0-459.67)+273.15;
			break;
		case 3:
			*doutput=(*dinput);
            break;
		case 4:
			*doutput=0.8*(5.0/9.0*((*dinput)-32.0-459.67));
            break;
		}
		break;

	case 4:
		switch(iOutputIndex)
		{
		case 0:
			*doutput=5.0/4.0*(*dinput);
			break;
		case 1:
			*doutput=9.0/4.0*(*dinput) + 32.0;
			break;
		case 2:
			*doutput=273.15 + 5.0/4.0*(*dinput);
            break;
		case 3:
			*doutput=9.0/4.0*(*dinput)+32.0+459.67;
			break;
		case 4:
			*doutput=(*dinput);
            break;
		}
		break;
	}
	return 0;
}



BOOL CALLBACK TimeConvProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadTimeConvComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadTimeConvComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcTimeConv(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadTimeConvComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"shake","second","minute","minute (sidereal)","hour","day",
		"week","fortnight","month","quarter","year (calendar)","year (sidereal)",
		"year (tropical)","decade","century","millennium"};

	for(iIndex = 0 ; iIndex < 16 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcTimeConv(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[16]={1e-8,1.0,60.0,59.83617,3600.0,86400.0,604800.0,1209600.0,2628000.0,7884000.0,
		31536000.0,31558150.0,31556930.0,315576000.0,3155673600.0,31556908800.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK TorqueProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadTorqueComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadTorqueComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcTorque(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadTorqueComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"Pound-Feet","Inch-pounds","Kgf-meters","Meter-Newtons"};

	for(iIndex = 0 ; iIndex < 4 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcTorque(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[4]={1.0,1.0/12.0,1.0/0.13825496,1.0/1.357};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK TypoProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadTypoComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadTypoComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcTypo(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadTypoComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][15]={"millimeters","centimeters","inches","points","excelsior",
		"brilliant","ciceros","diamond","pearl","agate","nonpareil","mignonette",
		"mignon","brevier","borgeois","long primer","small pica","pica","english",
        "columbian","great primer","paragon","meridian","canon","stick"};

	for(iIndex = 0 ; iIndex < 25 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcTypo(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[25]={(72.0/25.4),(72.0/2.54),72.0,1.0,3.0,3.5,72.0*4.55/25.4,4.0,5.0,5.5,6.0,6.5,7.0,8.0,
		9.0,10.0,11.0,12.0,14.0,16.0,18.0,20.0,44.0,48.0,144.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK ViscosityProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadViscosityComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadViscosityComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcViscosity(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadViscosityComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"poise","centipoise","lbf-S/square foot","N-S/ square meter",
		"Water(20 C)","Water(40 C)","Heavy Oil(20 C)","Heavy Oil(40 C)",
		"Glycerin(20 C)","Glycerin(40 C)","SAE 5W(-18 C)","SAE 10W(-18 C)",
		"SAE 20(-18 C)","SAE 5W(99 C)","SAE 10W(99 C)","SAE 20(99 C)"};

	for(iIndex = 0 ; iIndex < 16 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcViscosity(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[16]={1.0,.01,478.698,10.0,.01,.0065,4.5,1.1,14.1,2.84,12.0,24.0,96.0,.039,
		.042,.0572};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK VolumeAnProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadVolumeAnComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadVolumeAnComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcVolumeAn(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadVolumeAnComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"milliliter/cc","cubic inch","liter","gallon (US liq.)",
		"caphite(Arb)","water ton(Bri)","ale gallon(Bri)","cantaro(Spn)",
		"oxybaphon(Gre)","cotula,hemina(Gre)","cyathos(Gre)","cados(Gre)",
		"metretes,amphura(Gre)","mushti(Ind)","cab(Isr)","hekat(Isr)",
		"bath,bu(Isr)","acetabulum(Rom)"};

	for(iIndex = 0 ; iIndex < 18 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcVolumeAn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[18]={.001,.01638706,1,3.785412,1.3741046,1018.3262432 ,4.62 ,
		13.5211108 ,.066245 ,.3083505 ,.4515132 ,38.0433566 ,39.001092 ,.0609653 ,
		2.2025036 ,4.7686752 ,36.8712 ,.0660752};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK VolumeFnProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadVolumeFnComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadVolumeFnComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcVolumeFn(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadVolumeFnComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"milliliter/cc","cubic inch","liter","gallon (US liq.)",
		"frasco(Arg)","fanega(Arg)","becher(Ast)","pfiff(Ast)","garrafa(Bra)",
		"pipa(Bra)","oka(Cyp)","cass(Cyp)","paegl(Den)","achtel(Den)","tonde(Den)",
		"viertel(Den)","toumnah(Egp)","artaba(Egp)","apt(Egp)","roquille(Fra)",
		"chopine(Fra)","quarte(Fra)","hemine(Fra)","pottar(Ice)","oltunna(Ice)",
		"sho(Jap)","shaku(Jap)","bozze(Lib)","misura(Lib)","mattaro(Lib)",
		"teman(Lib)","cuartillo(Mex)","cuarteron(Mex)","barril(Mex)","fanega(Mex)",
		"vingerhoed(Neth)","mattje(Neth)","mingelen(Neth)","kwarterka(Pol)",
		"selamin(Por)","meio(liq)(Por)","fanga(Por)","charka(Rus)","tchast(Rus)",
		"copa,cuarteron(Spn)","octavillo(Spn)","carga(Spn)","jumfru(Swe)",
		"foder(Swe)","pot,maass,immi(Swi)","viertel,muid(Swi)","moule(Swi)",
		"apatan(Phil)"};

	for(iIndex = 0 ; iIndex < 53 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcVolumeFn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[53]={.001,.01638706,1.0,3.785412,2.3749909,137.2011735,.0479045 ,
		.1768885 ,.6662324,479.2331086,1.2784634,4.7317645,.24132,2.1694661,
		13.1391637,26.6492977,.2577629,38.7640634,65.8989077,.0291,.05015671,
		3.2486928,50.0,.9663304,131.4209357,1.806053,31.1770308,2.68,16.5,23.32,
		26.78,.4561421,25.0,63.29,90.81,.01 ,.1 ,1.21,.25,.433,.698,55.4,.03 ,.109 ,
		.126 ,.29 ,222.0,.082 ,942.8,1.505 ,14.66,3998.8,.094};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK WeightProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadWeightComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadWeightComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcWeight(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadWeightComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"grains","scruples (Apoth.)","carats","grams","pennyweight",
		"dram (Avoir.)","dram (Apoth.)","ounces (Avoir.)","ounces (Troy,Apoth.)",
		"poundals","pounds (Troy)","pounds (Avoir.)","kilograms","stone",
		"quarter (US)","slugs","100 weight (US cwt.)","short tons",
		"metric tons (tonne)","long tons","cu. in. iron","cu. in. alum.",
		"cu. in. copper","cu. in. lead","cu. in. gold","cu. in. silver"};

	for(iIndex = 0 ; iIndex < 26 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcWeight(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[26]={(1.0/7000.0),(20.0/7000.0),(.2/453.59237),(1.0/453.59237),(24.0/7000.0),
		(1.0/256.0),(6.0/700.0),0.0625,(480.0/7000.0),(1.0/32.2),(5760.0/7000.0),1.0,(1.0/0.45359237),
		14.0,25.0,32.2,100.0,2000.0,(1000.0/0.45359237),2240.0,.2850,.0977,.3232,.4105,.6136,
		.3799};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}




BOOL CALLBACK WeightAnProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadWeightAnComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadWeightAnComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcWeightAn(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadWeightAnComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"grains","grams","ounces (Avoir.)","pounds (Avoir.)",
		"kilograms","mancus (Bri)","merchants pound (Bri)","mast (Bri)",
		"talent (Heb)","kona (Ind)","pala (Ind)","uncia (Rom)","kerat (Egp)",
		"kat (Egp)","okia (Egp)","oka (Egp)","oka (Gre)","talanton (Gre)"};

	for(iIndex = 0 ; iIndex < 18 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcWeightAn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[18]={(.45359237/7000.0),.001,.45359237/16.0,.45359237,1.0,.0622069536 ,
		.4976556288 ,.933104304 ,26.332 ,.0069982823 ,.047173 ,.027164 ,.000195044,
		.009331 ,.03744027 ,1.248 ,1.2799 ,149.9985};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK WeightFnProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadWeightFnComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadWeightFnComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcWeightFn(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadWeightFnComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][25]={"grains","grams","ounces (Avoir.)","pounds (Avoir.)",
		"kilograms","catty (Asia)","french footweight (Fra)","niyo (Jap)",
		"hiyaku-me (Jap)","pond (Neth)","funt (Pol)","libra (Port)","funt (Rus)",
		"marco (Spn)","libra (Spn)","skalpund,pund (Swe)","oka,oke (Yug)",
		"wagon (Yug)"};

	for(iIndex = 0 ; iIndex < 18 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcWeightFn(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[18]={(.45359237/7000.0),.001,.45359237/16.0,.45359237,1.0,.60477471 ,
		28.3152769 ,.014 ,.374985 ,.499944 ,.405511 ,.45909 ,.41124 ,.23004 ,
		.4601241 ,.425101 ,1.28 ,10000.0};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}



BOOL CALLBACK WeightSpaProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadWeightSpaComboBox(GetDlgItem(hwnd,IDC_INPUTCB),ghInstance);
		LoadWeightSpaComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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

					CalcWeightSpa(&dinput,&doutput,iInputIndex,iOutputIndex);

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

int LoadWeightSpaComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][15]={"SUN","MERCURY","VENUS","EARTH","The Moon","MARS","Phobos",
		"Deimos","JUPITER","Io","Europa","Ganymede","Callisto","Amalthea",
		"Hestia","Hera","Poseidon","Hades","Demeter","Pan","Adrastea",
		"SATURN","Mimas","Enceladus","Tethys","Dione","Rhea","Titan",
		"Hyperion","Iapetus","Phoebe","Themis/Janus","URANUS","Ariel",
		"Umbriel","Titania","Oberon","Miranda","NEPTUNE","Triton","Nereid",
		"PLUTO","Ceres","Pallas","Juno","Vesta"};

	for(iIndex = 0 ; iIndex < 46 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcWeightSpa(double *dinput,double *doutput,int iInputIndex,int iOutputIndex)
{
	double factor[46]={27372.0,357.8,887.4,980.7,162.0,374.0,1.67,.49,2601.0,176.0,144.0,
		160.0,84.0,7.28,5.61,1.67,1.51,1.0,.73,1,.84,1117.0,3.33,5.51,9.72,10.01,
		14.89,140.0,11.21,36.09,7.36,13.45,1049.0,34.69,22.43,55.77,44.72,13.5,
		1325.0,241.0,18.0,221.0,28.9,21.2,12.6,17.5};

    *doutput=(*dinput) * (factor[iInputIndex] / factor[iOutputIndex]);

	return 0;
}




BOOL CALLBACK DiffWorldProc(HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam)
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
		LoadDiffWorldComboBox(GetDlgItem(hwnd,IDC_OUTPUTCB),ghInstance);
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
		case IDC_OUTPUTCB:
			switch(HIWORD(wparam))
            {
			case EN_KILLFOCUS:
			case CBN_SELCHANGE:
			case BN_CLICKED:
				{
					double dinput,doutput;
					int iOutputIndex;
					TCHAR szBuf[MAX_INPUTLEN];

					SendMessage(GetDlgItem(hwnd,IDC_INPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					dinput=atof(szBuf);
					SendMessage(GetDlgItem(hwnd,IDC_OUTPUT),WM_GETTEXT,sizeof(szBuf),(LPARAM)szBuf);
					doutput=atof(szBuf);
					
					iOutputIndex=(int)SendMessage(GetDlgItem(hwnd,IDC_OUTPUTCB),CB_GETCURSEL,0,0);

					CalcDiffWorld(&dinput,&doutput,iOutputIndex);

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

int LoadDiffWorldComboBox(HWND hwnd,HINSTANCE hInstance)
{
	int iIndex;

	TCHAR szBuf[][15]={"Mercury","venus","THE MOON","mars","jupiter","saturn","uranus",
		"neptune","pluto","io","europa","ganymede","callisto","sun","white dwarf",
		"NEUTRON STAR"};

	for(iIndex = 0 ; iIndex < 16 ; iIndex++)
	{
		SendMessage(hwnd,CB_ADDSTRING,0,(LPARAM)szBuf[iIndex]);
	}
	SendMessage(hwnd,CB_SETCURSEL,0,0);

	return 0;
}
int CalcDiffWorld(double *dinput,double *doutput,int iOutputIndex)
{
	double factor[16]={.378,.907,.166,.377,2.364,1.064,.889,1.125,.067,.1264,.13358,
		.1448,.18355,27.072,1.3E+6,1.4E+11};

	*doutput=(*dinput)*factor[iOutputIndex];

	return 0;
}

