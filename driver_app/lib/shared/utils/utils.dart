import 'package:flutter/material.dart';

int formatNumber(int number) {
  return number < 10 ? int.parse('0$number') : number;
}

String formatNumberToString(int number) {
  return number < 10 ? '0$number' : '$number';
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hours =
      timeOfDay.hour == 0 || timeOfDay.hour == 12 ? 12 : timeOfDay.hour % 12;
  final minutes = timeOfDay.minute;
  final amPm = timeOfDay.hour < 12 ? 'AM' : 'PM';
  return '${formatNumberToString(hours)}:${formatNumberToString(minutes)} $amPm';
}

String getFileNameFromUrl(String url) {
  Uri uri = Uri.parse(url);
  String path = uri.path;
  List<String> segments = path.split('/');
  String fileName = segments.last;
  return fileName;
}

double roundDouble(double value, {int decimalPoint = 2}) {
  return double.parse(value.toStringAsFixed(decimalPoint));
}
