@echo off
:: # 批处理中字符串替换示例
cls
set url=www.weiyigeek.top
echo url 替换前 %url%
echo url 替换后 %url:www=blog% 
@REM 上述替换操作并不会改变变量url的值
echo url = %url%
@REM 若替换后用set重新赋值则变量url将会改变
set "url=%url:www.=share.%"         
echo "url => %url%"
@REM 将系统时间不足两位的以0补齐。
set hour=%time:~0,2%
echo 替换前的hour值=%hour%
set "hour=%hour: =0%"
echo 替换后的hour值=%hour%
pause