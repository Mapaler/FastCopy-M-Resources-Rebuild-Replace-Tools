@echo off
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	Set architecture=x64
) Else (
	Set architecture=x86
)
if not exist output md output
REM 访问头文件 visit header files
cd "%~dp0include"
REM 编译资源 rebuild resource
echo Rebuild resource ...
..\tools\rc.exe\%architecture%\rc.exe /fo ..\output\FastCopy.res ..\resource\FastCopy.rc
REM 替换资源 replace resource
cd ..
echo Replace resource ...
tools\ResourceHacker_4.5.30.exe -addoverwrite %1, output\FastCopy.exe, output\FastCopy.res,,,
echo.
echo 新文件已生成到“output\FastCopy.exe”
echo New file creat at "output\FastCopy.exe"
echo.
pause