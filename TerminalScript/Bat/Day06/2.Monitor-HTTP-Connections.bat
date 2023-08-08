@echo off
@REM ����ָ��HTTP�˿���������������ű�
@REM ���͵�ַ blog.weiyigeek.top

set nowdate="%date:~0,10% %time:~0,5%"
set /a MONIROTPORT=%1%
if "%MONIROTPORT%" == "" goto usage

@REM ��ȡIP��ַ
ipconfig | findstr "IPv4" > %temp%\ipv4.txt

:count
echo %nowdate%
for /f "usebackq tokens=2 delims=:" %i in ("%temp%\ip.txt") do (
  set IP=%i
  set /p test="Num of HTTP Connections:  " < nul & netstat -na | findstr "\<%MONIROTPORT%\>" | find /C "%IP%:%MONIROTPORT%" 
)

@REM �ӳ�3��ִ��
timeout 3 > nul

@REM �������ת
GOTO count

:usage
echo "usage: %0% HTTP-Port"