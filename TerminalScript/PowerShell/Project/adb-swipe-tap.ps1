##############################################################################################################
# Author： WeiyiGeek
# Description：使用 adb工具+Powershell实现屏幕得点击和滑动
# Date： 2023年5月18日 14点15分
# Blog： https://blog.weiyigeek.top
# Wechat：WeiyiGeeker
# 欢迎关注公众号: 全栈工程师修炼指南
##############################################################################################################

# 函数 screen_swipe 
# 参数 x1,y1 x2,y2 坐标 duration 滑动时间
function screen_swipe($x1=480,$y1=1080,$x2=480,$y2=720,$duration=100)
{
  # 此处我的设备 Physical size: 1080x2310  
  $ScreenSize=(.\adb shell wm size) 
  # 循环一千次
  1..1000 | ForEach-Object { 
    # 获取随机延时时间
    $delay_time = Get-Random -Minimum 3 -Maximum 5
    Write-Host -ForegroundColor green "第 $_ 次 swipe，屏幕像素尺寸 $ScreenSize，延时 $delay_time s"
    # 实现屏幕向上滑动(注意其x，y尺寸范围，必须在你设备尺寸之下。)
    .\adb.exe shell input swipe $x1 $y1 $x2 $y2 $duration; 
    # 休眠指定的延时时间
    sleep($delay_time) 
  }
}

# 此处我的设备 Physical size: 1080x2310  
$ScreenSize=(.\adb shell wm size) 

# 函数：screen_tap 
# 参数：模拟点击屏幕的 x1,y1 坐标 
function screen_tap($x1=480,$y1=1080)
{
  Write-Host -ForegroundColor green "点击屏幕( $x1 , $y1 ) 坐标"
  # 点击指定位置
  .\adb.exe shell input tap $x1 $y1
  # 延时1s
  sleep(1)
}

# 函数 kuaishou_adver_box 
# 说明 循环点击广告宝箱需要提前获取点击位置（由于每个手机分辨率不同，下述坐标不一定适配你的手机，请执行收集获取关键位置坐标）
# 参数 delay_time 超时时间
function kuaishou_adver_box($name, $delay_time=60) {
  # 循环一千次
  1..1000 | ForEach-Object { 
    Write-Host -ForegroundColor green "第 $_ 次，正在观看【kuaishou】宝箱广告 $delay_time s"
    # 实现点击指定屏幕位置
    if ($name -like "饭点补贴") {
      screen_tap(306,2061)      # 饭点补贴广告
      sleep($delay_time)        # 指定大于广告时间的休眠实践
      screen_tap(539,192)       # 项目广告任务 关闭按钮
    } elseif ($name -like "日常广告任务") {
      screen_tap(942,345)       # 日常项目广告任务
      sleep($delay_time) 
      screen_tap(539,192)       # 项目广告任务 关闭按钮
    } else {
      .\adb shell input keyevent KEYCODE_BACK # 项目广告任务
    }
  }
}

# 函数 kuaishoujs_adver_box 
# 说明 循环点击广告宝箱需要提前获取点击位置（由于每个手机分辨率不同，下述坐标不一定适配你的手机，请执行收集获取关键位置坐标）
# 参数 delay_time 超时时间
function kuaishoujs_adver_box($delay_time=60) {
  # 循环一千次
  1..1000 | ForEach-Object { 
    Write-Host -ForegroundColor green "第 $_ 次，正在观看【kuaishoujs】宝箱广告 $delay_time s"
    # 实现点击指定屏幕位置
    screen_tap(943,915)
    # 休眠指定广告时间
    sleep($delay_time) 
    screen_tap(539,192)
    # .\adb shell input keyevent KEYCODE_BACK
  }
}

# 函数：common_adver_box
# 说明：循环点击广告宝箱需要提前获取点击位置（由于每个手机分辨率不同，下述坐标不一定适配你的手机，请执行收集获取关键位置坐标）
# 参数:
function common_adver_box($appname="toutiao",$x1=943,$y1=209,$x2=652,$y2=1272,$delay_time=30) {
  1..1000 | ForEach-Object { 
    Write-Host -ForegroundColor green "第 $_ 次，正在观看【$appname】宝箱广告 $delay_time s"
    screen_tap($x1,$y1)
    screen_tap($x2,$y2)
    sleep($delay_time) 
    # .\adb shell input keyevent KEYCODE_BACK
  }
}

# 函数调用
kuaishou_adver_box -name "饭点补贴" -delay_time 30
#kuaishoujs_adver_box -delay_time 30
#common_adver_box # 默认参数
#$common_adver_box("toutiao",943,209,652,1272,30) # 头条宝箱蓝色
#common_adver_box -appname toutiao -x1 967 -y1 161 -x2 580 -y2 1362 -delay_time 30 # 头条宝箱红色