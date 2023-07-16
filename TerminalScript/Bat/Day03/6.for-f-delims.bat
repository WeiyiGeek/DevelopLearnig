@echo off
:: # 以空格符分割内容
for /f "delims=" %%i in (output.txt) do echo %%i-EOF

:: # 以:符号分割内容
for /f "delims=:" %%i in (output.txt) do echo %%i-EOF

:: # 以多个符号分割内容, 如果恰好是:,则分割一次
for /f "delims=," %%i in (output.txt) do echo %%i-EOF