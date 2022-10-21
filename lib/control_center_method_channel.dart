import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'control_center_platform_interface.dart';

/// An implementation of [ControlCenterPlatform] that uses method channels.
class MethodChannelControlCenter extends ControlCenterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('control_center');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> getBatteryLevel() async {
    final level = await methodChannel.invokeMethod('getBatteryLevel');
    return level;
  }

  @override
  Future<bool?> openOrCloseFlashlight() async {
    final result = await methodChannel.invokeMethod('openOrCloseFlashlight');
    return result;
  }
}
