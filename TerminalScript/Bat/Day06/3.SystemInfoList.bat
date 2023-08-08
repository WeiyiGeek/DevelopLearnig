@echo off
@REM ���ٴ�ӡϵͳ���������Ϣ
@REM ���͵�ַ blog.weiyigeek.top
@REM OS ����:�汾:������:����:��������
echo System Information >> System_Details.txt
systeminfo | findstr /B /C:"OS" > System_Details.txt      

@REM ϵͳ������
echo Hostname >> System_Details.txt
hostname >> System_Details.txt

@REM ϵͳ�û�
echo Users>> System_Details.txt
net users >> System_Details.txt

@REM �ӿ�·�ɱ�
echo Route table >> System_Details.txt
route print >> System_Details.txt

@REM ���������Ӱ���PID
echo Netstat INformation>> System_Details.txt
netstat -ano >> System_Details.txt

@REM ����ǽ״̬
echo Firewall State >> System_Details.txt
netsh firewall show state >> System_Details.txt

@REM ����ǽ�������ļ�����
echo Firewall configuration >> System_Details.txt
netsh firewall show config >> System_Details.txt 

@REM �ƻ�����,�˴���Ҫ�ı�cmd��ҳ����,����������ʾ�������� 
chcp 437
echo Scheduled tasks >> ScheTask_Details.txt
echo ---------- >> ScheTask_Details.txt
schtasks /query /fo LIST /v >> schetask_Details.txt

chcp 936

@REM ӳ������  PID  ����       
echo tasklist >> System_Details.txt
tasklist /SVC >> System_Details.txt                            

@REM �����ķ���
echo net start >> System_Details.txt
net start >> System_Details.txt

@REM �豸��ѯ��ģ����   ��ʾ���� ������������  ��������
echo driverquery >> System_Details.txt
DRIVERQUERY >> System_Details.txt

@REM ������ѯ
echo Wmic hotfix >> System_Details.txt 
wmic qfe get Caption,Description,HotFixID,InstalledOn >> System_Details.txt

@REM elavated ��ѯ 
echo reg queries - elavatedע���ѯ >> System_Details.txt 
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer\AlwaysInstallElevated
echo reg queries - elavated >> System_Details.txt
sc qc Spooler >> System_Details.txt
echo upnhosts - elavated >> System_Details.txt
sc qc upnphost >> System_Details.txt

@REM �ض��û��������Դ�������ļ���Ŀ¼��ע����ȫ�ֶ����Windows����ӵ����Щ���͵ķ���Ȩ��
@REM ��װ��ַ: https://learn.microsoft.com/en-us/sysinternals/downloads/accesschk
@REM accesschk.exe -ucqv Spooler >> System_Details.txt
@REM accesschk.exe -uwcqv "Authenticated Users" * >> System_Details.txt

echo End of Script >> System_Details.txt