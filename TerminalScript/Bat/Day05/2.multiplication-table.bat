@echo off 
@REM �žų˷��� 
set num=0 
for /l %%i in (1,1,9) do ( 
  for /l %%j in (1,1,%%i) do call :multiply %%i %%j 
)
goto :end

@REM �ؼ�����
:multiply 
set /a num+=1 
set /a var=%1*%2 
set var=%2��%1=%var% 
set var=%var% 
if %2 equ 1 (set var=%var:~0,5%) else set var=%var:~0,6% 
set str=%str% %var% 
if %num% equ %1 echo %str%&set str=&set num=0 
goto :eof 

@REM �˳�����
:end
pause >nul 