import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/services/remote/profile_service.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/widgets/app_alert_dialog.dart';
import '../model/customer_model.dart';

class ProfileController extends GetxController {
  ProfileController(this._profileService);
  final ProfileService _profileService;
  final Rxn<CustomerModel> customerModel = Rxn();

  void updateLicenseOnTap() {
    if (Get.key.currentState != null) {
      showDialog(
        barrierDismissible: false,
        context: Get.key.currentState!.context,
        builder: (_) => AppAlertDialog(
          iconData: Icons.update,
          title: 'Update license',
          message:
              'You will receive a verification link to verify and update your new license.',
          primaryButtonText: 'Receive link',
          buttonAction: () {
            Get.back();
          },
        ),
      );
    } else {
      showToast('Context not found!');
    }
  }

  void updatePassportOnTap() {
    if (Get.key.currentState != null) {
      showDialog(
        barrierDismissible: false,
        context: Get.key.currentState!.context,
        builder: (_) => AppAlertDialog(
          iconData: Icons.update,
          title: 'Update passport',
          message:
              'You will receive a verification link to verify and update your new passport.',
          primaryButtonText: 'Receive link',
          buttonAction: () {
            Get.back();
          },
        ),
      );
    } else {
      showToast('Context not found!');
    }
  }

  Future<void> fetchEmployeeInfo() async {
    customerModel.value = await _profileService.getCustomerDetails();
  }
}
