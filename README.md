# FastCopy-M Resources Rebuild & Replace Tools<br>FastCopy-M 资源文件重编译/自动替换工具

目前版本仅适用于3.4.x及以前
This version is only work for v3.4.x or before.

当本工具自带资源文件版本过老时，使用“Update resources source file.vbs”可以自动从GitHub下载最新的“FastCopy.rc”和“resource.h”。第一次使用时也必须运行本工具。  
If the resource file with this tool is too old, use "Update resources source file.vbs" to auto download the newest "FastCopy.rc" and "resource.h". And you must run this at first time use.

你可以用Visual Studio作为IDE修改资源，资源文件在“resource”文件夹里面。  
You can use Visual Studio for IDE to edit resources, resource files in "resource" folder.

手动修改了resource内的资源文件源代码后，将原始“FastCopy.exe”文件拖动到“rebuild.bat”上即会开始编译新的资源文件替换上去，生成到“output\FastCopy.exe”。  
After edit the resources source file , then drag original "FastCopy.exe" and put on "rebuild.bat" . Then will auto begin rebuild new resources and replace the old. Generate to "output\FastCopy.exe".

有更多问题可以反馈
Have more questions to feedback
	https://github.com/Mapaler/FastCopy-M/

# Auto Change Icon Tools<br>自动更换图标工具

在“My New Icon”文件夹内放入你的动画图标组，命名为“1.ico”、“2.ico”、“3.ico”……其中最后一个图标文件将作为等待图标。  
Put your customize icon animate group, and rename to "1.ico","2.ico","3.ico"... Attention: The final icon file as wait icon.

然后将“FastCopy.exe”拖到“Change Icon.vbs”上即可。  
Then drag original "FastCopy.exe" and put on "Change Icon.vbs" . 

会自动编译和替换资源，并保存到“output\FastCopy.exe”。  
Then will auto begin rebuild and replace resources.  And generate to "output\FastCopy.exe".