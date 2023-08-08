@echo off 
@REM 正向递增九九乘法表 
setlocal enabledelayedexpansion 
for /l %%a in (1,1,9) do ( 
  for /l %%b in (1,1,%%a) do ( 
    set /a i+=1 
    set /a ans=%%a*%%b 
    set ans=%%b×%%a=!ans! 
    set res=!res! !ans:~0,6! 
    if !i! equ %%a echo!res!&set res=& set i=0 
  ) 
) 
pause 