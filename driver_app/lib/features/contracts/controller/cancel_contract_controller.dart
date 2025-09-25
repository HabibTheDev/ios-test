import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/utils.dart';

import '../model/return_method_radio_model.dart';

class CancelContractController extends GetxController {
  RxnString selectedCancelationReason = RxnString();
  // Return method
  final Rxn<ReturnMethodRadioModel> selectedReturnMethod = Rxn();
  // Date
  final Rxn<DateTime> returnDate = Rxn();
  final TextEditingController returnDateController = TextEditingController();
  // Time
  final Rxn<TimeOfDay> returnTime = Rxn();
  final TextEditingController returnTimeController = TextEditingController();

  final RxnString selectedPickupLocation = RxnString();
  final TextEditingController retrieveAddressController = TextEditingController();

  void changeCancelationReason(String value) {
    selectedCancelationReason(value);
  }

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: returnDate.value);
    if (date != null) {
      returnDate.value = date;
      returnDateController.text = DateFormat('dd MMM, yyyy').format(returnDate.value!);
    }
  }

  Future<void> pickTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      returnTime.value = timeOfDay;
      returnTimeController.text = formatTimeOfDay(returnTime.value!);
    }
  }

  void changePickupLocation(String newModel) {
    selectedPickupLocation.value = newModel;
  }
}
