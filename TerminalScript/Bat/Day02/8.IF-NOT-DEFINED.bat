@echo off
:: # 判断变量是不是存在
:: 当变量存在时
SET AA="计算器"
ECHO %AA%
IF DEFINED AA (echo "打开计算器" & calc) ELSE ECHO "AA 变量值 非 计算器"

:: 当变量不存在时
ECHO %AB%
IF DEFINED AB (echo "AB 变量存在") ELSE ECHO "AB 变量，貌似不存在"