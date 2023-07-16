@echo off
REM 打印原始文本
echo "[# 原始文本]"
type output.txt
echo "-------------------------------------------"
REM 不显示以作为开头的行
REM echo 作者:唯一极客 >> output.txt
echo.
for /f "eol=作  delims=" %%i in (output.txt) do echo %%i 