@echo off
:: # 启用命令扩展
setlocal enableExtensions

:: # 当前脚本执行环境是否支持扩展以及输出 CMDEXTVERSION 值
echo  "命令扩展是否启用:" %CMDEXTVERSION%

:: # 查看用户是否定义了CMDEXTVERSION环境变量
set | findstr "CMDEXTVERSION">nul
if ERRORLEVEL 1 (
:: 如果%CMDEXTVERSION%非空，则当前CMD.EXE开启了命令扩展，否则禁用
if ""=="%CMDEXTVERSION%"  ( echo 命令扩展被禁用) else ( echo 命令扩展被开启)


IF CMDEXTVERSION 0 (echo "True -> %CMDEXTVERSION%") ELSE (echo "False -> %CMDEXTVERSION%")
IF CMDEXTVERSION 1 (echo "True -> %CMDEXTVERSION%") ELSE (echo "False -> %CMDEXTVERSION%")
IF CMDEXTVERSION 2 (echo "True -> %CMDEXTVERSION%") ELSE (echo "False -> %CMDEXTVERSION%")

:: # 禁用命令扩展
setlocal disableExtensions
echo %CMDEXTVERSION%