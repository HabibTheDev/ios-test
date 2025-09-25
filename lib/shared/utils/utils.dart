import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl, LaunchMode;

import 'app_toast.dart';

void hideKeyboard() => SystemChannels.textInput.invokeMethod('TextInput.hide');

String readableDate(DateTime dateTime, {required String pattern, String? locale}) {
  return DateFormat(pattern, locale).format(dateTime.toLocal());
}

bool isOnlineImage({required String url}) {
  final Uri? uri = Uri.tryParse(url);
  final bool isImageExtension = hasImageExtension(url: url);
  final bool isOnlineUri = uri != null && uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
  return isOnlineUri && isImageExtension;
}

bool isLocalImage({required String path}) {
  final Uri? uri = Uri.tryParse(path);
  final bool isImageExtension = hasImageExtension(url: path);
  final bool isOfflineUri = uri != null && !uri.isAbsolute && uri.scheme != 'http' && uri.scheme != 'https';
  return isOfflineUri && isImageExtension;
}

bool hasImageExtension({required String url}) {
  final Set<String> imageExtensions = {'.png', '.jpg', '.jpeg', '.webp', '.gif', '.bmp', '.wbmp'};
  return imageExtensions.any(url.toLowerCase().endsWith);
}

bool isPdf({required String url}) => url.endsWith('.pdf');

String getFileNameFromUrl(String url) => Uri.parse(url).pathSegments.last;

double roundDouble(double value, {int decimalPoint = 2}) => double.parse(value.toStringAsFixed(decimalPoint));

Future<void> openUrl({required String? url, LaunchMode? mode}) async {
  if (url == null) return;
  try {
    await launchUrl(Uri.parse(url), mode: mode ?? LaunchMode.externalApplication);
  } catch (e) {
    showToast('Error: $e');
  }
}

Color? hexToColor(String? hexString) {
  if (hexString == null || hexString.isEmpty) return null;
  // Remove the # if present
  String hex = hexString.startsWith('#') ? hexString.substring(1) : hexString;
  // Handle different hex formats
  if (hex.length == 6) {
    // 6-digit hex (RGB)
    return Color(int.parse('FF$hex', radix: 16));
  } else if (hex.length == 8) {
    // 8-digit hex (ARGB)
    return Color(int.parse(hex, radix: 16));
  } else if (hex.length == 3) {
    // 3-digit hex (RGB)
    String expanded = hex.split('').map((char) => char + char).join();
    return Color(int.parse('FF$expanded', radix: 16));
  }
  return null;
}
