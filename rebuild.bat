@echo off
If "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
	Set architecture=x64
) Else (
	Set architecture=x86
)
if not exist output md output
REM ����ͷ�ļ� visit header files
cd "%~dp0include"
REM ������Դ rebuild resource
echo Rebuild resource ...
..\tools\rc.exe\%architecture%\rc.exe /fo ..\output\FastCopy.res ..\resource\FastCopy.rc
REM �滻��Դ replace resource
cd ..
echo Replace resource ...
tools\ResourceHacker_4.5.30.exe -addoverwrite %1, output\FastCopy.exe, output\FastCopy.res,,,
echo.
echo ���ļ������ɵ���output\FastCopy.exe��
echo New file creat at "output\FastCopy.exe"
echo.
pause