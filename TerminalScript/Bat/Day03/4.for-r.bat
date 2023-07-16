@echo off
:: # 搜索当前目录和子目录中的所有文件（递归：recurision）
:: # 指定f:\rep目录
for /r f:\rep %%i in (*) do @echo %%i  

:: # 使用color命令修改终端显示颜色。
color 0B

:: # 当前目录
for /r %%i in (*) do @echo %%i