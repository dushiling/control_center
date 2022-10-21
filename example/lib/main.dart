import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:control_center/control_center.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controlCenterPlugin = ControlCenter();

  String _platformVersion = 'Unknown';
  int _batteryLevel = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  // 获取版本、电池电量
  Future<void> initData() async {
    String platformVersion;
    int batteryLevel;

    try {
      platformVersion = await _controlCenterPlugin.getPlatformVersion() ??
          'Unknown platform version';
      batteryLevel = await _controlCenterPlugin.getBatteryLevel() ?? 0;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      batteryLevel = 0;
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Android版本:  $_platformVersion\n'),
              Text('电池电量:  $_batteryLevel %\n'),
              TextButton(
                child: Text('闪光灯/手电筒'),
                onPressed: () async {
                  await _controlCenterPlugin.openOrCloseFlashlight();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
