@echo off
@REM 主要针对于Win7和Windows2008添加服务器主机安全规则以及高危端口封禁
@REM 博客地址 blog.weiyigeek.top
color 0a
echo.
echo "关闭智能卡服务,并设置禁止自启"
net stop SCardSvr
net stop SCPolicySvc

sc config SCardSvr start= disabled
sc config SCPolicySvc start= disabled
echo.
echo "Successful！！！"

rem 开启服务
net start MpsSvc
rem 开机启动
sc config MpsSvc start= auto

echo "启用防火墙"
netsh advfirewall set allprofiles state on

echo "屏蔽端口"

netsh advfirewall firewall add rule name="deny udp 137 " dir=in protocol=udp localport=137 action=block

netsh advfirewall firewall add rule name="deny tcp 137" dir=in protocol=tcp localport=137 action=block

netsh advfirewall firewall add rule name="deny udp 138" dir=in protocol=udp localport=138 action=block

netsh advfirewall firewall add rule name="deny tcp 138" dir=in protocol=tcp localport=138 action=block

netsh advfirewall firewall add rule name="deny udp 139" dir=in protocol=udp localport=139 action=block

netsh advfirewall firewall add rule name="deny tcp 139" dir=in protocol=tcp localport=139 action=block

netsh advfirewall firewall add rule name="deny udp 445" dir=in protocol=udp localport=445 action=block

netsh advfirewall firewall add rule name="deny tcp 445" dir=in protocol=tcp localport=445 action=block
echo.
echo 添加防火墙成功,将自动重启,取消请再cmd中输入shutdown -a
echo.
timeout /T 30
shutdown /r /t 30
pause