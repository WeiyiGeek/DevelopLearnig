@echo off
:: # ���������ַ����滻ʾ��
cls
set url=www.weiyigeek.top
echo url �滻ǰ %url%
echo url �滻�� %url:www=blog% 
@REM �����滻����������ı����url��ֵ
echo url = %url%
@REM ���滻����set���¸�ֵ�����url����ı�
set "url=%url:www.=share.%"         
echo "url => %url%"
@REM ��ϵͳʱ�䲻����λ����0���롣
set hour=%time:~0,2%
echo �滻ǰ��hourֵ=%hour%
set "hour=%hour: =0%"
echo �滻���hourֵ=%hour%
pause