Attribute VB_Name = "ACM_Defs"
Option Explicit
'== ACM API Constants ================================================
Public Const ACMERR_BASE = 512
Public Const ACMERR_NOTPOSSIBLE = (ACMERR_BASE + 0)
Public Const ACMERR_BUSY = (ACMERR_BASE + 1)
Public Const ACMERR_UNPREPARED = (ACMERR_BASE + 2)
Public Const ACMERR_CANCELED = (ACMERR_BASE + 3)

' AcmStreamSize Flags...
Public Const ACM_STREAMSIZEF_SOURCE = &H0&
Public Const ACM_STREAMSIZEF_DESTINATION = &H1&
Public Const ACM_STREAMSIZEF_QUERYMASK = &HF&

' acmStreamConvert Flags...
Public Const ACM_STREAMCONVERTF_BLOCKALIGN = &H4&
Public Const ACM_STREAMCONVERTF_START = &H10&
Public Const ACM_STREAMCONVERTF_END = &H20&

' Done Bits For ACMSTREAMHEADER.fdwStatus
Public Const ACMSTREAMHEADER_STATUSF_DONE = &H10000
Public Const ACMSTREAMHEADER_STATUSF_PREPARED = &H20000
Public Const ACMSTREAMHEADER_STATUSF_INQUEUE = &H100000

' Done Bits For acmStreamOpen Formats
Public Const ACM_STREAMOPENF_QUERY = &H1&
Public Const ACM_STREAMOPENF_ASYNC = &H2&
Public Const ACM_STREAMOPENF_NONREALTIME = &H4&

'== ACM API Declarations ================================================
Public Declare Function acmStreamOpen Lib "MSACM32" (hAS As Long, ByVal hADrv As Long, wfxSrc As WAVEFORMATEX, wfxDst As WAVEFORMATEX, ByVal wFltr As Long, ByVal dwCallback As Long, ByVal dwInstance As Long, ByVal fdwOpen As Long) As Long
Public Declare Function acmStreamClose Lib "MSACM32" (ByVal hAS As Long, ByVal dwClose As Long) As Long
Public Declare Function acmStreamPrepareHeader Lib "MSACM32" (ByVal hAS As Long, hASHdr As ACMSTREAMHEADER, ByVal dwPrepare As Long) As Long
Public Declare Function acmStreamUnprepareHeader Lib "MSACM32" (ByVal hAS As Long, hASHdr As ACMSTREAMHEADER, ByVal dwUnPrepare As Long) As Long
Public Declare Function acmStreamConvert Lib "MSACM32" (ByVal hAS As Long, hASHdr As ACMSTREAMHEADER, ByVal dwConvert As Long) As Long
Public Declare Function acmStreamReset Lib "MSACM32" (ByVal hAS As Long, ByVal dwReset As Long) As Long
Public Declare Function acmStreamSize Lib "MSACM32" (ByVal hAS As Long, ByVal cbInput As Long, dwOutBytes As Long, ByVal dwSize As Long) As Long

'== ACM User Defined Datatypes ================================================
Type WAVEFILTER
    cbStruct      As Long
    dwFilterTag   As Long
    fdwFilter     As Long
    dwReserved(5) As Long
End Type

Type ACMSTREAMHEADER            ' [ACM STREAM HEADER TYPE]
    cbStruct As Long            ' Size of header in bytes
    dwStatus As Long            ' Conversion status buffer
    dwUser As Long              ' 32 bits of user data specified by application
    pbSrc As Long               ' Source data buffer pointer
    cbSrcLength As Long         ' Source data buffer size in bytes
    cbSrcLengthUsed As Long     ' Source data buffer size used in bytes
    dwSrcUser As Long           ' 32 bits of user data specified by application
    cbDst As Long               ' Dest data buffer pointer
    cbDstLength As Long         ' Dest data buffer size in bytes
    cbDstLengthUsed As Long     ' Dest data buffer size used in bytes
    dwDstUser As Long           ' 32 bits of user data specified by application
    dwReservedDriver(9) As Long ' Reserved and should not be used
End Type
