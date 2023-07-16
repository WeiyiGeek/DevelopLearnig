@echo off
echo "[# 原始文本]"
type output.txt
echo "-------------------------------------------"
:: 跳过前二行内容
for /f "skip=2 delims=" %%i in (output.txt) do echo %%i 
echo "-------------------------------------------"
for /f "skip=5 delims=" %%i in (output.txt) do echo %%i 