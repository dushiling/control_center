import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'control_center_method_channel.dart';

abstract class ControlCenterPlatform extends PlatformInterface {
  /// Constructs a ControlCenterPlatform.
  ControlCenterPlatform() : super(token: _token);

  static final Object _token = Object();

  static ControlCenterPlatform _instance = MethodChannelControlCenter();

  /// The default instance of [ControlCenterPlatform] to use.
  ///
  /// Defaults to [MethodChannelControlCenter].
  static ControlCenterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ControlCenterPlatform] when
  /// they register themselves.
  static set instance(ControlCenterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> getBatteryLevel() {
    throw UnimplementedError('BatteryLevel() has not been implemented.');
  }

  Future<bool?> openOrCloseFlashlight() {
    throw UnimplementedError('Flashlight() has not been implemented.');
  }
}
