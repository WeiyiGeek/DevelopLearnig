@echo off
@REM ���в���ȷ������ VERIFY ��� ERRORLEVEL ֵ��ʼ���ɷ���ֵ
@REM ָʾ cmd.exe �Ƿ�Ҫ��֤�ļ��Ƿ�����ȷ��д����̣��˴�����������
VERIFY OTHER 2>null
echo %ERRORLEVEL%
@REM ������չ
SETLOCAL ENABLEEXTENSIONS
echo %ERRORLEVEL%
@REM ��֤�Ƿ�������չ
IF ERRORLEVEL 0 echo enable extensions
IF ERRORLEVEL 1 echo Unable to enable extensions