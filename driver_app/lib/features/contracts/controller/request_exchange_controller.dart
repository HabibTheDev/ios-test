import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/utils.dart';

import '../model/vehicle_handover_radio_model.dart';

class RequestExchangeController extends GetxController {
  // Handover method
  final Rxn<VehicleHandoverRadioModel> selectedHandoverMethod = Rxn();
  // Date
  final Rxn<DateTime> handoverDate = Rxn();
  final TextEditingController handoverDateController = TextEditingController();
  // Time
  final Rxn<TimeOfDay> handoverTime = Rxn();
  final TextEditingController handoverTimeController = TextEditingController();

  final RxnString selectedPickupLocation = RxnString();
  final TextEditingController deliveryAddressController = TextEditingController();

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: handoverDate.value);
    if (date != null) {
      handoverDate.value = date;
      handoverDateController.text = DateFormat('dd MMM, yyyy').format(handoverDate.value!);
    }
  }

  Future<void> pickTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      handoverTime.value = timeOfDay;
      handoverTimeController.text = formatTimeOfDay(handoverTime.value!);
    }
  }

  void changePickupLocation(String newModel) {
    selectedPickupLocation.value = newModel;
  }
}
