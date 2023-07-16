@echo off
:: 利用返回错误代码选择执行命令演示
cls

:: 示例1
@whoamis
if %ERRORLEVEL%==0 (
echo Program had return code 0
) else (
echo Program had return code %ERRORLEVEL%,This Program Not True Execute!!
)

:: 示例2
whoami
if %ERRORLEVEL%==0 (echo Program had return code 0) else echo Program had return code %ERRORLEVEL%,This Program Not True Execute!!