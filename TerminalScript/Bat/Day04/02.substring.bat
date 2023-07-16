@echo off
@REM 批处理中截取字符串示例
cls
set ifo=0123456789-ABCDEFGHIJKLMNOPQRSTUVWXYZ-abcdefghijklmnopqrstuvwxyz

@REM 截取前10个字符
echo 1.截取前10个字符
echo %ifo:~0,10%
echo.

@REM 截取后26个字符
echo 2.截取后26个字符
echo %ifo:~-26%
echo.

@REM 截取从第10个字符开始+1-向后截取27个字符
echo 3.截取从第10个字符开始+1向后截取27个字符
echo %ifo:~10,27%
echo.

@REM 截取从第23个字符开始+1,截取到后13个字符
echo 4.截取从第23个字符开始1,截取到后13个字符
echo %ifo:~23,-13%
echo.

@REM 截取从第23个字符开始+1,截取向右最的后字符
echo 5.截取从第23个字符开始+1,截取向右最的后字符
echo %ifo:~23%
echo.

@REM 截取从后数第53个字符开始+1,然后从这截取到得部分向后截取26个字符
echo 6.截取从后数第53个字符开始+1,然后从这截取到得部分向后截取26个字符
echo %ifo:~-53,26%
pause