@echo off
@REM ʹ�ù���ԱȨ������������ű�
@REM ���͵�ַ blog.weiyigeek.top
cd /d %~dp0
echo ����ʹ�ù���Ȩ�޴� %1 �ű��������.
start "" mshta vbscript:createobject("shell.application").shellexecute("""%1""","::",,"runas",1)(window.close)&exit