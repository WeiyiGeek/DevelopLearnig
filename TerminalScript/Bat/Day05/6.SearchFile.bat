@echo off
 
@REM 变量延时绑定
setlocal enabledelayedexpansion
 
@REM 请求输入文件名,支持通配符
set /p filename=请输入要查找的文化名:
 
@REM 查看所有卷信息,赋值给变量,^表示换行符
for /f "delims=^" %%i in ('fsutil fsinfo drives') do (
	set juaninfo=%%i
)

@REM echo显示所有卷信息
echo %juaninfo%
 
@REM 遍历所有卷查找文件
for %%i in (%juaninfo%) do (
	echo %%i | findstr [A-Z]>nul && (set n=%%i & set target=!n!%filename% & set "target=!target: =!" & dir !target! /s /q)
)