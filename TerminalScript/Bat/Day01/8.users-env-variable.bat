@echo off
# 运行 jdk-8u181-windows64.exe /q 即可进行静默安装即可(默认路径) 
jdk-8u181-windows64.exe /q
# 设置永久变量
setx /M JAVA_HOME "C:\Program Files\Java\jdk1.8.0_181"
setx /M JAVA_HOME "C:\Program Files\Java\jdk1.8.0_221"
# 成功: 指定的值已得到保存。
setx /M PATH "%PATH%;%JAVA_HOME%\bin;%JAVA_HOME%\jre;"
# 成功: 指定的值已得到保存。