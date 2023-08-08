@echo off
@REM 批量创建的目录把createQuxian.cmd文件复制到个子目录中
@REM 博客地址 blog.weiyigeek.top
mkdir delete other photo_bak photo_ksh photo_ksh.rar photo_ksh_backup  photo_ksh_log photo_rar photo_rar_log photo_sfzh_f photo_sfzh_z temp demo

for /f "delims=" %%N in ('dir /A:D /B') ^
do ( 
  xcopy createQuxian.cmd %%N /y
)
pause