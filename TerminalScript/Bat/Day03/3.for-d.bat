@echo off
REM 只显示当前目录下的目录
for /d %%i in (*) do @echo %%i  

REM 将当前路径下文件夹的名字只有1-4个字母的文件夹打印处理啊
for /d %%i in (????) do @echo %%i  