import Flutter
import UIKit
import AVFoundation
// import CoreBluetooth
//
// var manager:CBCentralManager!

public class SwiftControlCenterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "control_center", binaryMessenger: registrar.messenger())
    let instance = SwiftControlCenterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if  call.method == "getPlatformVersion" {

        result("iOS " + UIDevice.current.systemVersion)

    } else if call.method == "getBatteryLevel" {

             let device = UIDevice.current
             device.isBatteryMonitoringEnabled = true
             if device.batteryState == UIDevice.BatteryState.unknown {
               result(FlutterError(code: "UNAVAILABLE",message: "Battery info unavailable",details: nil))
             } else {

               result(Int(device.batteryLevel * 100))//电池电量

             }


    }else if call.method == "openOrCloseFlashlight" {

          // 创建Device实例对象
             let device = AVCaptureDevice.default(for: AVMediaType.video)
           if device!.hasTorch && ((device?.isTorchAvailable) != nil){
            // 加锁
            try? device?.lockForConfiguration()
            if device?.torchMode == .off{
                // 开灯
                device?.torchMode = .on
                
                result(true)
            }else{
                // 关灯
                device!.torchMode = .off
                
                result(false)
            }
            // 解锁
            device!.unlockForConfiguration()
        }

    }

   result(FlutterMethodNotImplemented)


  }
}
