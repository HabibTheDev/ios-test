import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../model/incident_time_slot_model.dart';

class BasicInquiryController extends GetxController {
  final TextEditingController damageDetailsController = TextEditingController();
  final Rxn<IncidentTimeSlotModel> selectedTimeSlot = Rxn();

  final TextEditingController dateController = TextEditingController();
  final Rxn<DateTime> selectedDate = Rxn();

  // UI functions
  void changeDamageSlot(IncidentTimeSlotModel model) {
    selectedTimeSlot(model);
  }

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: selectedDate.value);
    if (date != null) {
      selectedDate.value = date;
      dateController.text = DateFormat('dd MMM, yyyy').format(selectedDate.value!);
    }
  }
}
