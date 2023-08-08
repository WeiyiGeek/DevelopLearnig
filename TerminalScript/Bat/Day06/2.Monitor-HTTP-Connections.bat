@echo off
@REM 监视指定HTTP端口连接数的批处理脚本
@REM 博客地址 blog.weiyigeek.top

set nowdate="%date:~0,10% %time:~0,5%"
set /a MONIROTPORT=%1%
if "%MONIROTPORT%" == "" goto usage

@REM 获取IP地址
ipconfig | findstr "IPv4" > %temp%\ipv4.txt

:count
echo %nowdate%
for /f "usebackq tokens=2 delims=:" %i in ("%temp%\ip.txt") do (
  set IP=%i
  set /p test="Num of HTTP Connections:  " < nul & netstat -na | findstr "\<%MONIROTPORT%\>" | find /C "%IP%:%MONIROTPORT%" 
)

@REM 延迟3秒执行
timeout 3 > nul

@REM 代码块跳转
GOTO count

:usage
echo "usage: %0% HTTP-Port"