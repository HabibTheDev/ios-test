import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/constants/app_list.dart';
import '../../../core/constants/app_string.dart';
import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/media_repo.dart';
import '../../../shared/repository/remote/profile_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../model/country_code_model.dart';
import 'profile_controller.dart';

class CustomizeProfileController extends GetxController {
  CustomizeProfileController({required this.profileRepo, required this.dateTimeRepo, required this.mediaRepo});
  final ProfileRepo profileRepo;
  final DateTimeRepo dateTimeRepo;
  final MediaRepo mediaRepo;

  // Variables
  final RxBool isLoading = true.obs;
  final RxBool updateLoading = false.obs;
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController address = TextEditingController();

  final Rxn<DateTime> selectedDob = Rxn();
  final Rxn<String> selectedGender = Rxn();
  late Rxn<CountryCodeModel> selectedCountryCode = Rxn();
  final Rxn<File> selectedProfilePhoto = Rxn();
  final RxList<CountryCodeModel> countries = <CountryCodeModel>[].obs;

  late ProfileController profileController;

  @override
  Future<void> onInit() async {
    super.onInit();
    profileController = Get.find();

    if (profileController.employeeModel.value == null) {
      await profileController.fetchEmployeeInfo();
    }

    fullName.text = profileController.employeeModel.value?.fullName ?? '';
    phone.text = profileController.employeeModel.value?.phone ?? '';
    dobController.text = DateFormat(
      AppString.readableDateFormat,
    ).format(profileController.employeeModel.value?.dateOfBirth ?? DateTime.now());
    address.text = profileController.employeeModel.value?.address ?? '';
    final String? gender = profileController.employeeModel.value?.gender;
    selectedGender.value = gender != null && gender.isNotEmpty ? gender : AppList.genderList.first;

    // Fetch countries
    if (countries.isEmpty) {
      await fetchCountries();
      for (var e in countries) {
        if (e.id == profileController.employeeModel.value?.country?.id) {
          selectedCountryCode.value = e;
          break;
        }
      }
    }
    isLoading(false);
  }

  void changeCountryCode(CountryCodeModel newModel) {
    selectedCountryCode.value = newModel;
  }

  void changeGender(String value) {
    selectedGender.value = value;
  }

  Future<void> pickDobOnTap(BuildContext context) async {
    final date = await dateTimeRepo.iOSDatePicker(
      context,
      initialDate: selectedDob.value ?? profileController.employeeModel.value?.dateOfBirth ?? DateTime.now(),
    );
    if (date != null) {
      selectedDob.value = date;
      dobController.text = DateFormat(AppString.readableDateFormat).format(selectedDob.value!);
    }
  }

  Future<void> getPhotoFromGallery() async {
    selectedProfilePhoto.value = await mediaRepo.getImageFromGallery();
  }

  Future<void> fetchCountries() async {
    final result = await profileRepo.getCountries();
    if (result != null) {
      countries.value = result;
    }
  }

  Future<void> updateProfile(AppLocalizations? locale) async {
    if (isLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (updateLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (selectedCountryCode.value?.id == null) {
      showToast('${locale?.selectCountryCode}');
      return;
    }

    updateLoading(true);
    final String? dob = selectedDob.value != null
        ? DateFormat(AppString.queryParamsDateFormat).format(selectedDob.value!)
        : profileController.employeeModel.value!.dateOfBirth != null
        ? DateFormat(AppString.queryParamsDateFormat).format(profileController.employeeModel.value!.dateOfBirth!)
        : null;
    final body = {
      'fullName': fullName.text.trim(),
      'phone': phone.text.trim(),
      'address': address.text.trim(),
      'gender': selectedGender.value,
      'countryId': selectedCountryCode.value?.id,
      'dateOfBirth': dob,
    };

    final result = await profileRepo.updateEmployeeProfile(filePath: selectedProfilePhoto.value?.path, body: body);
    if (result) {
      await profileController.fetchEmployeeInfo();
      Get.back();
    }
    updateLoading(false);
  }
}
