import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/remote/profile_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../model/employee_model.dart';

class ProfileController extends GetxController {
  ProfileController({required this.profileRepo});
  final ProfileRepo profileRepo;

  final Rxn<EmployeeModel> employeeModel = Rxn();
  final RxBool licenseLoading = false.obs;
  final RxBool passportLoading = false.obs;

  Future<void> fetchEmployeeInfo() async {
    employeeModel.value = await profileRepo.getEmployeeDetails();
  }

  void updateLicenseOnTap(AppLocalizations? locale) {
    if (Get.key.currentState != null) {
      showDialog(
        barrierDismissible: false,
        context: Get.key.currentState!.context,
        builder: (_) => Obx(
          () => AppAlertDialog(
            iconData: Icons.update,
            title: '${locale?.updateLicense}',
            message: '${locale?.updateLicenseMgs}',
            primaryButtonText: '${locale?.receiveLink}',
            buttonLoading: licenseLoading.value,
            buttonAction: () async {
              if (employeeModel.value?.email != null) {
                licenseLoading(true);
                final result = await profileRepo.getLicenseVerificationLink(email: employeeModel.value!.email!);
                if (result) Get.back();
                licenseLoading(false);
              } else {
                showToast('${locale?.emailAddressNotFound}');
                Get.back();
              }
            },
          ),
        ),
      );
    }
  }

  void updatePassportOnTap(AppLocalizations? locale) {
    if (Get.key.currentState != null) {
      showDialog(
        barrierDismissible: false,
        context: Get.key.currentState!.context,
        builder: (_) => Obx(
          () => AppAlertDialog(
            iconData: Icons.update,
            title: '${locale?.updatePassport}',
            message: '${locale?.updatePassportMgs}',
            primaryButtonText: '${locale?.receiveLink}',
            buttonLoading: passportLoading.value,
            buttonAction: () async {
              if (employeeModel.value?.email != null) {
                passportLoading(true);
                final result = await profileRepo.getPassportVerificationLink(email: employeeModel.value!.email!);
                if (result) Get.back();
                passportLoading(false);
              } else {
                showToast('${locale?.emailAddressNotFound}');
                Get.back();
              }
            },
          ),
        ),
      );
    }
  }
}
