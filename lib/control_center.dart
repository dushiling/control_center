import 'control_center_platform_interface.dart';

class ControlCenter {
  Future<String?> getPlatformVersion() {
    return ControlCenterPlatform.instance.getPlatformVersion();
  }

  Future<int?> getBatteryLevel() {
    return ControlCenterPlatform.instance.getBatteryLevel();
  }

  Future<bool?> openOrCloseFlashlight() {
    return ControlCenterPlatform.instance.openOrCloseFlashlight();
  }
}
