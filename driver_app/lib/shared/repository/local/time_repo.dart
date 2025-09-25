import 'package:flutter/material.dart';

abstract class TimeRepo {
  Future<TimeOfDay?> iOSTimePicker(BuildContext context);
}
