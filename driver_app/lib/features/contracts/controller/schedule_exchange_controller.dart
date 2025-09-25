import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/services/service_locator.dart';

import '../../../shared/utils/utils.dart';

class ScheduleExchangeController extends GetxController {
  // Date
  final Rxn<DateTime> deliveryDate = Rxn();
  final deliveryDateController = TextEditingController();
  // Time
  final Rxn<TimeOfDay> deliveryTime = Rxn();
  final deliveryTimeController = TextEditingController();

  final deliveryAddressController = TextEditingController();

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: deliveryDate.value);
    if (date != null) {
      deliveryDate.value = date;
      deliveryDateController.text = DateFormat('dd MMM, yyyy').format(deliveryDate.value!);
    }
  }

  Future<void> pickTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      deliveryTime.value = timeOfDay;
      deliveryTimeController.text = formatTimeOfDay(deliveryTime.value!);
    }
  }
}
