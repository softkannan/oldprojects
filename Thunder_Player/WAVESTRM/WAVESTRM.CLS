VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "WaveStream"
Attribute VB_Creatable = True
Attribute VB_Exposed = True
Option Explicit
'--------------------------------------------------------------
' Public Variable Declarations
'--------------------------------------------------------------
Public Recording As Boolean             ' Public Recording Status Indicator...
Public RecDeviceFree As Boolean         ' Public Recording Device Status Indicator...
Public Playing As Boolean               ' Public Recording Status Indicator...
Public PlayDeviceFree As Boolean        ' Public Recording Device Status Indicator...

Public waveChunkSize As Long            ' size of wave data buffer
Public waveCodec As Long                ' acm codec compression format
Public TIMESLICE As Single              ' recording interval...

'--------------------------------------------------------------
Private Const MINSTREAM = 1
Private Const MAXSTREAM = 32
Private CurRecPos(MINSTREAM To MAXSTREAM) As Long  ' Current Recording Buffer Position
Private CurPlayPos(MINSTREAM To MAXSTREAM) As Long ' Current Playing Buffer Position

Private Type WaveData                   ' [Wave Stream Segment]
    Data() As Byte                      ' Wave data byte array
End Type

Private Type WaveArray                  ' [Wave Stream]
    Waves(MAXBUFFERS) As WaveData       ' Array of WaveBuffers
End Type

Private Type uArrayWaves                ' [Array of Wave Streams]
    Stream(MINSTREAM To MAXSTREAM) As WaveArray ' Wave Buffer Array...
    QueuePos(MAXSTREAM - MINSTREAM + 1) As Long ' Wave Buffer Queue Position
End Type

Private PlayWaveBuffer As uArrayWaves    ' Array Of WaveBuffer Data Type
'--------------------------------------------------------------

'--------------------------------------------------------------
Public Sub InitACMCodec(fmtType As Long, Time_Slice As Single)
'--------------------------------------------------------------
    Dim waveFmt As WAVEFORMATEX                             ' Wave format type
'--------------------------------------------------------------
    waveCodec = fmtType                                     ' Save compression format to public variable
    TIMESLICE = Time_Slice                                  ' Save recording interval to public variable
    Call InitWaveFormat(waveFmt, waveCodec, TIMESLICE)      ' Get wave format info
    waveChunkSize = waveFmt.nAvgBytesPerSec * TIMESLICE     ' Save wave buffer size to public variable
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Public Function StreamInQueue() As Long
' Return current stream index in queue for playback
'--------------------------------------------------------------
    StreamInQueue = PlayWaveBuffer.QueuePos(MINSTREAM)
'--------------------------------------------------------------
End Function
'--------------------------------------------------------------

'--------------------------------------------------------------
Public Sub RemoveStreamFromQueue(StreamIdx As Integer)
' Removes A Stream From The Wave PlayBack Queue When PlayBack Is Done
'--------------------------------------------------------------
    Dim Idx As Integer                                      ' Queue Array Element Variable
'--------------------------------------------------------------
    For Idx = MINSTREAM To MAXSTREAM                        ' For Each Stream In The Queue
        If (PlayWaveBuffer.QueuePos(Idx) = StreamIdx) Then  ' If Stream Found In Queue...
            PlayWaveBuffer.QueuePos(Idx) = 0                ' Remove Stream From Queue
        ElseIf (Idx > MINSTREAM) Then                       ' If Not The First Item In The Queue...
            If (PlayWaveBuffer.QueuePos(Idx - 1) = 0) Then  ' If Previous Item Was Removed...
                If (PlayWaveBuffer.QueuePos(Idx) = 0) Then Exit For
                PlayWaveBuffer.QueuePos(Idx - 1) = PlayWaveBuffer.QueuePos(Idx) ' Move Stream Up To New Position
                PlayWaveBuffer.QueuePos(Idx) = 0            ' Remove Stream From Old Position
            End If
        End If
    Next                                                    ' Next Stream In Queue
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Public Sub WaitForCallBack(CallBackBit As Long, cbFlag As Long)
' Waits For Asynchronous Function Callback Bit To Be Set.
'--------------------------------------------------------------
    Do Until (((CallBackBit And cbFlag) = cbFlag) Or _
               (CallBackBit = WHDR_PREPARED) Or _
               (CallBackBit = 0))       ' Check For (CallBack Bit Or Null)...
        DoEvents                        ' Post Events...
    Loop
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Public Sub WaitForACMCallBack(CallBackBit As Long, cbFlag As Long)
' Waits For Asynchronous Function Callback Bit To Be Set.
'--------------------------------------------------------------
    Do Until (((CallBackBit And cbFlag) = cbFlag) Or _
               (CallBackBit = 0))       ' Check For (CallBack Bit Or Null)...
        DoEvents                        ' Post Events...
    Loop
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub InitWaveHDR(WaveHeader As WAVEHDR, waveFmt As WAVEFORMATEX, BuffSize As Long)
' Initialize's An Input Wave Header's DataBuffer And Size Members...
'--------------------------------------------------------------
    Dim rc As Long                                      ' Function Return Code...
'--------------------------------------------------------------
    WaveHeader.hData = GlobalAlloc(GMEM_MOVEABLE Or GMEM_SHARE Or GMEM_ZEROINIT, BuffSize) ' Allocate Global Memory
    WaveHeader.lpData = GlobalLock(WaveHeader.hData)    ' Lock Memory handle

    WaveHeader.dwBufferLength = BuffSize                ' Get Wave Buffer Size
    WaveHeader.dwFlags = 0                              ' Must Be Set To 0 For (waveOutPrepareHeader & waveInPrepareHeader)
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Function FreeWaveHDR(WaveHeader As WAVEHDR) As Boolean
'--------------------------------------------------------------
    Dim rc As Long                                      ' Function return code
'--------------------------------------------------------------
    rc = GlobalUnlock(WaveHeader.lpData)                ' Unlock Global Memory
    rc = GlobalFree(WaveHeader.hData)                   ' Free Global Memory
    
    FreeWaveHDR = True                                  ' Set Default Return Code
'--------------------------------------------------------------
End Function
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub InitAcmHDR(hAS As Long, acmHdr As ACMSTREAMHEADER, wavHdr As WAVEHDR)
' Initialize's An Input Wave Header's DataBuffer And Size Members...
'--------------------------------------------------------------
    Dim rc As Long                                      ' Function Return Code...
    Dim OutBytes As Long
'--------------------------------------------------------------
    acmHdr.cbStruct = Len(acmHdr)                       ' Size of header in bytes
    acmHdr.dwStatus = 0                                 ' Must be initialized to 0
    acmHdr.dwUser = 0                                   ' clear user def info
    acmHdr.cbSrcLengthUsed = 0                          ' Must be initialized to 0
    acmHdr.cbDstLengthUsed = 0                          ' Must be initialized to 0
    
    acmHdr.pbSrc = wavHdr.lpData                        ' Copy address of unprocessed data
    acmHdr.cbSrcLength = wavHdr.dwBufferLength          ' Copy size of unprocessed data
    
    rc = acmStreamSize(hAS, acmHdr.cbSrcLength, acmHdr.cbDstLength, ACM_STREAMSIZEF_SOURCE)
    Call AudioErrorHandler(rc, "acmStreamSize")
    
    ' Allocate memory for de/compression
    acmHdr.dwDstUser = GlobalAlloc(GMEM_MOVEABLE Or GMEM_SHARE Or GMEM_ZEROINIT, acmHdr.cbDstLength)                                     ' Allocate Global Memory
    acmHdr.cbDst = GlobalLock(acmHdr.dwDstUser)         ' Lock Memory handle
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'--------------------------------------------------------------
Private Sub FreeAcmHdr(acmHdr As ACMSTREAMHEADER)
' Initialize's An Input Wave Header's DataBuffer And Size Members...
'--------------------------------------------------------------
    Dim rc As Long                                      ' Function Return Code...
'--------------------------------------------------------------
    rc = GlobalUnlock(acmHdr.cbDst)                     ' Unlock Global Memory
    rc = GlobalFree(acmHdr.dwDstUser)                   ' Free Global Memory
'--------------------------------------------------------------
End Sub
'--------------------------------------------------------------

'------------------------------------------------------------------
Public Function RecordWave(hWND As Long, ByVal TCPSocket As Variant) As Boolean
' Records Audio Sounds To A String Buffer And Sends Buffer To TCP/IP Socket...
'------------------------------------------------------------------
    Dim rc As Long                                      ' Function Return Code
    Dim hAS As Long                                     ' ACM stream device
    Dim cWavefmt As WAVEFORMATEX                        ' Wave compression format
    Dim acmHdr As ACMSTREAMHEADER                       ' ACM stream header
    Dim acmHdr_x As ACMSTREAMHEADER                     ' <<Double Buffering>> ACM stream header
    Dim hWaveIn As Long                                 ' Handle To An Input Wave Device
    Dim waveFmt As WAVEFORMATEX                         ' Wave compression format
    Dim WaveInHDR As WAVEHDR                            ' Handle To An Input Wave Device Header
    Dim WaveInHDR_x As WAVEHDR                          ' <<Double Buffering>> Handle To An xtra Input Wave Device Header
'------------------------------------------------------------------
    RecDeviceFree = False                               ' Allocate Recording Device
    
    Do While Not PlayDeviceFree                         ' Wait For Play Device To Free
        DoEvents                                        ' Yield Events...
    Loop                                                ' Check Play Device Status
    
    Call InitWaveFormat(waveFmt, WAVE_FORMAT_PCM, TIMESLICE)   ' Set current wave format
    
    ' Open Input Wave Device, Let WAVE_MAPPER Pick The Best Device...
    rc = waveInOpen(hWaveIn, WAVE_MAPPER, waveFmt, 0&, 0&, CALLBACK_NULL)
    If Not AudioErrorHandler(rc, "WaveInOpen") Then Exit Function ' Validate Function Return Code
    
    '<<Double Buffering>> Initialize Wave Header Format Information
    Call InitWaveHDR(WaveInHDR_x, waveFmt, (waveFmt.nAvgBytesPerSec * TIMESLICE))
        
    ' Initialize Wave Header Format Information
    Call InitWaveHDR(WaveInHDR, waveFmt, (waveFmt.nAvgBytesPerSec * TIMESLICE))
    
    ' <<Double Buffering>> Prepare Input Wave Device Header
    rc = waveInPrepareHeader(hWaveIn, WaveInHDR_x, Len(WaveInHDR_x)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInPrepareHeader_x") Then GoTo ErrorRecordWave

    ' Prepare Input Wave Device Header
    rc = waveInPrepareHeader(hWaveIn, WaveInHDR, Len(WaveInHDR)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInPrepareHeader") Then GoTo ErrorRecordWave
    
    ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
    Call WaitForCallBack(WaveInHDR_x.dwFlags, WHDR_PREPARED)
    
    ' Wait For Wave Header CallBack
    Call WaitForCallBack(WaveInHDR.dwFlags, WHDR_PREPARED)
    
    ' <<Double Buffering>> Add Input Wave (xtra)Buffer To Wave Input Device
    rc = waveInAddBuffer(hWaveIn, WaveInHDR_x, Len(WaveInHDR_x)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInAddBuffer_x") Then GoTo ErrorRecordWave

    ' Add Input Wave Buffer To Wave Input Device
    rc = waveInAddBuffer(hWaveIn, WaveInHDR, Len(WaveInHDR)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInAddBuffer") Then GoTo ErrorRecordWave
        
    ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
    Call WaitForCallBack(WaveInHDR_x.dwFlags, WHDR_PREPARED)
    
    ' Wait For Wave Header CallBack
    Call WaitForCallBack(WaveInHDR.dwFlags, WHDR_PREPARED)
    
    Call InitWaveFormat(cWavefmt, waveCodec, TIMESLICE)   ' Set current wave format
    
    ' Open/Configure an acm Stream Handle For Compression
    rc = acmStreamOpen(hAS, 0&, waveFmt, cWavefmt, 0&, 0&, 0&, ACM_STREAMOPENF_NONREALTIME)
    Call AudioErrorHandler(rc, "acmStreamOpen")
    
    ' Initialize Audio Compression Manager Streaming Headers
    Call InitAcmHDR(hAS, acmHdr, WaveInHDR)
    Call InitAcmHDR(hAS, acmHdr_x, WaveInHDR_x)
    
    ' Prepare acm Stream Header
    rc = acmStreamPrepareHeader(hAS, acmHdr, 0&)
    Call AudioErrorHandler(rc, "acmStreamPrepareHeader")
    
    ' Prepare acm Stream Header
    rc = acmStreamPrepareHeader(hAS, acmHdr_x, 0&)
    Call AudioErrorHandler(rc, "acmStreamPrepareHeader_x")
        
    ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
    Call WaitForACMCallBack(acmHdr_x.dwStatus, ACMSTREAMHEADER_STATUSF_PREPARED)
    
    ' Wait For Wave Header CallBack
    Call WaitForACMCallBack(acmHdr.dwStatus, ACMSTREAMHEADER_STATUSF_PREPARED)
    
    ' Start Input Wave Device Recording...
    rc = waveInStart(hWaveIn)                           ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInStart") Then GoTo ErrorRecordWave
    
    Do
        ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
        Call WaitForCallBack(WaveInHDR_x.dwFlags, WHDR_DONE)
    
        ' <<Double Buffering>> Compress acm Stream Wave Buffer
        rc = acmStreamConvert(hAS, acmHdr_x, ACM_STREAMCONVERTF_BLOCKALIGN)
        If Not AudioErrorHandler(rc, "acmStreamConvert_x") Then GoTo ErrorRecordWave

        rc = SendSoundAll(TCPSocket, acmHdr_x)           ' <<Double Buffering>> Send Sound Buffer To TCPSocket
        If Not Recording Then Exit Do                       ' Evaluate Recording Stop Flag
        
        ' <<Double Buffering>> Add Input Wave (xtra)Buffer To Wave Input Device
        rc = waveInAddBuffer(hWaveIn, WaveInHDR_x, Len(WaveInHDR_x)) ' Validate Return Code
        If Not AudioErrorHandler(rc, "waveInAddBuffer_x") Then GoTo ErrorRecordWave
        
        Call WaitForCallBack(WaveInHDR.dwFlags, WHDR_DONE)  ' Wait For Wave Header CallBack
        
        ' Convert/Compress acm Stream Wave Buffer
        rc = acmStreamConvert(hAS, acmHdr, ACM_STREAMCONVERTF_BLOCKALIGN)
        If Not AudioErrorHandler(rc, "acmStreamConvert") Then GoTo ErrorRecordWave
        
        rc = SendSoundAll(TCPSocket, acmHdr)           ' Send Sound Buffer To TCPSocket
        If Not Recording Then Exit Do                       ' Evaluate Recording Stop Flag
    
        ' Add Input Wave Buffer To Wave Input Device
        rc = waveInAddBuffer(hWaveIn, WaveInHDR, Len(WaveInHDR)) ' Validate Return Code
        If Not AudioErrorHandler(rc, "waveInAddBuffer") Then GoTo ErrorRecordWave
    Loop While Recording                                   ' Continue Recording...
    
    ' <<Double Buffering>> UnPrepare acm Stream Header
    rc = acmStreamUnprepareHeader(hAS, acmHdr_x, 0&)
    Call AudioErrorHandler(rc, "acmStreamUnprepareHeader_x")
    
    ' UnPrepare acm Stream Header
    rc = acmStreamUnprepareHeader(hAS, acmHdr, 0&)
    Call AudioErrorHandler(rc, "acmStreamUnprepareHeader")
    
    ' Free globally allocated and locked memory variables...
    Call FreeAcmHdr(acmHdr_x)                           ' Free extra wave header memory
    Call FreeAcmHdr(acmHdr)                             ' Free wave header memory
    
    ' Close acm Stream Handle
    rc = acmStreamClose(hAS, 0&)
    Call AudioErrorHandler(rc, "acmStreamClose")
    
    ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
    Call WaitForCallBack(WaveInHDR_x.dwFlags, WHDR_DONE)
    
    ' Wait For Wave Header CallBack
    Call WaitForCallBack(WaveInHDR.dwFlags, WHDR_DONE)
    
    ' Stop Input Wave Device
    rc = waveInStop(hWaveIn)                            ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInStop") Then GoTo ErrorRecordWave
   
   ' UnPrepare Input Wave Device Header
    rc = waveInUnprepareHeader(hWaveIn, WaveInHDR, Len(WaveInHDR)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInUnPrepareHeader") Then GoTo ErrorRecordWave
   
   ' <<Double Buffering>> UnPrepare Input Wave Device (xtra)Header
    rc = waveInUnprepareHeader(hWaveIn, WaveInHDR_x, Len(WaveInHDR_x)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInUnPrepareHeader_x") Then GoTo ErrorRecordWave
    
    ' Close Input Wave Device
    rc = waveInClose(hWaveIn)                           ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveInClose") Then Exit Function
    
    ' Clean Up Memory Data...
    rc = FreeWaveHDR(WaveInHDR)                         ' Free Wave Header Data
    rc = FreeWaveHDR(WaveInHDR_x)                       ' Free Extra Wave Header Data
    
    RecordWave = True                                   ' Return Success
    RecDeviceFree = True                                ' Free Recording Device
    Exit Function                                       ' Exit
'------------------------------------------------------------------
ErrorRecordWave:                                        ' Clean Up Environment(Brute force no error handling)...
'------------------------------------------------------------------
    rc = acmStreamUnprepareHeader(hAS, acmHdr, 0&)      ' Attempt To UnPrepare acm Stream Header
    rc = acmStreamUnprepareHeader(hAS, acmHdr_x, 0&)    ' Attempt To UnPrepare acm Stream (xtra)Header
    Call FreeAcmHdr(acmHdr)                             ' Free wave header memory
    Call FreeAcmHdr(acmHdr_x)                           ' Free extra wave header memory
    rc = acmStreamClose(hAS, 0&)                        ' Attempt To Close acm Stream Handle
    
    rc = waveInStop(hWaveIn)                            ' Attempt To Stop WaveInput Device
    rc = waveInReset(hWaveIn)                           ' Attempt To Reset WaveInput Device
    rc = waveInUnprepareHeader(hWaveIn, WaveInHDR, Len(WaveInHDR)) ' Attempt To Unprepare WaveInput Header
    rc = waveInUnprepareHeader(hWaveIn, WaveInHDR_x, Len(WaveInHDR_x)) ' Attempt To Unprepare WaveInput (xtra)Header
    rc = waveInClose(hWaveIn)                           ' Attempt To Close Wave Input Device
    rc = FreeWaveHDR(WaveInHDR)                         ' Free Wave Header Data
    rc = FreeWaveHDR(WaveInHDR_x)                       ' Free Extra Wave Header Data
    
    RecDeviceFree = True                                ' Free Recording Device
    Exit Function                                       ' Exit
'------------------------------------------------------------------
End Function
'------------------------------------------------------------------

'------------------------------------------------------------------
Public Function PlayWave(hWND As Long, StreamIdx As Integer) As Boolean
' Play's Back Audio Wave Data From String Buffers...
'------------------------------------------------------------------
    Dim rc As Long                                      ' Function Return Code
    Dim hAS As Long                                     ' ACM stream device
    Dim acmHdr As ACMSTREAMHEADER                       ' ACM stream header
    Dim acmHdr_x As ACMSTREAMHEADER                     ' <<Double Buffering>> ACM stream header
    Dim cWavefmt As WAVEFORMATEX                        ' Wave compression format
    Dim waveFmt As WAVEFORMATEX                         ' Wave format type
    Dim hWaveOut As Long                                ' Handle To A Wave Output Device
    Dim WaveOutHdr As WAVEHDR                           ' Handle To A Wave Output Device Header
    Dim WaveOutHdr_x As WAVEHDR                         ' Handle To A Wave Output Device Header
'------------------------------------------------------------------
    Call InitWaveFormat(waveFmt, waveCodec, TIMESLICE)   ' Set current wave format
    
    ' Open Output Wave Device
    rc = waveOutOpen(hWaveOut, WAVE_MAPPER, waveFmt, 0&, 0&, CALLBACK_NULL)
    If Not AudioErrorHandler(rc, "waveOutOpen") Then Exit Function ' Validate Return Code
    
    PlayDeviceFree = False                              ' Allocate Recording Device
    
    ' Init Extra Wave Header Format Information
    Call InitWaveHDR(WaveOutHdr_x, waveFmt, (waveFmt.nAvgBytesPerSec * TIMESLICE))
        
    ' Init Wave Header Format Information
    Call InitWaveHDR(WaveOutHdr, waveFmt, (waveFmt.nAvgBytesPerSec * TIMESLICE))
        
    ' Prepare Output Wave Device Header
    rc = waveOutPrepareHeader(hWaveOut, WaveOutHdr_x, Len(WaveOutHdr_x)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveOutPrepareHeader") Then GoTo ErrorPlayWave
    
    ' Prepare Output Wave Device Header
    rc = waveOutPrepareHeader(hWaveOut, WaveOutHdr, Len(WaveOutHdr)) ' Validate Return Code
    If Not AudioErrorHandler(rc, "waveOutPrepareHeader") Then GoTo ErrorPlayWave
    
    ' <<<Double Buffer>>> Copy (extra)Wave Data To Buffer
    If Not (LoadPlayBuffer(hWaveOut, WaveOutHdr_x, waveFmt, _
                           PlayWaveBuffer.Stream(StreamIdx).Waves(CurPlayPos(StreamIdx)).Data, _
                           CurPlayPos(StreamIdx))) Then GoTo ErrorPlayWave ' Cleanup And Leave
    
    ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
    Call WaitForCallBack(WaveOutHdr_x.dwFlags, WHDR_PREPARED)
    
    ' Wait For Wave Header CallBack
    Call WaitForCallBack(WaveOutHdr.dwFlags, WHDR_PREPARED)
    
    'Call InitWaveFormat(cWavefmt, waveCodec, TIMESLICE)   ' Set current wave format
    Call InitWaveFormat(cWavefmt, WAVE_FORMAT_PCM, TIMESLICE)   ' Set current wave format
    
    ' Open/Configure an acm Stream Handle For Compression
    rc = acmStreamOpen(hAS, 0&, waveFmt, cWavefmt, 0&, 0&, 0&, ACM_STREAMOPENF_NONREALTIME)
    Call AudioErrorHandler(rc, "acmStreamOpen")
    
    ' Initialize Audio Compression wave streaming headers...
    Call InitAcmHDR(hAS, acmHdr, WaveOutHdr)
    Call InitAcmHDR(hAS, acmHdr_x, WaveOutHdr_x)
    
    ' Prepare acm Stream Header
    rc = acmStreamPrepareHeader(hAS, acmHdr, 0&)
    Call AudioErrorHandler(rc, "acmStreamPrepareHeader")
    
    ' Prepare acm Stream Header
    rc = acmStreamPrepareHeader(hAS, acmHdr_x, 0&)
    Call AudioErrorHandler(rc, "acmStreamPrepareHeader_x")
        
    ' <<Double Buffering>> Wait For Wave (xtra)Header CallBack
    Call WaitForACMCallBack(acmHdr_x.dwStatus, ACMSTREAMHEADER_STATUSF_PREPARED)
    
    ' Wait For Wave Header CallBack
    Call WaitForACMCallBack(acmHdr.dwStatus, ACMSTREAMHEADER_STATUSF_PREPARED)
    
    ' <<<Double Buffer>>> Write (extra)Wave Buffer To Output Device...
    rc = waveOutWrite(hWaveOut, WaveOutHdr_x, Len(WaveOutHdr_x))
    If Not AudioErrorHandler(rc, "waveOutWrite_x") Then GoTo ErrorPlayWave ' Validate Return Code

    Do
        ' Copy Wave Data To Buffer
        If Not (LoadPlayBuffer(hWaveOut, WaveOutHdr, waveFmt, _
                               PlayWaveBuffer.Stream(StreamIdx).Waves(CurPlayPos(StreamIdx)).Data, _
                               CurPlayPos(StreamIdx))) Then GoTo CleanUpPlayWave ' Cleanup And Leave

        ' <<Double Buffering>> Compress acm Stream Wave Buffer
        rc = acmStreamConvert(hAS, acmHdr, ACM_STREAMCONVERTF_BLOCKALIGN)
        If Not AudioErrorHandler(rc, "acmStreamConvert") Then GoTo ErrorPlayWave
        
        ' Write Wave Buffer To Output Device...
        rc = waveOutWrite(hWaveOut, WaveOutHdr, Len(WaveOutHdr))
        If Not AudioErrorHandler(rc, "waveOutWrite") Then GoTo ErrorPlayWave ' Validate Return Code
            
        ' <<<Double Buffer>>> Wait For Wave Header CallBack
        Call WaitForCallBack(WaveOutHdr_x.dwFlags, WHDR_DONE)
        
        ' <<<Double Buffer>>> Copy (extra)Wave Data To Buffer
        If Not (LoadPlayBuffer(hWaveOut, WaveOutHdr_x, waveFmt, _
                               PlayWaveBuffer.Stream(StreamIdx).Waves(CurPlayPos(StreamIdx)).Data, _
                               CurPlayPos(StreamIdx))) Then GoTo CleanUpPlayWave ' Cleanup And Leave

        ' <<Double Buffering>> Compress acm Stream Wave Buffer
        rc = acmStreamConvert(hAS, acmHdr_x, ACM_STREAMCONVERTF_BLOCKALIGN)
        If Not AudioErrorHandler(rc, "acmStreamConvert_x") Then GoTo ErrorPlayWave
        
        ' <<<Double Buffer>>> Write (extra)Wave Buffer To Output Device...
        rc = waveOutWrite(hWaveOut, WaveOutHdr_x, Len(WaveOutHdr_x))
        If Not AudioErrorHandler(rc, "waveOutWrite_x") Then GoTo ErrorPlayWave ' Validate Return Code
        
        ' Wait For Wave Header CallBack
        Call WaitForCallBack(WaveOutHdr.dwFlags, WHDR_DONE)
    Loop While Playing                                    ' Continue Playing...
    
'------------------------------------------------------------------
CleanUpPlayWave:                                          ' Cleanup...
'------------------------------------------------------------------
    ' <<Double Buffering>> UnPrepare acm Stream Header
    rc = acmStreamUnprepareHeader(hAS, acmHdr_x, 0&)
    Call AudioErrorHandler(rc, "acmStreamUnprepareHeader_x")
    
    ' UnPrepare acm Stream Header
    rc = acmStreamUnprepareHeader(hAS, acmHdr, 0&)
    Call AudioErrorHandler(rc, "acmStreamUnprepareHeader")
    
    Call FreeAcmHdr(acmHdr)                             ' Free wave header memory
    Call FreeAcmHdr(acmHdr_x)                           ' Free extra wave header memory
    
    ' Close acm Stream Handle
    rc = acmStreamClose(hAS, 0&)
    Call AudioErrorHandler(rc, "acmStreamClose")
    
    ' Wait For Wave Header CallBack
    Call WaitForCallBack(WaveOutHdr.dwFlags, WHDR_DONE)
    
    ' Unprepare Wave Output Buffer
    rc = waveOutUnprepareHeader(hWaveOut, WaveOutHdr, Len(WaveOutHdr))
    
    ' <<Double Buffer>> Wait For Wave Header CallBack
    Call WaitForCallBack(WaveOutHdr_x.dwFlags, WHDR_DONE)
    
    ' <<Double Buffer>> Unprepare Wave Output Buffer
    rc = waveOutUnprepareHeader(hWaveOut, WaveOutHdr_x, Len(WaveOutHdr_x))

    ' Close Output Wave Device
    rc = waveOutClose(hWaveOut)
    If Not AudioErrorHandler(rc, "waveOutClose") Then Exit Function ' Validate Return Code
    
    ' Clean Up Memory Data...
    rc = FreeWaveHDR(WaveOutHdr)                        ' Free Wave Header Data
    rc = FreeWaveHDR(WaveOutHdr_x)                      ' Free Extra Wave Header Data
    
    PlayWave = True                                     ' Return Success
    PlayDeviceFree = True                               ' Free Recording Device
    Exit Function                                       ' Exit
'------------------------------------------------------------------
ErrorPlayWave:                                          ' Handle Errors And Cleanup...
'------------------------------------------------------------------
    rc = acmStreamUnprepareHeader(hAS, acmHdr, 0&)      ' Attempt To UnPrepare acm Stream Header
    rc = acmStreamUnprepareHeader(hAS, acmHdr_x, 0&)    ' Attempt To UnPrepare acm Stream (xtra)Header
    Call FreeAcmHdr(acmHdr)                             ' Free wave header memory
    Call FreeAcmHdr(acmHdr_x)                           ' Free extra wave header memory
    rc = acmStreamClose(hAS, 0&)                        ' Attempt To Close acm Stream Handle
    
    rc = waveOutUnprepareHeader(hWaveOut, WaveOutHdr, Len(WaveOutHdr)) ' Attempt To Unprepare Header
    rc = waveOutUnprepareHeader(hWaveOut, WaveOutHdr_x, Len(WaveOutHdr_x)) ' Attempt To Unprepare Header
    rc = waveOutClose(hWaveOut)                         ' Close Wave Output Device
    rc = FreeWaveHDR(WaveOutHdr)                        ' Free Wave Header Data
    rc = FreeWaveHDR(WaveOutHdr_x)                      ' Free Extra Wave Header Data
    
    PlayDeviceFree = True                               ' Free Recording Device Flag
    Exit Function                                       ' Exit
'------------------------------------------------------------------
End Function
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Sub IncBufferPointer(NextVal As Long)
' Moves Buffer Pointer Up One Notch In A Continuous Loop...
'------------------------------------------------------------------
    If NextVal < MAXBUFFERS Then        ' If Not At End Of Buffer
        NextVal = NextVal + 1           ' Increment Buffer Pointer
    Else                                ' At End Of Buffer
        NextVal = MINBUFFERS            ' Go To Beginning Of Buffer
    End If
'------------------------------------------------------------------
End Sub
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Sub InitWaveFormat(waveFmt As WAVEFORMATEX, fmtType As Long, Time_Slice As Single)
' Initializes Wave Format Data Type
'------------------------------------------------------------------
    Dim i As Long
'------------------------------------------------------------------
    Select Case fmtType
    Case WAVE_FORMAT_ADPCM
        waveFmt.wFormatTag = WAVE_FORMAT_ADPCM          ' wave format type
        waveFmt.nChannels = 1                           ' number of channels - mono
        waveFmt.wBitsPerSample = 4                      ' bits/sample of TRUESPEECH - not used.
        waveFmt.nSamplesPerSec = c8_0kHz                ' sample rate kHz
        waveFmt.nAvgBytesPerSec = 4055                  ' Bytes/Sec
        waveFmt.nBlockAlign = 256                       ' block size of data
        waveFmt.cbSize = 2                              ' extra bytes used for WaveFormatEx
        waveFmt.xBytes(0) = &HF9                        ' Fact Chunk - Byte 0
        waveFmt.xBytes(1) = &H1                         ' Fact Chunk - Byte 1
    Case WAVE_FORMAT_MSN_AUDIO          ' Initialize Wave Format - WAVE_FORMAT_MSN_AUDIO
        waveFmt.wFormatTag = WAVE_FORMAT_MSN_AUDIO      ' wave format type
        waveFmt.nChannels = 1                           ' number of channels - mono
        waveFmt.wBitsPerSample = 0                      ' bits/sample of TRUESPEECH - not used.
        waveFmt.cbSize = 4                              ' extra bytes used for WaveFormatEx
        waveFmt.xBytes(0) = &H40                        ' Fact Chunk - Byte 0
        waveFmt.xBytes(1) = &H1                         ' Fact Chunk - Byte 1
'<<< 8.0 kHz - 8200 Bauds >>>  (Fair, No FeedBack)
        waveFmt.nSamplesPerSec = c8_0kHz                ' sample rate kHz
        waveFmt.nAvgBytesPerSec = 1025                  ' Bytes/Sec
        waveFmt.nBlockAlign = 41                        ' block size of data
        waveFmt.xBytes(2) = &H8                         ' Fact Chunk - Byte 2
        waveFmt.xBytes(3) = &H20                        ' Fact Chunk - Byte 3
'<<< 8.0 kHz - 10000 Bauds >>> (Excellent, No FeedBack)
'        WaveFmt.nSamplesPerSec = c8_0kHz                ' sample rate kHz
'        WaveFmt.nAvgBytesPerSec = 1250                  ' Bytes/Sec
'        WaveFmt.nBlockAlign = 50                        ' block size of data
'        WaveFmt.xBytes(2) = &H10                        ' Fact Chunk - Byte 2
'        WaveFmt.xBytes(3) = &H27                        ' Fact Chunk - Byte 3
'<<< 11.025 kHz - 11301 Bauds >>> (Bad, FeedBack)
'<<< 11.025 kHz - 12128 Bauds >>> (Bad, FeedBack)
'<<< 11.025 kHz - 13782 Bauds >>> (Bad, FeedBack)
    Case WAVE_FORMAT_GSM610             ' Initialize Wave Format - WAVE_FORMAT_GSM610
        waveFmt.wFormatTag = WAVE_FORMAT_GSM610         ' wave format type
        waveFmt.nChannels = 1                           ' number of channels - mono
        waveFmt.nSamplesPerSec = c8_0kHz                ' sample rate kHz
        waveFmt.nAvgBytesPerSec = 1625                  ' Bytes/Sec
        waveFmt.nBlockAlign = 65                        ' block size of data
        waveFmt.wBitsPerSample = 0                      ' bits/sample of TRUESPEECH - not used.
        waveFmt.cbSize = 2                              ' extra bytes used for WaveFormatEx
        waveFmt.xBytes(0) = &H40                        ' Fact Chunk - Byte 0
        waveFmt.xBytes(1) = &H1                         ' Fact Chunk - Byte 1
    Case WAVE_FORMAT_PCM                ' Initialize Wave Format - WAVE_FORMAT_PCM
        waveFmt.wFormatTag = WAVE_FORMAT_PCM                ' format type
        waveFmt.nChannels = WAVE_FORMAT_1M08                ' number of channels (i.e. mono, stereo, etc.)
        waveFmt.nSamplesPerSec = c8_0kHz                    ' sample rate 8.0 kHz
        waveFmt.nAvgBytesPerSec = waveFmt.nSamplesPerSec    ' for buffer estimation
        waveFmt.wBitsPerSample = 8                          ' [8, 16, or 0]
        waveFmt.nBlockAlign = waveFmt.nChannels * waveFmt.wBitsPerSample / 8 '  block size of data
        waveFmt.cbSize = 0                                  ' Not Used If [wFormatTag= WAVE_FORMAT_PCM]
    End Select
'------------------------------------------------------------------
End Sub
'------------------------------------------------------------------

'--------------------------------------------------------------
Public Function AddStreamToQueue(StreamIdx As Integer)
' Puts An Incoming Wave Segment Into The Wave PlayBack Queue
'--------------------------------------------------------------
    Dim Idx As Integer                                  ' Queue Array Processing Variable
'--------------------------------------------------------------
    For Idx = MINSTREAM To MAXSTREAM                    ' For Each Stream In The Queue
        If (PlayWaveBuffer.QueuePos(Idx) = StreamIdx) Then ' If Stream Already In Playback Queue
            AddStreamToQueue = True                     ' Return Success
            Exit Function                               ' Exit
        ElseIf (PlayWaveBuffer.QueuePos(Idx) = 0) Then  ' If Queue Space Available...
            PlayWaveBuffer.QueuePos(Idx) = StreamIdx    ' Put Stream Into The Playback Queue
            AddStreamToQueue = True                     ' Return Success
            Exit Function                               ' Exit
        End If
    Next                                                ' Next Stream In The Queue
'--------------------------------------------------------------
End Function
'--------------------------------------------------------------

'------------------------------------------------------------------
Public Sub SaveStreamBuffer(StreamIdx As Integer, recBuffer() As Byte)
' Saves A Record Buffer To A Record Buffer Array
'------------------------------------------------------------------
    ' If Buffer Is Free
    If (LenB(MidB(PlayWaveBuffer.Stream(StreamIdx).Waves(CurRecPos(StreamIdx)).Data, 1)) < 3) Then
        PlayWaveBuffer.Stream(StreamIdx).Waves(CurRecPos(StreamIdx)).Data = recBuffer ' Copy Buffer From Rec
        Call IncBufferPointer(CurRecPos(StreamIdx)) ' Increment Buffer Pointer To Next Free Position...
    End If                                          ' Else Ignore Buffer Data
'------------------------------------------------------------------
End Sub
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Function LoadPlayBuffer(hWaveOut As Long, WaveOutHdr As WAVEHDR, waveFmt As WAVEFORMATEX, Data() As Byte, playBuffPos As Long) As Boolean
' Loads Audio Sound From A String Buffer Into A Wave Header Structure For PlayBack
'------------------------------------------------------------------
    Dim rc As Long                                  ' Return Code Variable
'------------------------------------------------------------------
    If (LenB(MidB(Data, 1)) > 2) Then
        WaveOutHdr.dwBufferLength = UBound(Data) - LBound(Data) + 1 ' Get Wave Buffer Size
        Call CopyBYTEStoPTR(WaveOutHdr.lpData, Data(0), _
                            WaveOutHdr.dwBufferLength)  ' Copy Buffer From String To Pointer
        Data = ""                                       ' Clear Buffer Space
        Call IncBufferPointer(playBuffPos)              ' Increment Play Buffer ptr To Next Position...
        
        LoadPlayBuffer = True                           ' Return Success
    End If
'------------------------------------------------------------------
End Function
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Function SendSoundAll(Sockets As Variant, WaveHeader As ACMSTREAMHEADER) As Long
' Sends Sound Buffers To Each Valid Connection In A Connection Array
'------------------------------------------------------------------
    Dim Idx As Integer                              ' Socket cntl index
    Dim rc As Long                                  ' Function Return Code
    Dim Socket As Variant                           ' TCP socket control
'------------------------------------------------------------------
    For Each Socket In Sockets                      ' Check each socket
        If (Socket.State = sckConnected) Then       ' If Connection Is Active
            rc = SendSound(Socket, WaveHeader)      ' Send Sound To Socket Connection
        End If
    Next                                            ' Try Next LocalPort
'------------------------------------------------------------------
End Function
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Function SendSound(Socket As Variant, acmHdr As ACMSTREAMHEADER) As Long
' Checks A Socket SendFlag Status, And Sends A WaveBuffer When Socket Is Ready
'------------------------------------------------------------------
    Dim WaveBuffer() As Byte                        ' Wave Buffer byte array
'------------------------------------------------------------------
    ReDim WaveBuffer(acmHdr.cbDstLengthUsed - 1) As Byte ' Allocate byte array
    Call CopyPTRtoBYTES(WaveBuffer(0), acmHdr.cbDst, _
                        acmHdr.cbDstLengthUsed)     ' Copy Data
    Call Socket.SendData(WaveBuffer)                ' Send wave data into the socket
'------------------------------------------------------------------
End Function
'------------------------------------------------------------------

'------------------------------------------------------------------
Public Function AudioErrorHandler(rc As Long, fcnName As String) As Boolean
'------------------------------------------------------------------
    Dim msg As String               ' Error Message Body
'------------------------------------------------------------------
    AudioErrorHandler = False       ' Return Failure
    
'   Select Case rc Or Err.LastDllError
    Select Case rc
    Case MMSYSERR_NOERROR           ' no error
        AudioErrorHandler = True    ' Return Success
        Exit Function               ' Exit Function
    Case MMSYSERR_ERROR             ' unspecified error
        msg = "Unspecified Error."
    Case MMSYSERR_BADDEVICEID       ' device ID out of range
        msg = "device ID out of range"
    Case MMSYSERR_NOTENABLED        ' driver failed enable
        msg = "driver failed enable"
    Case MMSYSERR_ALLOCATED         ' device already allocated
        msg = "device already allocated"
    Case MMSYSERR_INVALHANDLE       ' device handle is invalid
        msg = "device handle is invalid"
    Case MMSYSERR_NODRIVER          ' no device driver present
        msg = "no device driver present"
    Case MMSYSERR_NOMEM             ' memory allocation error
        msg = "memory allocation error"
    Case MMSYSERR_NOTSUPPORTED      ' function isn't supported
        msg = "function isn't supported"
    Case MMSYSERR_BADERRNUM         ' error value out of range
        msg = "error value out of range"
    Case MMSYSERR_INVALFLAG         ' invalid flag passed
        msg = "invalid flag passed"
    Case MMSYSERR_INVALPARAM        ' invalid parameter passed
        msg = "invalid parameter passed"
    Case MMSYSERR_LASTERROR         ' last error in range
        msg = "last error in range"
    Case WAVERR_BADFORMAT           ' unsupported wave format
        msg = "unsupported wave format"
    Case WAVERR_STILLPLAYING        ' still something playing
        msg = "still something playing"
    Case WAVERR_UNPREPARED          ' header not prepared
        msg = "header not prepared"
    Case WAVERR_LASTERROR           ' last error in range
        msg = "last error in range"
    Case WAVERR_SYNC                ' device is synchronous
        msg = "device is synchronous"
    Case ACMERR_NOTPOSSIBLE         ' The requested operation cannot be performed
        msg = "The requested operation cannot be performed"
    Case ACMERR_BUSY                ' The stream header specified is currently in use and cannot be unprepared
        msg = "The acm stream header busy"
    Case ACMERR_UNPREPARED
        msg = "The acm stream header is not prepared"
    Case ACMERR_CANCELED
        msg = "The acm operation has been canceled"
    Case ERROR_SHARING_VIOLATION    ' The process cannot access the file because it is being used by another process.
        msg = "The process cannot access the file because it is being used by another process."
    Case Else                       ' Unknown MM Error!
        msg = "Unknown MM Error!"
    End Select
    
    ' Format Text Body Of Message
    msg = "Error In " & fcnName & _
          " rc= " & Str$(rc) & _
          " MSG= " & msg & _
          " LastDllError= " & Hex(Err.LastDllError) & _
          " Source= " & Err.Source & vbCrLf
    
    Debug.Print msg                 ' Print Error Message
    MsgBox msg
    Exit Function                   ' Exit
'------------------------------------------------------------------
End Function
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Sub Class_Initialize()
'------------------------------------------------------------------
    Recording = False                                   ' Set Recording Status Off...
    Playing = False                                     ' Set Playing Status Off...
    RecDeviceFree = True                                ' Set Rec Device Free Status Indicator TRUE
    PlayDeviceFree = True                               ' Set Play Device Free Status Indicator TRUE
    Call InitACMCodec(WAVE_FORMAT_PCM, 0.2)             ' Initialise codec default values...
'------------------------------------------------------------------
End Sub
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Sub Class_Terminate()
'------------------------------------------------------------------
    Recording = False                                   ' Set Recording Status Off...
    Playing = False                                     ' Set Playing Status Off...
    RecDeviceFree = False                               ' Set Rec Device Free Status Indicator TRUE
    PlayDeviceFree = False                              ' Set Play Device Free Status Indicator TRUE
'------------------------------------------------------------------
End Sub
'------------------------------------------------------------------

'------------------------------------------------------------------
Private Sub debugACM(acmHdr As ACMSTREAMHEADER)
'------------------------------------------------------------------
    ' Used for debugging the audio compression streaming
    MsgBox "cbStruct:" & CStr(acmHdr.cbStruct) & vbCrLf & "dwStatus:" & CStr(acmHdr.dwStatus) & vbCrLf & _
           "dwUser:" & CStr(acmHdr.dwUser) & vbCrLf & _
           "pbSrc:" & CStr(acmHdr.pbSrc) & vbCrLf & _
           "cbSrcLength:" & CStr(acmHdr.cbSrcLength) & vbCrLf & _
           "cbSrcLengthUsed:" & CStr(acmHdr.cbSrcLengthUsed) & vbCrLf & _
           "dwSrcUser:" & CStr(acmHdr.dwSrcUser) & vbCrLf & _
           "cbDst:" & CStr(acmHdr.cbDst) & vbCrLf & _
           "cbDstLength:" & CStr(acmHdr.cbDstLength) & vbCrLf & _
           "cbDstLengthUsed:" & CStr(acmHdr.cbDstLengthUsed) & vbCrLf & _
           "dwDstUser:" & CStr(acmHdr.dwDstUser)
'------------------------------------------------------------------
End Sub
'------------------------------------------------------------------

