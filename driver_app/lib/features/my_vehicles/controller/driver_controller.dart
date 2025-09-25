import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';

import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/app_alert_dialog.dart';

import '../model/driver_permission_radio_model.dart';

class DriverController extends GetxController {
  Rxn<DriverPermissionRadioModel> selectedPermission = Rxn();

  // Time
  final Rxn<TimeOfDay> startTime = Rxn();
  final Rxn<TimeOfDay> endTime = Rxn();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();

  void changePermission(DriverPermissionRadioModel value) {
    selectedPermission(value);
  }

  Future<void> pickStartTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      startTime.value = timeOfDay;
      startTimeController.text = formatTimeOfDay(startTime.value!);
    }
  }

  Future<void> pickEndTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      endTime.value = timeOfDay;
      endTimeController.text = formatTimeOfDay(endTime.value!);
    }
  }

  Future<void> deleteDriverOnTap() async {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.delete_outline_outlined,
        title: 'Are you sure?',
        message: 'If you proceed, driver will be removed from this car.',
        primaryButtonText: 'Delete',
        themeColor: AppColors.errorColor,
        buttonAction: () async => Get.back(),
      ),
    );
  }
}
