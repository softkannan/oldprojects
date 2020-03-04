Attribute VB_Name = "Module1"
Public Declare Function OutPort Lib "port.dll" (ByVal PrtAdrs As Long, ByVal PrtData As Integer) As Integer
Public Declare Function InPort Lib "port.dll" (ByVal a As Integer) As Integer
