If WScript.Arguments.Count<1 Then
	WScript.Echo "请把需要修改的FastCopy.exe拖到本脚本上运行" & vbCrLf & "Please drag FastCopy.exe and put on this file to run."
	WScript.Quit
End If
'====================================
'变量定义区
'====================================
Dim fso,osh
Set fso = CreateObject("Scripting.FileSystemObject")
Set osh = CreateObject("WScript.Shell")
osh.CurrentDirectory = parDir(WScript.ScriptFullName)
'====================================
'函数区
'====================================
'获取路径父文件夹
Function parDir(path)
	Dim fsot
	Set fsot = CreateObject("Scripting.FileSystemObject")
	If fsot.FolderExists(path) Then
		parDir = fsot.GetParentFolderName(fsot.GetFolder(path))
	ElseIf fsot.FileExists(path) Then
		parDir = fsot.GetParentFolderName(fsot.GetFile(path))
	End If
	Set fsot = Nothing
End Function
'写入文本函数
Function WriteFile(str,filePath,CharSet)
	Set stm = CreateObject("Adodb.Stream")
	stm.Type = 2
	stm.mode = 3
	stm.charset = CharSet
	stm.Open
	stm.WriteText str
	stm.SaveToFile filePath, 2
	stm.Flush
	stm.Close
	Set stm = Nothing
End Function
'读取文本函数
Function ReadFile(filePath,CharSet)
	Set stm = CreateObject("Adodb.Stream")
	stm.Type = 2
	stm.charset = CharSet
	stm.Open
	stm.Position = 0
	stm.LoadFromFile filePath
	ReadFile = stm.ReadText
	stm.Flush
	stm.Close
	Set stm = Nothing
End Function
'正则表达式替换
Function RegReplace(strng, patrn, newstr) 
	Dim regEx      ' 创建变量。
	Set regEx = New RegExp         ' 创建正则表达式。
	regEx.Pattern = patrn         ' 设置模式。
	regEx.IgnoreCase = True         ' 设置是否区分大小写，True为不区分。
	regEx.Global = True         ' 设置全程匹配。
	regEx.MultiLine = True
	RegReplace = regEx.Replace(strng, newstr)
	Set regEx = Nothing
End Function
'正则表达式搜索
Function RegSearch(strng, patrn) 
	Dim regEx      ' 创建变量。
	Set regEx = New RegExp         ' 创建正则表达式。
	regEx.Pattern = patrn         ' 设置模式。
	regEx.IgnoreCase = True         ' 设置是否区分大小写，True为不区分。
	regEx.Global = True         ' 设置全程匹配。
	regEx.MultiLine = True
	Set RegSearch  = regEx.Execute(strng)
'	If RegExpSearch.Count > 0 Then
'		MsgBox RegExpSearch.Item(0)
'		If RegExpSearch.Item(0).Submatches.Count > 0 Then
'			Set SubMatches = RegExpSearch.Item(0).Submatches
'			MsgBox SubMatches.Item(0)
'		End If
'	End If
	Set regEx = Nothing
End Function
'====================================
'主代码
'====================================
Dim Files
Set Files = WScript.Arguments '将参数（文件列表）存入类
If fso.FileExists(Files(0)) Then
'fastcopy.rc  (^\s*\w+\s+ICON\s+"[\w\\\.]+\s*"$\r\n)+
'resource.h  ^\s*#define\s+FASTCOPY_ICON\s+\d+\s*$\r\n(^\s*#define\s+FASTCOPY\d_ICON\s+\d+\s*$\r\n)*^\s*#define\sFCWAIT_ICON\s+\d+\s*$
	Dim i,IconPath,ID,nt_rc,nt_h
	Do
		i = i + 1
		IconPath = "My New Icon\" & i & ".ico"
		IconPath2 = "My New Icon\" & (i + 1) & ".ico"
		If fso.FileExists(IconPath) Then
			fso.CopyFile IconPath, "resource\icon\" & i & ".ico", True
			If i = 1 Then
				ID = "FASTCOPY_ICON"
			ElseIf Not fso.FileExists(IconPath2) Then
				ID = "FCWAIT_ICON"
			Else
				ID = "FASTCOPY" & i & "_ICON"
			End If
			nt_rc = nt_rc & ID & vbTab & "ICON" & vbTab & """icon\\" & i & ".ico""" & vbCrLf
			nt_h = nt_h & "#define " & ID & vbTab & (4000 + i) & vbCrLf
		End If
	Loop While fso.FileExists(IconPath)
	nt_rc = nt_rc & "HIST_ICON               ICON                    ""menu.ico""" & vbCrLf '补上新增的一个图标
	
	Dim path_rc,path_h,txt_rc,txt_h
	path_rc = "resource\FastCopy.rc"
	path_h = "resource\resource.h"
	
	txt_rc = ReadFile(path_rc,"UTF-16LE")
	txt_h = ReadFile(path_h,"UTF-16LE")
	
	txt_rc = RegReplace(txt_rc, _
		"(^\s*\w+\s+ICON\s+""[\w\\\.]+\s*""$\r\n)+", _
		vbLf & nt_rc)
	txt_rc = RegReplace(txt_rc, _
		"^\s*IDS_Animation_Icon_Num\s+""\d+""$\r\n", _
		vbLf & vbtab & "IDS_Animation_Icon_Num" & vbtab & """" & (i - 2) & """" & vbCrLf)
	txt_h = RegReplace(txt_h, _
		"^\s*#define\s+FASTCOPY_ICON\s+\d+\s*$\r\n(^\s*#define\s+FASTCOPY\d_ICON\s+\d+\s*$\r\n)*^\s*#define\sFCWAIT_ICON\s+\d+\s*$\r\n", _
		vbLf & nt_h)
	
	WriteFile txt_rc, path_rc, "UTF-16LE"
	WriteFile txt_h, path_h, "UTF-16LE"
	
	osh.Run "rebuild.bat """ & Files(0) & """"
Else
	WScript.Echo Files(0) & "不存在" & vbCrLf & Files(0) & " don't exists."
	WScript.Quit
End If