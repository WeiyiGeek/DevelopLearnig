@echo off
XCOPY C:\AUTOEXECa.BAT D:\
echo %ERRORLEVEL%
IF ERRORLEVEL 4 ECHO 拷贝过程中写盘错误aa
goto end
IF ERRORLEVEL 3 ECHO 预置错误阻止文件拷贝操作
goto end
IF ERRORLEVEL 2 ECHO 用户通过ctrl-c中止拷贝操作
goto end
IF ERRORLEVEL 1 ECHO 未找到拷贝文件
goto end
IF ERRORLEVEL 0 ECHO 成功拷贝文件
:end
pause