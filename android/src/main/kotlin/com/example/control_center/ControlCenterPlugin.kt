package com.example.control_center

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.hardware.Camera
import android.hardware.camera2.CameraManager
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat.getSystemService

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.nio.channels.AsynchronousFileChannel.open
import java.nio.channels.DatagramChannel.open
import java.nio.channels.Pipe.open
import java.nio.channels.SocketChannel.open

/** ControlCenterPlugin */
class ControlCenterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var myContext: Context
  private lateinit var manager: CameraManager
  private lateinit var mCamera: Camera
  private var isFlashOn = false //记录手电筒状态

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "control_center")
    channel.setMethodCallHandler(this)

    myContext=flutterPluginBinding.applicationContext

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        manager = myContext.getSystemService(Context.CAMERA_SERVICE) as CameraManager
    }

  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {

      result.success("Android ${android.os.Build.VERSION.RELEASE}")

    }else  if (call.method == "getBatteryLevel") {

      val batteryLevel = getBatteryLevel()
      result.success(batteryLevel)

    }else  if (call.method == "openOrCloseFlashlight") {

      val  lightStatus = openOrCloseFlashlight()
      result.success(lightStatus)

    }else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  //获取电池电量
  private fun getBatteryLevel(): Int {
    val batteryLevel: Int
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {

      val batteryManager = myContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
      batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

    } else {
      val intent = ContextWrapper(myContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
      batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
    }

    return batteryLevel
  }

  //打开闪光灯
  private fun openOrCloseFlashlight(): Boolean {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

      manager.setTorchMode("0", !isFlashOn)
      isFlashOn=!isFlashOn

    }else{
      var camera = Camera.open()
      var parameters = camera.parameters
      if (isFlashOn) {
        parameters.flashMode = Camera.Parameters.FLASH_MODE_OFF
      } else {
        parameters.flashMode = Camera.Parameters.FLASH_MODE_TORCH
      }
      camera.parameters = parameters
      isFlashOn = !isFlashOn

    }

    return  isFlashOn
  }







}
