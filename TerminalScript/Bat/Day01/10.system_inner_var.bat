@echo off
:: 系统内置变量一览
echo 当前盘符：%~d0
echo 当前盘符和路径：%~dp0
echo 当前批处理全路径：%~f0
echo 当前盘符和路径的短文件名格式：%~sdp0
echo 当前CMD默认目录：%cd%
echo 当前日期时间: %date% %time% 
echo 随机字符串: %RANDOM% 
echo 当前 ERRORLEVEL 数值: %ERRORLEVEL%
echo 当前命令处理器扩展版本号: %CMDEXTVERSION% 
echo 当前调用命令处理器的原始命令行: %CMDCMDLINE%
echo 当前计算机上的最高 NUMA 节点号：%HIGHESTNUMANODENUMBER%

::目录中有空格也可以加入""避免找不到路径
echo 当前盘符："%~d0"
echo 当前盘符和路径："%~dp0"
echo 当前批处理全路径："%~f0"
echo 当前盘符和路径的短文件名格式："%~sdp0"
echo 当前CMD默认目录："%cd%"
pause