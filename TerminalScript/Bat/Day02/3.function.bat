@echo off
:: 批处理函数定义与使用

: 函数调用
goto pre

:start
echo "start 函数: 访问【全栈工程师修炼指南】公众号"
goto end

:view
echo "view 函数：正在浏览 https://weiyigeek.top"
goto end 

:pre
echo "pre 函数：正在准备程序运行前的准备"
goto start

:end
(echo "end 函数: 程序停止" )