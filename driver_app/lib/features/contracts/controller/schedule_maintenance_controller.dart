import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/utils.dart';

class ScheduleMaintenanceController extends GetxController {
  // Date
  final Rxn<DateTime> retrieveDate = Rxn();
  final retrieveDateController = TextEditingController();
  // Time
  final Rxn<TimeOfDay> retrieveTime = Rxn();
  final retrieveTimeController = TextEditingController();

  final retrieveAddressController = TextEditingController();
  final deliveryAddressController = TextEditingController();

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: retrieveDate.value);
    if (date != null) {
      retrieveDate.value = date;
      retrieveDateController.text = DateFormat('dd MMM, yyyy').format(retrieveDate.value!);
    }
  }

  Future<void> pickTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      retrieveTime.value = timeOfDay;
      retrieveTimeController.text = formatTimeOfDay(retrieveTime.value!);
    }
  }
}
