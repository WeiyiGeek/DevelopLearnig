@echo off 
echo 尺有所短,寸有所长,学好批处理没商量,解决问题简洁化。 > test1.txt
echo "[# 原始文本]"
type test1.txt

REM # 使用tokens参数直接分割字符串
REM # 例如当你想把blog.weiyigeek.top字符中的点号换为短横线并显示
echo.
for  /f  "tokens=1-3 delims=." %%i in ("blog.weiyigeek.top")  do  echo  %%i-%%j-%%k 
:: # 读取文件文本并进行空格分割
echo.
for /f "tokens=1,2,3,4,5 delims=," %%i in (test1.txt) do echo %%i %%j %%k %%l %%m 
:: # 效果同上
echo.
for /f "tokens=1,* delims=," %%i in (test1.txt) do echo %%i %%j 
:: # 跳过第二列并进行空格分割
echo.
for /f "tokens=1,3-4,* delims=," %%i in (test1.txt) do echo %%i %%j %%k %%l

pause 