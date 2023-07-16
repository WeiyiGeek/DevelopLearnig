@echo off
:: 批处理接收命令行参数的传递演示
set a=%0
echo 当前执行文件:%a%
set b=%1
set c=%2
echo 参数1:%a% ,参数2:%c%
:: 将顺序地显示参数1和参数2的文件内容
type %1
type %2
pause