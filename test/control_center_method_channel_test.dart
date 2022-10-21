import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:control_center/control_center_method_channel.dart';

void main() {
  MethodChannelControlCenter platform = MethodChannelControlCenter();
  const MethodChannel channel = MethodChannel('control_center');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
