# control_center

Control flash light switch. Get the battery power, get the phone system version.

## Usage

```
   import 'package:control_center/control_center.dart';

   final _controlCenterPlugin = ControlCenter();
   //打开/关闭手电筒
   bool switchBool =  await _controlCenterPlugin.openOrCloseFlashlight();

   //获取手机电池电量
   int batteryLevel = await _controlCenterPlugin.getBatteryLevel()
   //获取手机系统版本
   String platformVersion = await _controlCenterPlugin.getPlatformVersion();

```
