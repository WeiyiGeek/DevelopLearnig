
@echo off 
color 0a
title Windows7 OS Garbage Cleaning
echo ★☆ Win7 清理系统垃圾文件 ★☆★
echo 正在清除系统垃圾文件，请稍后

::Win7下面::是不支持得

@REM 清理 C:\Windows\temp 文件夹中的垃圾文件
del /f /s /q %windir%\*.bak 
del /f /s /q %windir%\prefetch\*.* 
dir %windir%\NtUninstall* /a:d /b >%windir%\DELLIST.txt 
for /f %%i in (%windir%\DELLIST.txt) do rd %windir%\%%i /s /q 
del %windir%\DELLIST.txt /f /q 
rmdir /s /q %windir%\temp & md %windir%\temp


@REM 清理磁盘的根目录的垃圾文件
del /f /s /q %systemdrive%\*.tmp 
del /f /s /q %systemdrive%\*._mp 
del /f /s /q %systemdrive%\*.log 
del /f /s /q %systemdrive%\*.gid 
del /f /s /q %systemdrive%\*.chk 
del /f /s /q %systemdrive%\*.old 
del /f /s /q %systemdrive%\recycled\*.* 

@REM 清理用户家目录的垃圾文件
@REM 等同于del /f /s /q "%temp%\*.*"
del /f /q %userprofile%\cookies\*.* 
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%userprofile%\local settings\temporary internet files\*.*"
del /f /s /q "%userprofile%\local settings\temp\*.*"

echo 
echo ★☆ 恭喜您！清理全部完成！ ☆★
echo