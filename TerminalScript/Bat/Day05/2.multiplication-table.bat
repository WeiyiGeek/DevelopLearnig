@echo off 
@REM 九九乘法表 
set num=0 
for /l %%i in (1,1,9) do ( 
  for /l %%j in (1,1,%%i) do call :multiply %%i %%j 
)
goto :end

@REM 关键部分
:multiply 
set /a num+=1 
set /a var=%1*%2 
set var=%2×%1=%var% 
set var=%var% 
if %2 equ 1 (set var=%var:~0,5%) else set var=%var:~0,6% 
set str=%str% %var% 
if %num% equ %1 echo %str%&set str=&set num=0 
goto :eof 

@REM 退出程序
:end
pause >nul 