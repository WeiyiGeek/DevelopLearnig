@echo off 
:: # 多行输出
(
  echo "Author: WeiyiGeek"
  echo "作者: 公众号名称,全栈工程师修炼指南"
  echo "签名1: 花开堪折直须折,莫待无花空折枝"
  echo "签名2: 花开堪折直须折,莫待无花空折枝"
  echo "签名3: 花开堪折直须折,莫待无花空折枝"
  echo "说明1: 跟着我学好批处理没商量"
) > output.txt

echo .
for /f  %%i in (output.txt) do echo %%i-END
pause 