@echo off
Title 查询局域网中有那些主机在线
setlocal enabledelayedexpansion

@REM 获取本机IP地址
ECHO 正在获取本机的IP地址，请稍等...
for /f "delims=: tokens=2" %%i in ('ipconfig ^| find /i "IPv4"') do set ip=%%i
echo %ip%
for /f "delims=. tokens=1,2,3,4" %%i in ("%IP%") do set range=%%i.%%j.%%k

ECHO 正在探测网段【 %range%.* 】内的计算机，请稍等...
for /l %%a in (2,1,254) do ( set ipaddr=%range%.%%a && ping -n 1 !ipaddr!>nul & echo !ipaddr!)

ECHO.&ECHO 正在获取本网段内的其它在线计算机名，请稍等...
ECHO 本网段【%range%.*】内的计算机有：
 
for /f "delims=" %%i in ('net view') do (
  set "var=%%i"
  @REM 查询在线计算机名称
  if "!var:~0,2!"=="\\" (
    set "var=!var:~2!"
    ECHO !var!
    @REM 发送一个ping报文
    ping -n 1 !var!>nul
  )
)
 
ECHO.
ECHO 正在获取本网段内的其它在线计算机IP，请稍等...
for /f "skip=3 tokens=1,* delims= " %%i in ('arp -a') do ECHO IP： %%i 正在使用
 
ECHO.
ECHO 查询完毕，按任意键退出...
pause>nul