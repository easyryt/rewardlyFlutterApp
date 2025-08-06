import 'package:flutter/services.dart';

class NativeInstallHelper {
  static const MethodChannel _channel = MethodChannel('native_helper');

  static Future<void> openPlayStore(String packageName) async {
    try {
      await _channel
          .invokeMethod('openPlayStore', {'packageName': packageName});
    } catch (e) {
      print("Failed to open Play Store: $e");
    }
  }
}
