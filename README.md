# FastCopy-M Resources Rebuild & Replace Tools
FastCopy-M 资源文件重编译/自动替换工具

你可以用Visual Studio作为IDE修改资源，资源文件在“resource”文件夹里面。
You can use Visual Studio for IDE to edit resources, resource files in "resource" folder.

手动修改了resource内的资源文件源代码后，将原始“FastCopy.exe”文件拖动到“rebuild.bat”上即会开始编译新的资源文件替换上去，生成到“output\FastCopy.exe”。
After edit the resources source file , then drag original "FastCopy.exe" and put on "rebuild.bat" . Then will auto begin rebuild new resources and replace the old. Generate to "output\FastCopy.exe".

当本工具自带资源文件版本过老时，使用“Update resources source file.vbs”可以自动从GitHub下载最新的“FastCopy.rc”和“resource.h”。
If the resource file with this tool is too old, use "Update resources source file.vbs" to auto download the newest "FastCopy.rc" and "resource.h".

有更多问题可以反馈
Have more questions to feedback
	https://github.com/Mapaler/FastCopy-M/issues