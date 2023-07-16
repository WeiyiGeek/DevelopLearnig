@echo off
@REM 批处理中扩充字符串示例，此处以0来做变量演示
echo 完全路径：%0
echo 去掉引号：%~0
echo 所在分区：%~d0
echo 所处路径：%~p0
echo 文件名：%~n0
echo 扩展名：%~x0
echo 路径和带有短文件名：%~f0 = %~s0
echo 文件属性：%~a0
echo 修改时间：%~t0
echo 文件大小：%~z0
@REM 可以用上面的修饰符进行重新组合,达到的扩充字符串!
echo 驱动器号和路径：%~dp0
echo 文件名和扩展名：%~nx0
echo 完整路径名带有短文件名：%~fs0
echo 相当于Linux中ll命令显示的的效果:
echo %~ftza0
echo 当前环境变量分区：%~ds$PATH:0
echo 当前环境变量路径与短文间名称：%~fs$PATH:0
pause