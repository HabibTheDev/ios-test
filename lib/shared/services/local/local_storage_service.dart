import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants/local_storage_key.dart';
import '../../enums/locale.enum.dart';
import '../../repository/local/local_storage_repo.dart';

class LocalStorageService extends LocalStorageRepo {
  static final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static Future<void> _saveData({required String key, required String? data}) async {
    if (data == null) return;
    await _secureStorage.write(key: key, value: data);
  }

  static Future<String?> _getData({required String key}) async {
    try {
      return await _secureStorage.read(key: key);
    } on PlatformException catch (e) {
      if (e.code == 'read' && e.message?.contains('BAD_DECRYPT') == true) {
        debugPrint('ERROR: Secure storage decryption for key: $key. Clearing corrupted data for this key only.');
        await _secureStorage.delete(key: key);
      }
      return null;
    } catch (e) {
      debugPrint('ERROR: Reading from secure storage for key: $key. Error: $e');
      return null;
    }
  }

  static Future<void> _removeData({required String key}) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clearAll() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      debugPrint('ERROR: clearing secure storage: $e');
      await _clearAllKeysIndividually();
    }
  }

  // Fallback method to clear all keys individually if deleteAll fails
  static Future<void> _clearAllKeysIndividually() async {
    try {
      await _removeData(key: LocalStorageKey.accessTokenKey);
      await _removeData(key: LocalStorageKey.refreshTokenKey);
      await _removeData(key: LocalStorageKey.pushPayloadKey);
      await _removeData(key: LocalStorageKey.localeKey);
    } catch (e) {
      debugPrint('ERROR: clearing individual keys: $e');
    }
  }

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

  // Push payload (stored as JSON string)
  @override
  Future<void> savePushPayload({required Map<String, dynamic>? payload}) async {
    if (payload == null) return;
    await _saveData(key: LocalStorageKey.pushPayloadKey, data: const JsonEncoder().convert(payload));
  }

  @override
  Future<Map<String, dynamic>?> getPushPayload() async {
    final jsonString = await _getData(key: LocalStorageKey.pushPayloadKey);
    if (jsonString == null) return null;
    return Map<String, dynamic>.from(const JsonDecoder().convert(jsonString));
  }

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
