@echo off
REM # 指定 (1,1,5) 将产生序列1 2 3 4 5
for /L %%i in (1,1,5) do echo %%i
echo.

REM # 指定 (5,-1,1)将产生序列(5 4 3 2 1)
for /L %%i in (5,-1,1) do echo %%i
echo.

REM # 运行三次某一个命令, echo.^ 表示输出一个换行符
for /L %%i in (1,1,3) do (echo.^ | date && echo.^ | time)