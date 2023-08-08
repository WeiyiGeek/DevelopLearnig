
```powershell
@echo off
mode con: cols=85 lines=30
:TOPSEC
title WannaCry勒索病毒加固工具
color 0A
cls
echo.
echo -----------------  WannaCry勒索病毒加固工具  ------------------
echo.
echo    * 由于增加防火墙策略，并开启了防火墙，会导致没有加入防火墙例外的端口无法访问,需手工把需要开放的端口加入到例外中。
echo.
echo    * 声明：由于打印服务器大多使用445端口，加固后可能会出现打印服务工作异常,如果其他重要服务使用445端口，请在安全工程师指导下加固。
echo.
echo    * 建议: 边界防火墙阻断445端口的访问，可通过IPS、防火墙相关安全设备配置相关阻断策略。
echo.
echo    * 建议: 在微软官网下载MS17-010补丁,选择对应的版本进行补丁安装，补丁下载
echo      地址：https://technet.microsoft.com/zh-cn/library/security/MS17-010。
echo.
echo    * 必须以系统管理员身份运行，以下提供此工具所做的操作的介绍：
echo.
echo       1：WIN7/XP加固 2：WIN10加固 3：WIN2003加固 4：WIN2008/2012加固 5.WIN2016加固
echo.
echo       6: 退出
echo ----------------------------------------------------------------------------------
echo.
set start=
set /p start=输入(1 2 3 4 5 6)后按回车键:
if "%start%"=="1" goto WIN7
if "%start%"=="2" goto WIN10
if "%start%"=="3" goto WIN2003
if "%start%"=="4" goto WIN2012
if "%start%"=="5" goto WIN2016
if "%start%"=="6" goto quit
goto TOPSEC

:WIN7
net stop server /Y > nul
netsh advfirewall set currentprofile state on > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows 7 OR XP系统已加固成功！
echo .
pause
goto TOPSEC

:WIN10
net stop server > nul
netsh firewall set opmode enable > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows 10系统已加固成功！
echo .
pause
goto TOPSEC

:WIN2003
net stop server > nul
net start sharedaccess > nul
netsh firewall add portopening protocol = ALL port = 445 name = TOPSEC-DenyEquation mode = DISABLE scope = ALL profile = ALL > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows Server 2003系统已加固成功！
echo .
pause
goto TOPSEC

:WIN2012
net stop server > nul
net start MpsSvc > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows Server 2012 OR 2008系统已加固成功！
echo .
pause
goto TOPSEC

:WIN2016
net stop server > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationTCP" dir=in action=block localport=445 remoteip=any protocol=tcp > nul
netsh advfirewall firewall add rule name="TOPSEC-DenyEquationUDP" dir=in action=block localport=445 remoteip=any protocol=udp > nul
echo ---------------------------------------------------------------------------------
echo    *  Windows Server 2016系统已加固成功！
echo .
pause
goto TOPSEC