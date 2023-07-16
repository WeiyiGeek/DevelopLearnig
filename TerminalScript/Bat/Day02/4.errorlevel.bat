@echo off
:: CMD终端执行
echo "WeiyiGeek 一个想成为全栈的男人。"
echo 返回值:%ERRORLEVEL%
:: #---------------------------------------------#
whoami /noparama
echo 错误返回值:%ERRORLEVEL%
:: #---------------------------------------------#
whoami 
:: 注意执行的命令片段需要使用()包裹
if %errorlevel%==0 (echo "执行成功") else (echo "执行失败")
"执行成功"