@echo off
@REM ���������ʮ����ʮ���Ƶ�2��10��16���Ƶ�ת��
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
echo 10��������ǰ����ĸD����Сд����Ч��
echo 16��������ǰ��0x��x��Сд����Ч��

:start
set  bincnt=0
set  binsl=4
echo ����������
set /p input_str=
::�����ַ�������input_str
set /A str_num=%input_str%
::����������16���������������16������ת��Ϊ10���Ƹ�ֵ��str_num
set str_type=%input_str:~0,1%
::��ȡ�����ַ��ĵ�һ���ַ�����0��ʼ�ĵ�һ���ַ���
set str_type1=%input_str:~1,1%
::��ȡ�����ַ��ĵ�2���ַ�����1��ʼ�ĵ�һ���ַ���
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

@REM ʮ����תʮ������
:dec2hex
set code=0123456789ABCDEF
set /a num=%1
::����һ��������ֵ������a
::echo %num%
::pause
set var=%num%
::echo %var%
::pause
set str=
@REM �������ֵ�ת��ʹ�����������ؼ��㣩
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

@REM ʮ����ת������
:dec2bin
set code=01
set /a num=%1
set var=%num%
set str=
@REM �������ֵ�ת��ʹ�����������ؼ��㣩
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
    ::���ȵ���4ʱ�����ַ�ǰ����","�ַ�    
    set /a bincnt=0        
) else (set str=%tra%%str%)
if %var% geq 2 goto again1 
::echo %var%%str%
if %var% neq 0 (set binstr=0b %var%%str%) else (set binstr=0b %str%)
::echo binstr=%binstr%
set bin_return=%binstr%
::echo return=%return%
goto:eof