@echo off
@REM 快速打印系统相关配置信息
@REM 博客地址 blog.weiyigeek.top
@REM OS 名称:版本:制造商:配置:构件类型
echo System Information >> System_Details.txt
systeminfo | findstr /B /C:"OS" > System_Details.txt      

@REM 系统主机名
echo Hostname >> System_Details.txt
hostname >> System_Details.txt

@REM 系统用户
echo Users>> System_Details.txt
net users >> System_Details.txt

@REM 接口路由表
echo Route table >> System_Details.txt
route print >> System_Details.txt

@REM 计算机活动连接包括PID
echo Netstat INformation>> System_Details.txt
netstat -ano >> System_Details.txt

@REM 防火墙状态
echo Firewall State >> System_Details.txt
netsh firewall show state >> System_Details.txt

@REM 防火墙域配置文件配置
echo Firewall configuration >> System_Details.txt
netsh firewall show config >> System_Details.txt 

@REM 计划任务,此处需要改变cmd活页代码,不是中文显示会有问题 
chcp 437
echo Scheduled tasks >> ScheTask_Details.txt
echo ---------- >> ScheTask_Details.txt
schtasks /query /fo LIST /v >> schetask_Details.txt

chcp 936

@REM 映像名称  PID  服务       
echo tasklist >> System_Details.txt
tasklist /SVC >> System_Details.txt                            

@REM 启动的服务
echo net start >> System_Details.txt
net start >> System_Details.txt

@REM 设备查询：模块名   显示名称 驱动程序类型  链接日期
echo driverquery >> System_Details.txt
DRIVERQUERY >> System_Details.txt

@REM 补丁查询
echo Wmic hotfix >> System_Details.txt 
wmic qfe get Caption,Description,HotFixID,InstalledOn >> System_Details.txt

@REM elavated 查询 
echo reg queries - elavated注册查询 >> System_Details.txt 
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
echo reg queries - elavated >> System_Details.txt
sc qc Spooler >> System_Details.txt
echo upnhosts - elavated >> System_Details.txt
sc qc upnphost >> System_Details.txt

@REM 特定用户或组对资源（包括文件、目录、注册表项、全局对象和Windows服务）拥有哪些类型的访问权限
@REM 安装地址: https://learn.microsoft.com/en-us/sysinternals/downloads/accesschk
@REM accesschk.exe -ucqv Spooler >> System_Details.txt
@REM accesschk.exe -uwcqv "Authenticated Users" * >> System_Details.txt

echo End of Script >> System_Details.txt