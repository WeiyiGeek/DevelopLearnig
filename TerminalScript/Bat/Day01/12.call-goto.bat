@echo off
@REM 一个 call 与 goto 使用的经典案例
for /l %%j in (1,1,5) do (
@REM 此处是值得学习的
  if %%j==5 (goto :stop) else (call :multiply %%j %%j)   
)

@REM 注意此处是使用 %1 %2 ... %9 来接收变量值。
:multiply %1 %2   
set /a a=%1*%2
echo %1*%2=%a%

:stop
echo "!!! Over !!!!"