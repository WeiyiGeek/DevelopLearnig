@echo off
@REM 使用管理员权限运行批处理脚本
@REM 博客地址 blog.weiyigeek.top
cd /d %~dp0
echo 正在使用管理权限打开 %1 脚本或者软件.
start "" mshta vbscript:createobject("shell.application").shellexecute("""%1""","::",,"runas",1)(window.close)&exit