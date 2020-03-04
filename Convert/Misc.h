#ifndef MISC_H
#define MISC_H

#include <windows.h>
#include <stdio.h>
#include <math.h>
#include <commctrl.h>
#include <commdlg.h>
#include "resource.h"
#include "convert.h"

#pragma warning (disable : 4311)

#define MAX_INPUTLEN 30
#define PI 3.14159265358979

#define ERR(X) MessageBox(0,"Error",X,0)

BOOL CALLBACK FrequencyProc(HWND,UINT,WPARAM,LPARAM);
int LoadFrequencyComboBox(HWND,HINSTANCE);
int CalcFrequency(double*,double*,int,int);

BOOL CALLBACK ViscosityDynProc(HWND,UINT,WPARAM,LPARAM);
int LoadViscosityDynComboBox(HWND,HINSTANCE);
int CalcViscosityDyn(double*,double*,int,int);

BOOL CALLBACK ViscosityKinaticProc(HWND,UINT,WPARAM,LPARAM);
int LoadViscosityKinaticComboBox(HWND,HINSTANCE);
int CalcViscosityKinatic(double*,double*,int,int);

BOOL CALLBACK AcclProc(HWND,UINT,WPARAM,LPARAM);
int LoadAcclComboBox(HWND,HINSTANCE);
int CalcAccl(double*,double*,int,int);

BOOL CALLBACK IlluminanceProc(HWND,UINT,WPARAM,LPARAM);
int LoadIlluminanceComboBox(HWND,HINSTANCE);
int CalcIlluminance(double*,double*,int,int);

BOOL CALLBACK LuminanceProc(HWND,UINT,WPARAM,LPARAM);
int LoadLuminanceComboBox(HWND,HINSTANCE);
int CalcLuminance(double*,double*,int,int);

BOOL CALLBACK LengthExProc(HWND,UINT,WPARAM,LPARAM);
int LoadLengthExComboBox(HWND,HINSTANCE);
int CalcLengthEx(double*,double*,int,int);



#endif