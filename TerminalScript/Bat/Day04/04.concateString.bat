@echo off
:: # ���������ַ���ƴ��ʾ��
cls
set name=Weiyi
set lastname=Geek
set age=88
set section="�й��Σ��ҵ���"
echo %name% %lastname% %section%
echo "age => %age%"
:: �˴���Ҫע����˫����
set "section=%name%%lastname% %section% ��my age is %age%."
echo %section%
pause