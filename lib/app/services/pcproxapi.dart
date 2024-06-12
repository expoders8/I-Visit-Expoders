import 'package:flutter/services.dart';

class PcProxApi {
  static const MethodChannel _channel = MethodChannel('pcprox_api');

  static Future<void> scan() async {
    try {
      await _channel.invokeMethod('scan');
    } on PlatformException catch (e) {
      print("Failed to scan: '${e.message}'.");
    }
  }
}
