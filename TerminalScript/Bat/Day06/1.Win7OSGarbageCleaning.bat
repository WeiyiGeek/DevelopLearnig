
@echo off 
color 0a
title Windows7 OS Garbage Cleaning
echo ��� Win7 ����ϵͳ�����ļ� ����
echo �������ϵͳ�����ļ������Ժ�

::Win7����::�ǲ�֧�ֵ�

@REM ���� C:\Windows\temp �ļ����е������ļ�
del /f /s /q %windir%\*.bak 
del /f /s /q %windir%\prefetch\*.* 
dir %windir%\NtUninstall* /a:d /b >%windir%\DELLIST.txt 
for /f %%i in (%windir%\DELLIST.txt) do rd %windir%\%%i /s /q 
del %windir%\DELLIST.txt /f /q 
rmdir /s /q %windir%\temp & md %windir%\temp


@REM ������̵ĸ�Ŀ¼�������ļ�
del /f /s /q %systemdrive%\*.tmp 
del /f /s /q %systemdrive%\*._mp 
del /f /s /q %systemdrive%\*.log 
del /f /s /q %systemdrive%\*.gid 
del /f /s /q %systemdrive%\*.chk 
del /f /s /q %systemdrive%\*.old 
del /f /s /q %systemdrive%\recycled\*.* 

@REM �����û���Ŀ¼�������ļ�
@REM ��ͬ��del /f /s /q "%temp%\*.*"
del /f /q %userprofile%\cookies\*.* 
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%userprofile%\local settings\temporary internet files\*.*"
del /f /s /q "%userprofile%\local settings\temp\*.*"

echo 
echo ��� ��ϲ��������ȫ����ɣ� ���
echo