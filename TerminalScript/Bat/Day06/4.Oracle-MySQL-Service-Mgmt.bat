@echo off
@REM oralce����mysql����������ر�
@REM ���͵�ַ blog.weiyigeek.top

@REM �ն˴�С����ʾ
mode con:cols=85 lines=30
title oralce����mysql����������ر�

color 0a
@REM ����ʽѡ�����
choice /C abcdq /M "startOrace,stopOracle,startMysql,stopMysql,quit"  /T 60 /D q
if ERRORLEVEL 5 goto end
if ERRORLEVEL 4 goto stopMysql
if ERRORLEVEL 3 goto startMysql
if ERRORLEVEL 2 goto stopOracle
if ERRORLEVEL 1 goto startOracle

@REM oralce service start
:startOracle
net start OracleVssWriterORCL
net start OracleDBConsoleorcl
net start OracleOraDb10g_home1iSQL*Plus
net start OracleOraDb10g_home1TNSListener
net start OracleServiceORCL
goto end

@REM oralce stop service
:stopOracle
net stop OracleServiceORCL
net stop OracleOraDb10g_home1TNSListener
net stop OracleOraDb10g_home1iSQL*Plus
net stop OracleDBConsoleorcl
net stop OracleVssWriterORCL
goto end

@REM mysql start service
:startmMysql
net start MySQL
goto end

@REM mysql stop service
:stopMysql
net stop MySQL

:end
echo.
echo ����ִ�гɹ�
echo.
pause