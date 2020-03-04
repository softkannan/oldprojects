#include "stdafx.h"
#include "ProcessExec.h"


ProcessExec::ProcessExec(string filePath, string fileName, string args, string inputFile):m_fileName(fileName),m_filePath(filePath),m_args(args),m_inputFile(inputFile)
{
   
}


ProcessExec::~ProcessExec()
{
    if (m_hOutputRead != NULL)
    {
        CloseHandle(m_hOutputRead);
    }
    if (m_hOutputWrite != NULL)
    {
        CloseHandle(m_hOutputWrite);
    }
    if (m_hInputWrite != NULL)
    {
        CloseHandle(m_hInputWrite);
    }
    if (m_hInputRead != NULL)
    {
        CloseHandle(m_hInputRead);
    }
}

/////////////////////////////////////////////////////////////////////// 
// PrepAndLaunchRedirectedChild
// Sets up STARTUPINFO structure, and launches redirected child.
/////////////////////////////////////////////////////////////////////// 
INT ProcessExec::PrepAndLaunchRedirectedChild()
{
	string exeFile = m_filePath + m_fileName + " " + m_args;
	PROCESS_INFORMATION pi;
	STARTUPINFO si;

	// Set up the start up info struct.
	ZeroMemory(&si, sizeof(STARTUPINFO));
	si.cb = sizeof(STARTUPINFO);
	si.dwFlags = STARTF_PREVENTPINNING | STARTF_TITLEISAPPID | STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
	//si.dwFlags |= STARTF_USESTDHANDLES;
	si.wShowWindow = SW_HIDE;
	si.hStdOutput = m_hOutputWrite;
	si.hStdInput = m_hInputRead;
	si.hStdError = m_hOutputWrite;
	// Use this if you want to hide the child:
	si.wShowWindow = SW_HIDE;
	// Note that dwFlags must include STARTF_USESHOWWINDOW if you want to use the wShowWindow flags.


	// Launch the process that you want to redirect (in this case,
	// Child.exe). Make sure Child.exe is in the same directory as
	// redirect.c launch redirect from a command line to prevent location confusion.
	if (!CreateProcess(NULL, (LPSTR)exeFile.c_str(), NULL, NULL, TRUE, CREATE_NEW_CONSOLE, NULL, NULL, &si, &pi))
	{
		DisplayError("CreateProcess");
		return -1;
	}


	if (m_inputFile.length() > 0)
	{

		m_hInputFile = CreateFile(
			(LPSTR)m_inputFile.c_str(),
			GENERIC_READ,
			0,
			NULL,
			OPEN_EXISTING,
			FILE_ATTRIBUTE_READONLY,
			NULL);

		if (m_hInputFile == INVALID_HANDLE_VALUE)
			DisplayError("CreateFile");

		// Write to the pipe that is the standard input for a child process. 
		// Data is written to the pipe's buffers, so it is not necessary to wait
		// until the child process is running before writing data.

		WriteToPipe();
	}

	// Set global child process handle to cause threads to exit.
	m_hChildProcess = pi.hProcess;

	if (ProcWaitDelay > 0)
	{
		Sleep(ProcWaitDelay);
	}

	// Read the child's output.
	ReadAndHandleOutput();
	// Redirection is complete

    if (WaitForProcToComplete)
    {
        if (WaitForSingleObject(m_hChildProcess, INFINITE) == WAIT_FAILED)
        {
            DisplayError("WaitForSingleObject");
            return -1;
        }
    }

    return 0;
}

/////////////////////////////////////////////////////////////////////// 
// ReadAndHandleOutput
// Monitors handle for input. Exits when child exits or pipe breaks.
/////////////////////////////////////////////////////////////////////// 
INT ProcessExec::ReadAndHandleOutput()
{
    CHAR lpBuffer[4096];
    DWORD nBytesRead;
	DWORD nAvailableByte;

	if (ApplyProcHangWorkAround)
	{
		while (TRUE)
		{
			if (WaitForSingleObject(m_hChildProcess, 1000) == WAIT_FAILED)
			{
				DisplayError("WaitForSingleObject");
				return -1;
			}

			PeekNamedPipe(m_hOutputRead, NULL, NULL, NULL, &nAvailableByte, NULL);
			if (nAvailableByte > 0)
			{
				if (!ReadFile(m_hOutputRead, lpBuffer, sizeof(lpBuffer), &nBytesRead, NULL) || !nBytesRead)
				{
					break; // pipe done - normal exit path.
				}


				for (int index = 0; index < nBytesRead; index++)
				{
					m_output.push_back(lpBuffer[index]);
				}
			}
			else
			{
				break;
			}
		}
	}
	else
	{
		while (TRUE)
		{
			if (!ReadFile(m_hOutputRead, lpBuffer, sizeof(lpBuffer), &nBytesRead, NULL) || !nBytesRead)
			{
				break; // pipe done - normal exit path.
			}

			for (int index = 0; index < nBytesRead; index++)
			{
				m_output.push_back(lpBuffer[index]);
			}
		}
	}

    return 0;
}

/////////////////////////////////////////////////////////////////////// 
// DisplayError
// Displays the error number and corresponding message.
/////////////////////////////////////////////////////////////////////// 
void ProcessExec::DisplayError(char *pszAPI)
{
    LPVOID lpvMessageBuffer;
    CHAR szPrintBuffer[512];

    FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM, NULL, GetLastError(), MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPTSTR)&lpvMessageBuffer, 0, NULL);

    wsprintf(szPrintBuffer,"ERROR: API    = %s.\n   error code = %d.\n   message    = %s.\n", pszAPI, GetLastError(), (char *)lpvMessageBuffer);

    ERRORM(szPrintBuffer);

    LocalFree(lpvMessageBuffer);
}


INT ProcessExec::Exec()
{
	SECURITY_ATTRIBUTES sa;

	// Set up the security attributes struct.
	sa.nLength = sizeof(SECURITY_ATTRIBUTES);
	sa.lpSecurityDescriptor = NULL;
	sa.bInheritHandle = TRUE;


	// Create the child output pipe.
	if (!CreatePipe(&m_hOutputRead, &m_hOutputWrite, &sa, 0))
	{
		DisplayError("CreatePipe");
		return -1;
	}
	// Ensure the read handle to the pipe for STDOUT is not inherited.
	if (!SetHandleInformation(m_hOutputRead, HANDLE_FLAG_INHERIT, 0))
	{
		DisplayError("Stdout SetHandleInformation");
		return -1;
	}


	// Create the child input pipe.
	if (!CreatePipe(&m_hInputRead, &m_hInputWrite, &sa, 0))
	{
		DisplayError("CreatePipe");
		return -1;
	}
	// Ensure the write handle to the pipe for STDIN is not inherited. 
	if (!SetHandleInformation(m_hInputWrite, HANDLE_FLAG_INHERIT, 0))
	{
		DisplayError("Stdin SetHandleInformation");
		return -1;
	}


	PrepAndLaunchRedirectedChild();

	


	// Close pipe handles (do not continue to modify the parent).
	// You need to make sure that no handles to the write end of the
	// output pipe are maintained in this process or else the pipe will
	// not close when the child process exits and the ReadFile will hang.
	if (!CloseHandle(m_hOutputWrite))
	{
		m_hOutputWrite = NULL;
		DisplayError("CloseHandle");
		return -1;
	}
	m_hOutputWrite = NULL;

	if (!CloseHandle(m_hInputRead))
	{
		m_hInputRead = NULL;
		DisplayError("CloseHandle");
		return -1;
	}
	m_hInputRead = NULL;

	if (!CloseHandle(m_hOutputRead))
	{
		m_hOutputRead = NULL;
		DisplayError("CloseHandle");
		return -1;
	}
	m_hOutputRead = NULL;

	if (!CloseHandle(m_hInputWrite))
	{
		m_hInputWrite = NULL;
		DisplayError("CloseHandle");
		return -1;
	}
	m_hInputWrite = NULL;

	return 0;
}


void ProcessExec::WriteToPipe(void)
// Read from a file and write its contents to the pipe for the child's STDIN.
// Stop when there is no more data. 
{
	DWORD dwRead, dwWritten;
	CHAR chBuf[1024];
	BOOL bSuccess = FALSE;

	for (;;)
	{
		bSuccess = ReadFile(m_hInputFile, chBuf, 1024, &dwRead, NULL);
		if (!bSuccess || dwRead == 0) break;

		bSuccess = WriteFile(m_hInputWrite, chBuf, dwRead, &dwWritten, NULL);
		if (!bSuccess) break;
	}

	// Close the pipe handle so the child process stops reading. 

	if (!CloseHandle(m_hInputWrite))
		DisplayError("StdInWr CloseHandle");
}