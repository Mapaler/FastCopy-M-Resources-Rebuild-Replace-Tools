Set fso = CreateObject("Scripting.FileSystemObject")
ParentPath = fso.GetParentFolderName(WScript.ScriptFullName)
SubFolder = ParentPath & "\resource_Download_Temp"
DstFolder = ParentPath & "\resource"
If Not fso.FolderExists(SubFolder) Then fso.CreateFolder(SubFolder)

file1 = "FastCopy.rc"
WScript.Echo "Start download """ & file1 & """"
Source = LoadWebPageSource("https://raw.githubusercontent.com/Mapaler/FastCopy-M/master/src/" & file1)
If fso.FileExists(SubFolder & "\" & file1) Then fso.DeleteFile SubFolder & "\" & file1
WriteFileBin Source,SubFolder & "\" & file1

If fso.FileExists(SubFolder & "\" & file1) Then fso.CopyFile SubFolder & "\" & file1, DstFolder & "\" & file1, True

file2 = "resource.h"
WScript.Echo "Start download """ & file2 & """"
Source = LoadWebPageSource("https://raw.githubusercontent.com/Mapaler/FastCopy-M/master/src/" & file2)
If fso.FileExists(SubFolder & "\" & file2) Then fso.DeleteFile SubFolder & "\" & file2
WriteFileBin Source,SubFolder & "\" & file2

If fso.FileExists(SubFolder & "\" & file2) Then fso.CopyFile SubFolder & "\" & file2, DstFolder & "\" & file2, True

WScript.Echo "Download over."


'д��������ļ�����
Function WriteFileBin(bin,filePath)
	Set stm = CreateObject("Adodb.Stream")
	stm.Type = 1
	stm.Open
	stm.Write bin
	stm.SaveToFile filePath, 2
	stm.Close
	Set stm = Nothing
End Function
'��ȡ��ҳԴ����
Function LoadWebPageSource(url)
	Set xhp=CreateObject("Msxml2.XMLHTTP")
	xhp.open "get",url,false
	xhp.send
	LoadWebPageSource = xhp.responseBody
	Set xhp = Nothing 
End Function