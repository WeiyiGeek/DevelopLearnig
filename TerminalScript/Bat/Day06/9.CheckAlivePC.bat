@echo off
Title ��ѯ������������Щ��������
setlocal enabledelayedexpansion

@REM ��ȡ����IP��ַ
ECHO ���ڻ�ȡ������IP��ַ�����Ե�...
for /f "delims=: tokens=2" %%i in ('ipconfig ^| find /i "IPv4"') do set ip=%%i
echo %ip%
for /f "delims=. tokens=1,2,3,4" %%i in ("%IP%") do set range=%%i.%%j.%%k

ECHO ����̽�����Ρ� %range%.* ���ڵļ���������Ե�...
for /l %%a in (2,1,254) do ( set ipaddr=%range%.%%a && ping -n 1 !ipaddr!>nul & echo !ipaddr!)

ECHO.&ECHO ���ڻ�ȡ�������ڵ��������߼�����������Ե�...
ECHO �����Ρ�%range%.*���ڵļ�����У�
 
for /f "delims=" %%i in ('net view') do (
  set "var=%%i"
  @REM ��ѯ���߼��������
  if "!var:~0,2!"=="\\" (
    set "var=!var:~2!"
    ECHO !var!
    @REM ����һ��ping����
    ping -n 1 !var!>nul
  )
)
 
ECHO.
ECHO ���ڻ�ȡ�������ڵ��������߼����IP�����Ե�...
for /f "skip=3 tokens=1,* delims= " %%i in ('arp -a') do ECHO IP�� %%i ����ʹ��
 
ECHO.
ECHO ��ѯ��ϣ���������˳�...
pause>nul