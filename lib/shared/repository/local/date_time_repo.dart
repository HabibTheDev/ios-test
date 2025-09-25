import 'package:flutter/material.dart';

abstract class DateTimeRepo {
  Future<DateTime?> androidDatePicker(BuildContext context, {DateTime? lastDate});
  Future<DateTime?> iOSDatePicker(BuildContext context, {DateTime? lastDate, DateTime? initialDate});
}
