@echo off
:: 变量(Variable)定义与调用
set var1=123
echo var1=%var1%

set var2=456
echo var2=%var2%

:: 将变量进行调用并进行算数（加减乘除）运算
set /a sum=%var1%+%var2%
echo var1 + var2 = %sum%

:: 删除定义的变量,在变量名后加上=则表示删除该变量
set sum=
echo %sum%
pause