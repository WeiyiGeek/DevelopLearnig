@echo off
:: # 提取分割符号`:`的第二节字符串，类似于Linux中 cut -f 2 -d : wieyigeek.txt
for /f "tokens=2 delims=:" %%i in (output.txt) do echo %%i 
echo.

:: # 以:分别提取显示IP地址以及端口。
(
  echo 192.168.1.2:8080
  echo 192.168.1.3:8080
  echo 192.168.1.4:8080
) > target.txt
for /f "delims=:" %%i in (target.txt) do echo 获取到的IP地址:%%i 
for /f "tokens=2 delims=:" %%i in (target.txt) do echo 获取到的端口号:%%i 
echo.

:: # 提取以逗号切分的第2节和第5节字符串（注意中英文）
(
  echo "全栈工程师修炼指南"
  echo "专注于企业SecDevOps,网安等保等实践内容分享,负责保障企业网络系统,应用程序,数据安全,CI/CD系统等方面的稳定运行" 
) >> section.txt
for /f "tokens=2,5  delims=," %%i in (section.txt) do echo %%i %%j