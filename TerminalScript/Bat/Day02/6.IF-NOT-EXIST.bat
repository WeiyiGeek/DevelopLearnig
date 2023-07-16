@echo off
:: IF 语句测试
echo 当前执行文件：%~fs0
IF EXIST test.js (
  echo delete filename
:: # 直接删除文件无需键盘输入
  echo y|del test.js
) ELSE (
  echo filename. missing.
)

:: # 采用通配符得方式
IF EXIST *.html (      
  echo delete *.html
  echo y|del *.html
) ELSE (
  echo filename. missing.
)

:: 建议关键字大写，表示如果存在c:\config.sys文件，则显示它的内容。
if NOT EXIST c:\config.sys (echo c:\config.sys) ELSE type c:\config.sys

:: 判断文件是不是存在，如果不存在就建立
IF NOT EXIST Republic.txt (echo "Republic" > Republic.txt & echo "Create Successful") ELSE (ECHO "Repubic.txt is Exsit")