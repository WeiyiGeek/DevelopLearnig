@echo off

REM 示例1
:: # 使用 %errorlevel% 变量判断命令是否成功执行。
whoami
if %errorlevel%==0 (echo "执行成功") else (echo "执行失败")

:: # 使用 if \[not\] "参数" == "字符串"（命令）进行判断
SET Author="WeiyiGeek"
:: # 不使用 NOT 关键字时
IF %Author%=="WeiyiGeek" (echo "A = WeiyiGeek") ELSE echo "A != WeiyiGeek"
:: # 使用 NOT 关键字时
IF NOT %Author%=="WeiyiGeek" (echo "Author is not WeiyiGeek") ELSE echo "Author is WeiyiGeek"

:: # 若文件存在则删除此文件，否则输出失败信息。
echo %CMDEXTVERSION%
IF EXIST filename.txt (echo "文件存在") ELSE (echo "文件不存在")
IF EXIST filename.txt ( echo "删除文件" & del filename.txt) ELSE (echo "filename.txt 文件删除失败")
:: 若 文件名 后加点·，则表示是同源文件名！