@echo off
:: 在批处理中，可以使用以下方法来实现不换行输出：
:: 使用 /n 命令（验证无效）：
echo /n This is a test
:: 使用 . 命令验证无效）：
echo. This is a test
:: 使用 set /p 命令：
set /p=This is a test & set /p=This is a test
echo.