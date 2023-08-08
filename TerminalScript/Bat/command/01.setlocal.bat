@echo off
@REM 具有不正确参数的 VERIFY 命令将 ERRORLEVEL 值初始化成非零值
@REM 指示 cmd.exe 是否要验证文件是否已正确地写入磁盘，此处输入错误参数
VERIFY OTHER 2>null
echo %ERRORLEVEL%
@REM 启用扩展
SETLOCAL ENABLEEXTENSIONS
echo %ERRORLEVEL%
@REM 验证是否启用扩展
IF ERRORLEVEL 0 echo enable extensions
IF ERRORLEVEL 1 echo Unable to enable extensions