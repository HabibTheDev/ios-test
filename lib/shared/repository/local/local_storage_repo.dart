import 'dart:ui';

abstract class LocalStorageRepo {
  Future<void> clearAll();
  Future<void> saveAccessToken({required String? token});
  Future<String?> getAccessToken();
  Future<void> saveRefreshToken({required String? token});
  Future<String?> getRefreshToken();
  Future<void> savePushPayload({required Map<String, dynamic>? payload});
  Future<Map<String, dynamic>?> getPushPayload();
  Future<void> clearPushPayload();
  Future<Locale> getCurrentLocale();
  Future<void> setLocale(String locale);
}
