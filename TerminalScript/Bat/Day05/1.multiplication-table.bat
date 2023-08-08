@ECHO OFF 
@REM 九九乘法表
@REM 使用变量延迟绑定扩展
SETLOCAL ENABLEDELAYEDEXPANSION

@REM 终端背景颜色设置
color 2F
echo 正向递增:
for /l %%i in (1,1,9) do ( 
for /l %%j in (1,1,%%i) do ( 
	set /a h=%%i*%%j 
@REM 此处值得学习借鉴
	set /p=%%i×%%j^=!h! <nul
	if %%i==%%j echo. 
	) 
) 

echo.
echo 正向递减:
for /l %%i in (9,-1,1) do ( 
for /l %%j in (1,1,%%i) do ( 
	set /a h=%%i*%%j 
	set /p=%%i×%%j^=!h! <nul 
	if %%i==%%j echo. 
	) 
) 

echo.
echo 反向递增:
for /l %%w in (1,1,9) do ( 
for /l %%k in (%%w,-1,1) do (
	set /a h=%%w*%%k
	set /p=%%w×%%k=!h! <nul 
	if /I %%k==1 echo.
	) 
) 

echo.
echo 反向递减:
for /l %%w in (9,-1,1) do ( 
for /l %%k in (%%w,-1,1) do (
	set /a h=%%w*%%k
	set /p=%%w×%%k=!h! <nul 
	if /I %%k==1 echo.
	) 
) 
pause 