@echo off
for %%i in ("a","b","c",1,2,3) do (echo %%i)
echo .

:: # 查看当前目录下的.txt或者.log
echo "WeiyiGeek" > test.txt
echo "全栈工程师修炼指南"> demo.log
mkdir demo
for %%f in (*.txt *.log) do type %%f

:: # 使用通配符遍历显示当时目录下的文件（不包含目录）
for %%i in (*) do echo %%i  
for %%i in (*.*) do echo %%i

:: # 列出只用两个字符作为文件名的文本文件
:: # 采用通配符? 一个表示一个字符
for %%i in (????.txt) do echo %%i