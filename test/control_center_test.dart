import 'package:flutter_test/flutter_test.dart';
import 'package:control_center/control_center.dart';
import 'package:control_center/control_center_platform_interface.dart';
import 'package:control_center/control_center_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockControlCenterPlatform
    with MockPlatformInterfaceMixin
    implements ControlCenterPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<int?> getBatteryLevel() {
    // TODO: implement getBatteryLevel
    throw UnimplementedError();
  }

  @override
  Future<bool?> openOrCloseFlashlight() {
    // TODO: implement openOrCloseFlashlight
    throw UnimplementedError();
  }
}

void main() {
  final ControlCenterPlatform initialPlatform = ControlCenterPlatform.instance;

  test('$MethodChannelControlCenter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelControlCenter>());
  });

  test('getPlatformVersion', () async {
    ControlCenter controlCenterPlugin = ControlCenter();
    MockControlCenterPlatform fakePlatform = MockControlCenterPlatform();
    ControlCenterPlatform.instance = fakePlatform;

    expect(await controlCenterPlugin.getPlatformVersion(), '42');
  });
}
