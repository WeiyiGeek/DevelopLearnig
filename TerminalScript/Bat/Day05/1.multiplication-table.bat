@ECHO OFF 
@REM �žų˷���
@REM ʹ�ñ����ӳٰ���չ
SETLOCAL ENABLEDELAYEDEXPANSION

@REM �ն˱�����ɫ����
color 2F
echo �������:
for /l %%i in (1,1,9) do ( 
for /l %%j in (1,1,%%i) do ( 
	set /a h=%%i*%%j 
@REM �˴�ֵ��ѧϰ���
	set /p=%%i��%%j^=!h! <nul
	if %%i==%%j echo. 
	) 
) 

echo.
echo ����ݼ�:
for /l %%i in (9,-1,1) do ( 
for /l %%j in (1,1,%%i) do ( 
	set /a h=%%i*%%j 
	set /p=%%i��%%j^=!h! <nul 
	if %%i==%%j echo. 
	) 
) 

echo.
echo �������:
for /l %%w in (1,1,9) do ( 
for /l %%k in (%%w,-1,1) do (
	set /a h=%%w*%%k
	set /p=%%w��%%k=!h! <nul 
	if /I %%k==1 echo.
	) 
) 

echo.
echo ����ݼ�:
for /l %%w in (9,-1,1) do ( 
for /l %%k in (%%w,-1,1) do (
	set /a h=%%w*%%k
	set /p=%%w��%%k=!h! <nul 
	if /I %%k==1 echo.
	) 
) 
pause 