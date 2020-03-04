#ifndef AREA_H
#define AREA_H

#include <windows.h>
#include <stdio.h>
#include <math.h>
#include <commctrl.h>
#include <commdlg.h>
#include "resource.h"
#include "convert.h"

#define MAX_INPUTLEN 30
#define PI 3.14159265358979

#pragma warning (disable : 4311)

#define ERR(X) MessageBox(0,"Error",X,0)


BOOL CALLBACK AnglesProc(HWND,UINT,WPARAM,LPARAM);
int LoadAngComboBox(HWND,HINSTANCE);
int CalcAngles(double*,double*,int,int);

BOOL CALLBACK AreaProc(HWND,UINT,WPARAM,LPARAM);
int LoadAreaComboBox(HWND,HINSTANCE);
int CalcArea(double*,double*,int,int);

BOOL CALLBACK AreaForignProc(HWND,UINT,WPARAM,LPARAM);
int LoadAreaForignComboBox(HWND,HINSTANCE);
int CalcAreaForign(double*,double*,int,int);

BOOL CALLBACK AstroProc(HWND,UINT,WPARAM,LPARAM);
int LoadAstroComboBox(HWND,HINSTANCE);
int CalcAstro(double*,double*,int,int);

BOOL CALLBACK DensityProc(HWND,UINT,WPARAM,LPARAM);
int LoadDensityComboBox(HWND,HINSTANCE);
int CalcDensity(double*,double*,int,int);

BOOL CALLBACK EnergyProc(HWND,UINT,WPARAM,LPARAM);
int LoadEnergyComboBox(HWND,HINSTANCE);
int CalcEnergy(double*,double*,int,int);

BOOL CALLBACK ForceProc(HWND,UINT,WPARAM,LPARAM);
int LoadForceComboBox(HWND,HINSTANCE);
int CalcForce(double*,double*,int,int);

BOOL CALLBACK FlowProc(HWND,UINT,WPARAM,LPARAM);
int LoadFlowComboBox(HWND,HINSTANCE);
int CalcFlow(double*,double*,int,int);

BOOL CALLBACK KitchenProc(HWND,UINT,WPARAM,LPARAM);
int LoadKitchenComboBox(HWND,HINSTANCE);
int CalcKitchen(double*,double*,int,int);

BOOL CALLBACK LengthProc(HWND,UINT,WPARAM,LPARAM);
int LoadLengthComboBox(HWND,HINSTANCE);
int CalcLength(double*,double*,int,int);

BOOL CALLBACK LengthAnProc(HWND,UINT,WPARAM,LPARAM);
int LoadLengthAnComboBox(HWND,HINSTANCE);
int CalcLengthAn(double*,double*,int,int);

BOOL CALLBACK LengthFnProc(HWND,UINT,WPARAM,LPARAM);
int LoadLengthFnComboBox(HWND,HINSTANCE);
int CalcLengthFn(double*,double*,int,int);

BOOL CALLBACK MassProc(HWND,UINT,WPARAM,LPARAM);
int LoadMassComboBox(HWND,HINSTANCE);
int CalcMass(double*,double*,int,int);

BOOL CALLBACK MetricPrfxProc(HWND,UINT,WPARAM,LPARAM);
int LoadMetricPrfxComboBox(HWND,HINSTANCE);
int CalcMetricPrfx(double*,double*,int,int);

BOOL CALLBACK WineProc(HWND,UINT,WPARAM,LPARAM);
int LoadWineComboBox(HWND,HINSTANCE);
int CalcWine(double*,double*,int,int);

BOOL CALLBACK VolumeProc(HWND,UINT,WPARAM,LPARAM);
int LoadVolumeComboBox(HWND,HINSTANCE);
int CalcVolume(double*,double*,int,int);

BOOL CALLBACK NumbersProc(HWND,UINT,WPARAM,LPARAM);
int LoadNumbersComboBox(HWND,HINSTANCE);
int CalcNumbers(double*,double*,int,int);

BOOL CALLBACK PowerProc(HWND,UINT,WPARAM,LPARAM);
int LoadPowerComboBox(HWND,HINSTANCE);
int CalcPower(double*,double*,int,int);

BOOL CALLBACK PressureProc(HWND,UINT,WPARAM,LPARAM);
int LoadPressureComboBox(HWND,HINSTANCE);
int CalcPressure(double*,double*,int,int);

BOOL CALLBACK SpeedProc(HWND,UINT,WPARAM,LPARAM);
int LoadSpeedComboBox(HWND,HINSTANCE);
int CalcSpeed(double*,double*,int,int);

BOOL CALLBACK SpringProc(HWND,UINT,WPARAM,LPARAM);
int LoadSpringComboBox(HWND,HINSTANCE);
int CalcSpring(double*,double*,int,int);

BOOL CALLBACK TempProc(HWND,UINT,WPARAM,LPARAM);
int LoadTempComboBox(HWND,HINSTANCE);
int CalcTemp(double*,double*,int,int);

BOOL CALLBACK TimeConvProc(HWND,UINT,WPARAM,LPARAM);
int LoadTimeConvComboBox(HWND,HINSTANCE);
int CalcTimeConv(double*,double*,int,int);

BOOL CALLBACK TorqueProc(HWND,UINT,WPARAM,LPARAM);
int LoadTorqueComboBox(HWND,HINSTANCE);
int CalcTorque(double*,double*,int,int);

BOOL CALLBACK TypoProc(HWND,UINT,WPARAM,LPARAM);
int LoadTypoComboBox(HWND,HINSTANCE);
int CalcTypo(double*,double*,int,int);

BOOL CALLBACK ViscosityProc(HWND,UINT,WPARAM,LPARAM);
int LoadViscosityComboBox(HWND,HINSTANCE);
int CalcViscosity(double*,double*,int,int);

BOOL CALLBACK VolumeAnProc(HWND,UINT,WPARAM,LPARAM);
int LoadVolumeAnComboBox(HWND,HINSTANCE);
int CalcVolumeAn(double*,double*,int,int);

BOOL CALLBACK VolumeFnProc(HWND,UINT,WPARAM,LPARAM);
int LoadVolumeFnComboBox(HWND,HINSTANCE);
int CalcVolumeFn(double*,double*,int,int);

BOOL CALLBACK WeightProc(HWND,UINT,WPARAM,LPARAM);
int LoadWeightComboBox(HWND,HINSTANCE);
int CalcWeight(double*,double*,int,int);

BOOL CALLBACK WeightAnProc(HWND,UINT,WPARAM,LPARAM);
int LoadWeightAnComboBox(HWND,HINSTANCE);
int CalcWeightAn(double*,double*,int,int);

BOOL CALLBACK WeightFnProc(HWND,UINT,WPARAM,LPARAM);
int LoadWeightFnComboBox(HWND,HINSTANCE);
int CalcWeightFn(double*,double*,int,int);

BOOL CALLBACK WeightSpaProc(HWND,UINT,WPARAM,LPARAM);
int LoadWeightSpaComboBox(HWND,HINSTANCE);
int CalcWeightSpa(double*,double*,int,int);

BOOL CALLBACK DiffWorldProc(HWND,UINT,WPARAM,LPARAM);
int LoadDiffWorldComboBox(HWND,HINSTANCE);
int CalcDiffWorld(double*,double*,int);

#endif