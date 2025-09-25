import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/extensions/string_extension.dart';
import '../../../core/constants/app_string.dart';
import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/media_repo.dart';
import '../../../shared/repository/remote/profile_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../model/country_code_model.dart';
import 'profile_controller.dart';

class CustomizeProfileController extends GetxController {
  final _profileRepo = ServiceLocator.get<ProfileRepo>();

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

    if (profileController.customerModel.value == null) {
      await profileController.fetchEmployeeInfo();
    }

    fullName.text = profileController.customerModel.value?.fullName ?? '';
    phone.text = profileController.customerModel.value?.phone ?? '';
    dobController.text = DateFormat(AppString.readableDateFormat)
        .format(profileController.customerModel.value?.dateOfBirth ?? DateTime.now());
    address.text = profileController.customerModel.value?.address ?? '';
    selectedGender.value = profileController.customerModel.value?.gender?.capitalizeFirstLetter();

    // Fetch countries
    if (countries.isEmpty) {
      await fetchCountries();
      for (var e in countries) {
        if (e.id == profileController.customerModel.value?.country?.id) {
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
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context,
        initialDate: selectedDob.value ?? profileController.customerModel.value?.dateOfBirth ?? DateTime.now());
    if (date != null) {
      selectedDob.value = date;
      dobController.text = DateFormat(AppString.readableDateFormat).format(selectedDob.value!);
    }
  }

  Future<void> getPhotoFromGallery() async {
    selectedProfilePhoto.value = await ServiceLocator.get<MediaRepo>().getImageFromGallery();
  }

  Future<void> fetchCountries() async {
    final result = await _profileRepo.getCountries();
    if (result != null) {
      countries.value = result;
    }
  }

  Future<void> updateProfile() async {
    if (isLoading.value) {
      showToast(AppString.anotherProcessRunning);
      return;
    }
    if (updateLoading.value) {
      showToast(AppString.anotherProcessRunning);
      return;
    }
    updateLoading(true);
    final String? dob = selectedDob.value != null
        ? DateFormat(AppString.queryParamsDateFormat).format(selectedDob.value!)
        : profileController.customerModel.value!.dateOfBirth != null
            ? DateFormat(AppString.queryParamsDateFormat).format(profileController.customerModel.value!.dateOfBirth!)
            : null;
    final body = {
      'fullName': fullName.text.trim(),
      'phone': phone.text.trim(),
      'address': address.text.trim(),
      'gender': selectedGender.value,
      'countryId': selectedCountryCode.value!.id,
      'dateOfBirth': dob,
    };
    debugPrint('Body: $body');

    final result = await _profileRepo.updateCustomerProfile(
      filePath: selectedProfilePhoto.value?.path,
      body: body,
    );
    if (result) {
      await profileController.fetchEmployeeInfo();
      Get.back();
    }
    updateLoading(false);
  }
}
