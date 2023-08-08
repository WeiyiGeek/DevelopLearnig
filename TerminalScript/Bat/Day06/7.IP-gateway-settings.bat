@echo off
@REM 修改主机系统网络IP地址及DNS服务器
@REM 博客地址 blog.weiyigeek.top
set /p address=请输入IP地址(192.168.1.2):
set /p netmask=请输入子网掩码(255.255.255.0):
set /p gateway=请输入网关地址(192.168.1.1):
set /p dnsserver=请输入DNS服务器(223.6.6.6):

@rem 以太网IP 与 网关设置
netsh interface ip set address name="以太网" source=static addr=%address% mask=%netmask% gateway=%gateway% gwmetric=1

@rem 网络DNS域名解析服务器地址设置
netsh interface ip set dnsservers name="以太网" source=static address=%dnsserver% register=primary

@rem 刷新DNS解析
ipconfig /flushdns
ipconfig