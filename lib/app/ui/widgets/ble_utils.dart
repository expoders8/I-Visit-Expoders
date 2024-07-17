import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleUtils {
  final flutterReactiveBle = FlutterReactiveBle();

  static final validCodeUnits = "Access valid".codeUnits;

  scanForMatchingDevice() async {
    var ddd = flutterReactiveBle
        .scanForDevices(
            requireLocationServicesEnabled: false,
            withServices: [],
            scanMode: ScanMode.lowLatency)
        .listen((scanResult) async {}, onDone: () {
      debugger();
      debugPrint("BLE-5 onDone");
      debugPrint("BLE-6");
    }, onError: (e) {}, cancelOnError: true);

    debugPrint("BLE-8");
  }

  static Future<bool> checkBluetoothPermission() async {
    if (Platform.isAndroid) {
      bool permOne = await Permission.bluetoothScan.request().isGranted;
      bool permThree = await Permission.bluetoothConnect.request().isGranted;

      return permOne && permThree ? true : false;
    }
    return true;
  }

  static Future<bool> checkLocationPermissions() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var info = await deviceInfoPlugin.androidInfo;
      var sdk = info.version.sdkInt;
      if (sdk <= 30) {
        Completer<bool> completer = Completer();

        var isGranted = await Permission.location.request().isGranted;

        if (!isGranted && !(await Permission.location.request().isGranted)) {
          return completer.future;
        }
      }
      return true;
    }

    return true;
  }
}
