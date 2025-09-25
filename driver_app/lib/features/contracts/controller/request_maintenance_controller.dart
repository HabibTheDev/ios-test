import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/utils.dart';

import '../model/maintenance_type_radio_model.dart';
import '../model/return_method_radio_model.dart';

class RequestMaintenanceController extends GetxController {
  // Return method
  final Rxn<ReturnMethodRadioModel> selectedReturnMethod = Rxn();
  // Service type
  final Rxn<MaintenanceTypeRadioModel> selectedMaintenanceType = Rxn();
  // Date
  final Rxn<DateTime> selectedDate = Rxn();
  final selectedDateController = TextEditingController();
  // Time
  final Rxn<TimeOfDay> selectedTime = Rxn();
  final selectedTimeController = TextEditingController();

  final RxnString selectedPickupLocation = RxnString();
  final retrieveAddressController = TextEditingController();
  final deliveryAddressController = TextEditingController();

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: selectedDate.value);
    if (date != null) {
      selectedDate.value = date;
      selectedDateController.text = DateFormat('dd MMM, yyyy').format(selectedDate.value!);
    }
  }

  Future<void> pickTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      selectedTime.value = timeOfDay;
      selectedTimeController.text = formatTimeOfDay(selectedTime.value!);
    }
  }

  void changePickupLocation(String newModel) {
    selectedPickupLocation.value = newModel;
  }
}
