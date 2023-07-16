@echo off
echo weiyigeek > a.txt
echo weiyigeek.top >> a.txt
:: 输出数字到 a.txt 文件中
echo 1024 >> a.txt
:: 显示 a.txt 文件中的数据
type a.txt
echo.
echo.
REM ###############################################

echo 请任意输入字符以回车结束:
set /p ifo=
echo "欢迎关注【全栈工程师修炼指南】公众号，作者 WeiyiGeeker" > a.txt
echo 【从屏幕获得的输入信息 】
echo %ifo%
:: 将a.txt文件重定向输入到ifo变量中
set /p ifo=<a.txt    
echo 【 从文件a.txt获得的输入信息 】    
:: 输出从文件中读取的字符串
echo %ifo%
echo.
echo.

REM ###############################################
echo y|choice /C yn /M "看友，你是否关注了【全栈工程师修炼指南】公众号!"
echo.
echo ^|
echo ^&^&
echo ^<
echo ^<^<
echo.
echo test ^> 1.txt
pause