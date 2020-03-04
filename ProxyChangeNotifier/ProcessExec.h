#pragma once

#include <windows.h>
#include <tchar.h>
#include <psapi.h>
#include <tlhelp32.h>
#include  <vector>
#include <string>
#include <algorithm>
#include <cctype>
#include <string>
#include <vector>

using namespace std;

class ProcessExec
{
private:
    string m_filePath;
    string m_fileName;
    string m_args;
	vector<CHAR> m_output;
	string m_inputFile;

    HANDLE m_hChildProcess = NULL;
    BOOL m_bRunThread = TRUE;

	HANDLE m_hInputRead = NULL;
    HANDLE m_hInputWrite = NULL;

    HANDLE m_hOutputRead = NULL;
    HANDLE m_hOutputWrite = NULL;

	HANDLE m_hInputFile = NULL;
    
    INT PrepAndLaunchRedirectedChild();
    INT ReadAndHandleOutput();
    void DisplayError(char *pszAPI);
	void WriteToPipe(void);
public:

	INT ProcWaitDelay = 0;
	bool ApplyProcHangWorkAround = true;
	bool WaitForProcToComplete = false;

    ProcessExec(string filePath,string fileName,string args,string inputFile = "");
    ~ProcessExec();
    INT Exec();
    string get_output()
    {
		string retVal(m_output.begin(), m_output.end());
        return retVal;
    }
};

