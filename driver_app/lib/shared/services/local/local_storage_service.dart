import 'dart:ui';
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/local_storage_key.dart';
import '../../repository/local/local_storage_repo.dart';
import '../../utils/locale.enum.dart';

class LocalStorageService extends LocalStorageRepo {
  static final _box = GetStorage();
  static Future<void> _saveData({required String key, required dynamic data}) async => await _box.write(key, data);
  static Future<dynamic> _getData({required String key}) async {
    final data = await _box.read(key);
    return data;
  }

  static Future<void> _removeData({required String key}) async => await _box.remove(key);

  @override
  Future<void> clearAll() async => await _box.erase();

  // Onboard
  @override
  Future<void> saveIsShowOnboard({required bool isShowOnboard}) async =>
      await _saveData(key: LocalStorageKey.showOnboardingKey, data: isShowOnboard);

  @override
  Future<bool?> getIsShowOnboard() async => await _getData(key: LocalStorageKey.showOnboardingKey);

  // Access token
  @override
  Future<void> saveAccessToken({required String? token}) async =>
      await _saveData(key: LocalStorageKey.accessTokenKey, data: token);

  @override
  Future<String?> getAccessToken() async => await _getData(key: LocalStorageKey.accessTokenKey);

  // Refresh token
  @override
  Future<void> saveRefreshToken({required String? token}) async =>
      await _saveData(key: LocalStorageKey.refreshTokenKey, data: token);

  @override
  Future<String?> getRefreshToken() async => await _getData(key: LocalStorageKey.refreshTokenKey);

  // Push payload
  @override
  Future<void> savePushPayload({required Map<String, dynamic>? payload}) async =>
      await _saveData(key: LocalStorageKey.pushPayloadKey, data: payload);

  @override
  Future<Map<String, dynamic>?> getPushPayload() async => await _getData(key: LocalStorageKey.pushPayloadKey);

  @override
  Future<void> clearPushPayload() async => await _removeData(key: LocalStorageKey.pushPayloadKey);

  // Locale
  @override
  Future<Locale> getCurrentLocale() async {
    final locale = await _getData(key: LocalStorageKey.localeKey);
    return Locale(locale ?? LocaleEnum.english.value);
  }

  @override
  Future<void> setLocale(String locale) async => await _saveData(key: LocalStorageKey.localeKey, data: locale);
}
