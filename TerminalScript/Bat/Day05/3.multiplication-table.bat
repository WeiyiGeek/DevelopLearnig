@echo off 
@REM ��������žų˷��� 
setlocal enabledelayedexpansion 
for /l %%a in (1,1,9) do ( 
  for /l %%b in (1,1,%%a) do ( 
    set /a i+=1 
    set /a ans=%%a*%%b 
    set ans=%%b��%%a=!ans! 
    set res=!res! !ans:~0,6! 
    if !i! equ %%a echo!res!&set res=& set i=0 
  ) 
) 
pause 