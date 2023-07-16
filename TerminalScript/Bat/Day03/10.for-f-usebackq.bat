@echo off
REM 不使用usebackq 你想显示当前目录下文件名中含有weiyigeek 字符串的文本文件的时候
for /f %%i in ('dir /a-d/b *output*.txt') do echo %%i  
echo.

REM 使用 usebackq 特殊文件名读取以及默认以空格分节
(
echo abc def
echo gh i j k
echo lm
) > "test 1.txt"
for /f "usebackq delims= " %%i in ("test 1.txt") do echo %%i 
echo.

REM 使用 usebackq 选项执行命令并引用结果, 运行下述批处理脚本，它将列出当前目录下的所有文件名
for /f "usebackq" %%i in (`dir /b`) do (
  echo File: %%i
)
echo.

REM 会枚举当前环境中的环境变量名称
FOR /F "usebackq delims==" %%i IN (`set`) do @echo %%i
echo.