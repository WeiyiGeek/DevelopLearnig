@echo off
:: # 批处理中字符串拼接示例
cls
set name=Weiyi
set lastname=Geek
set age=88
set section="中国梦，我的梦"
echo %name% %lastname% %section%
echo "age => %age%"
:: 此处需要注意其双引号
set "section=%name%%lastname% %section% ，my age is %age%."
echo %section%
pause