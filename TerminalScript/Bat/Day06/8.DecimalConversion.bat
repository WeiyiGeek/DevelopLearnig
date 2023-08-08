@echo off
@REM 批处理进行十六、十进制到2、10、16进制的转换
setlocal ENABLEDELAYEDEXPANSION
set hexstr=ss
set binstr=ss
set /a ii=0
set /a dec=0
set /a bin=0
set hex_return=123
set bin_return=123
set returnPara=321
set hex_type=x
set HEX_type1=X
set dec_type=d
set DEC_type1=D
set blank=,
set  bincnt=0
set  binsl=4
echo 10进制数据前加字母D（大小写都有效）
echo 16进制数据前加0x（x大小写都有效）

:start
set  bincnt=0
set  binsl=4
echo 请输入数据
set /p input_str=
::输入字符到变量input_str
set /A str_num=%input_str%
::如果输入的是16进制数，将输入的16进制数转换为10进制赋值给str_num
set str_type=%input_str:~0,1%
::提取输入字符的第一个字符（从0开始的第一个字符）
set str_type1=%input_str:~1,1%
::提取输入字符的第2个字符（从1开始的第一个字符）
::echo !str_num!
::echo %str_num%
if !str_type1! equ !hex_type! (        
  call:dec2hex !str_num!
  set hex=!hex_return!    
  call:dec2bin !str_num!
  set bin=!bin_return!
  echo dec=%str_num%, hex=!hex_return!, bin=!bin_return!
)else if !str_type1! equ !HEX_type1! (        
  call:dec2hex !str_num!
  set hex=!hex_return!    
  call:dec2bin !str_num!
  set bin=!bin_return!
  echo dec=%str_num%, hex=!hex_return!, bin=!bin_return!
)else if !str_type! equ !dec_type! (
  set str_num=%input_str:~1,15%
  call:dec2hex !str_num!
  set hex=!hex_return!    
  call:dec2bin !str_num!
  set bin=!bin_return!
  echo dec=!str_num!, hex=!hex_return!, bin=!bin_return!
)else if !str_type! == !DEC_type1! (
  set str_num=%input_str:~1,15%
  call:dec2hex !str_num!
  set hex=!hex_return!    
  call:dec2bin !str_num!
  set bin=!bin_return!
  echo dec=!str_num!, hex=!hex_return!, bin=!bin_return!
) else (echo input err && exit 1)
goto start
::end

pause
for /l %%i in (0,1,255) do (
::echo i= %%i
set /a ii=%%i
set /a dec=!ii!
::echo dec= %%i
call:dec2hex !dec!
set return2=!return!
set hexstr2=!hexstr!
echo dec= %%i, return2=!return!, hexstr2=!hexstr2!
set /a ii+=1
)
echo done
pause

@REM 十进制转十六进制
:dec2hex
set code=0123456789ABCDEF
set /a num=%1
::将第一个参数赋值给变量a
::echo %num%
::pause
set var=%num%
::echo %var%
::pause
set str=
@REM 整数部分的转换使用连除法（关键点）
:again
set /a tra=%var%%%16
::echo test
::echo !tra!
call,set tra=%%code:~%tra%,1%%
::echo tra=%tra%
::pause
set /a var/=16
::echo var=%var%
set str=%tra%%str%
if %var% geq 10 goto again
::echo %var%%str%
if %var% neq 0 (set hexstr=0x%var%%str%) else (set hexstr=0x%str%)
::echo hexstr=%hexstr%
set hex_return=%hexstr%
::echo return=%return%
goto:eof

@REM 十进制转二进制
:dec2bin
set code=01
set /a num=%1
set var=%num%
set str=
@REM 整数部分的转换使用连除法（关键点）
:again1
set /a tra=%var%%%2
::echo %var%
::echo %tra%
::pause
call,set tra=%%code:~%tra%,1%%
::echo tra=%tra%
::pause
set /a var/=2
::echo var=%var%
set /a bincnt+=1
if !bincnt! == !binsl! (    
    set str=%blank%%tra%%str%    
    ::长度等于4时，在字符前增加","字符    
    set /a bincnt=0        
) else (set str=%tra%%str%)
if %var% geq 2 goto again1 
::echo %var%%str%
if %var% neq 0 (set binstr=0b %var%%str%) else (set binstr=0b %str%)
::echo binstr=%binstr%
set bin_return=%binstr%
::echo return=%return%
goto:eof