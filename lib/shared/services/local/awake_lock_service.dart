import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AwakeLockService {
  // Define a unique channel name. It's best practice to use a domain-style prefix.
  static const MethodChannel _awakeLockChannel = MethodChannel('com.fleetblox.employee_app/awake_lock');

  static Future<bool> enableAwakeLock() async {
    try {
      final bool? result = await _awakeLockChannel.invokeMethod('enableAwakeLock');
      debugPrint("Awake lock started");
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint("Failed to enable awake lock: ${e.message}");
      return false;
    }
  }

  static Future<bool> disableAwakeLock() async {
    try {
      final bool? result = await _awakeLockChannel.invokeMethod('disableAwakeLock');
      debugPrint("Awake lock stopped");
      return result ?? false;
    } on PlatformException catch (e) {
      debugPrint("Failed to disable awake lock: ${e.message}");
      return false;
    }
  }
}
