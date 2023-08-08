@echo off
@REM oralce或者mysql服务启动与关闭
@REM 博客地址 blog.weiyigeek.top

@REM 终端大小的显示
mode con:cols=85 lines=30
title oralce或者mysql服务启动与关闭

color 0a
@REM 交互式选择操作
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
echo 命令执行成功
echo.
pause