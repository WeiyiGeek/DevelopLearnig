##############################################################################################################
# Author�� WeiyiGeek
# Description��ʹ�� adb����+Powershellʵ����Ļ�õ���ͻ���
# Date�� 2023��5��18�� 14��15��
# Blog�� https://blog.weiyigeek.top
# Wechat��WeiyiGeeker
# ��ӭ��ע���ں�: ȫջ����ʦ����ָ��
##############################################################################################################

# ���� screen_swipe 
# ���� x1,y1 x2,y2 ���� duration ����ʱ��
function screen_swipe($x1=480,$y1=1080,$x2=480,$y2=720,$duration=100)
{
  # �˴��ҵ��豸 Physical size: 1080x2310  
  $ScreenSize=(.\adb shell wm size) 
  # ѭ��һǧ��
  1..1000 | ForEach-Object { 
    # ��ȡ�����ʱʱ��
    $delay_time = Get-Random -Minimum 3 -Maximum 5
    Write-Host -ForegroundColor green "�� $_ �� swipe����Ļ���سߴ� $ScreenSize����ʱ $delay_time s"
    # ʵ����Ļ���ϻ���(ע����x��y�ߴ緶Χ�����������豸�ߴ�֮�¡�)
    .\adb.exe shell input swipe $x1 $y1 $x2 $y2 $duration; 
    # ����ָ������ʱʱ��
    sleep($delay_time) 
  }
}

# �˴��ҵ��豸 Physical size: 1080x2310  
$ScreenSize=(.\adb shell wm size) 

# ������screen_tap 
# ������ģ������Ļ�� x1,y1 ���� 
function screen_tap($x1=480,$y1=1080)
{
  Write-Host -ForegroundColor green "�����Ļ( $x1 , $y1 ) ����"
  # ���ָ��λ��
  .\adb.exe shell input tap $x1 $y1
  # ��ʱ1s
  sleep(1)
}

# ���� kuaishou_adver_box 
# ˵�� ѭ�������汦����Ҫ��ǰ��ȡ���λ�ã�����ÿ���ֻ��ֱ��ʲ�ͬ���������겻һ����������ֻ�����ִ���ռ���ȡ�ؼ�λ�����꣩
# ���� delay_time ��ʱʱ��
function kuaishou_adver_box($name, $delay_time=60) {
  # ѭ��һǧ��
  1..1000 | ForEach-Object { 
    Write-Host -ForegroundColor green "�� $_ �Σ����ڹۿ���kuaishou�������� $delay_time s"
    # ʵ�ֵ��ָ����Ļλ��
    if ($name -like "���㲹��") {
      screen_tap(306,2061)      # ���㲹�����
      sleep($delay_time)        # ָ�����ڹ��ʱ�������ʵ��
      screen_tap(539,192)       # ��Ŀ������� �رհ�ť
    } elseif ($name -like "�ճ��������") {
      screen_tap(942,345)       # �ճ���Ŀ�������
      sleep($delay_time) 
      screen_tap(539,192)       # ��Ŀ������� �رհ�ť
    } else {
      .\adb shell input keyevent KEYCODE_BACK # ��Ŀ�������
    }
  }
}

# ���� kuaishoujs_adver_box 
# ˵�� ѭ�������汦����Ҫ��ǰ��ȡ���λ�ã�����ÿ���ֻ��ֱ��ʲ�ͬ���������겻һ����������ֻ�����ִ���ռ���ȡ�ؼ�λ�����꣩
# ���� delay_time ��ʱʱ��
function kuaishoujs_adver_box($delay_time=60) {
  # ѭ��һǧ��
  1..1000 | ForEach-Object { 
    Write-Host -ForegroundColor green "�� $_ �Σ����ڹۿ���kuaishoujs�������� $delay_time s"
    # ʵ�ֵ��ָ����Ļλ��
    screen_tap(943,915)
    # ����ָ�����ʱ��
    sleep($delay_time) 
    screen_tap(539,192)
    # .\adb shell input keyevent KEYCODE_BACK
  }
}

# ������common_adver_box
# ˵����ѭ�������汦����Ҫ��ǰ��ȡ���λ�ã�����ÿ���ֻ��ֱ��ʲ�ͬ���������겻һ����������ֻ�����ִ���ռ���ȡ�ؼ�λ�����꣩
# ����:
function common_adver_box($appname="toutiao",$x1=943,$y1=209,$x2=652,$y2=1272,$delay_time=30) {
  1..1000 | ForEach-Object { 
    Write-Host -ForegroundColor green "�� $_ �Σ����ڹۿ���$appname�������� $delay_time s"
    screen_tap($x1,$y1)
    screen_tap($x2,$y2)
    sleep($delay_time) 
    # .\adb shell input keyevent KEYCODE_BACK
  }
}

# ��������
kuaishou_adver_box -name "���㲹��" -delay_time 30
#kuaishoujs_adver_box -delay_time 30
#common_adver_box # Ĭ�ϲ���
#$common_adver_box("toutiao",943,209,652,1272,30) # ͷ��������ɫ
#common_adver_box -appname toutiao -x1 967 -y1 161 -x2 580 -y2 1362 -delay_time 30 # ͷ�������ɫ