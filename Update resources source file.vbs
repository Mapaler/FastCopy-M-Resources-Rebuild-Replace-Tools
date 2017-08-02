Dim fso,osh
Set fso = CreateObject("Scripting.FileSystemObject")
Set osh = CreateObject("WScript.Shell")

If LCase(Right(WScript.FullName,11)) = "wscript.exe" Then
    osh.run "cmd /c cscript.exe //nologo """ & WScript.ScriptFullName & """"
    WScript.quit
End If

ParentPath = fso.GetParentFolderName(WScript.ScriptFullName)
SubFolder = ParentPath & "\resource_Download_Temp"
DstFolder = ParentPath & "\resource"
If Not fso.FolderExists(SubFolder) Then fso.CreateFolder(SubFolder)

files = Array("FastCopy.rc","resource.h")
For i = LBound(files) To UBound(files)
	url = "https://raw.githubusercontent.com/Mapaler/FastCopy-M/master/src/" & files(i)
	WScript.Echo "Start download """ & files(i) & """" & vbCrLf & url1
	Source = LoadWebPageSource(url)
	If fso.FileExists(SubFolder & "\" & files(i)) Then fso.DeleteFile SubFolder & "\" & files(i)
	WriteFileBin Source,SubFolder & "\" & files(i)
	If fso.FileExists(SubFolder & "\" & files(i)) Then fso.CopyFile SubFolder & "\" & files(i), DstFolder & "\" & files(i), True
Next

WScript.Echo "Download over."

'写入二进制文件函数
Function WriteFileBin(bin,filePath)
	Set stm = CreateObject("Adodb.Stream")
	stm.Type = 1
	stm.Open
	stm.Write bin
	stm.SaveToFile filePath, 2
	stm.Close
	Set stm = Nothing
End Function
'读取网页源代码
Function LoadWebPageSource(url)
	Set xhp=CreateObject("Msxml2.XMLHTTP")
	xhp.open "get",url,false
	xhp.send
	LoadWebPageSource = xhp.responseBody
	Set xhp = Nothing 
End Function