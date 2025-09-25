import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_string.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/repository/remote/profile_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../more/model/country_code_model.dart';
import '../model/token_model.dart';

class SignUpController extends GetxController {
  final _authService = ServiceLocator.get<AuthRepo>();

  final RxBool isLoading = true.obs;
  final RxBool functionLoading = false.obs;
  final GlobalKey<FormState> signUpFormKey = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController userId = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  final Rxn<CountryCodeModel> selectedCountryCode = Rxn();
  RxList<CountryCodeModel> countries = <CountryCodeModel>[].obs;

  void changeCountryCode(CountryCodeModel newModel) {
    selectedCountryCode.value = newModel;
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    await fetchCountries();
    isLoading(false);
  }

  Future<void> fetchCountries() async {
    final result = await ServiceLocator.get<ProfileRepo>().getCountries();
    if (result != null) {
      countries.value = result;
      selectedCountryCode.value = countries.first;
    }
  }

  Future<void> signUp() async {
    if (functionLoading.value) {
      showToast(AppString.anotherProcessRunning);
      return;
    }
    if (!signUpFormKey.currentState!.validate()) {
      return;
    }
    if (selectedCountryCode.value == null) {
      showToast('Select country code');
      return;
    }
    if (password.text != confirmPassword.text) {
      showToast('Password doesn\'t match');
      return;
    }
    functionLoading(true);
    await _authService
        .signUp(
            userId: userId.text.trim(),
            fullName: name.text.trim(),
            phone: phone.text.trim(),
            countryId: selectedCountryCode.value!.id!,
            password: password.text)
        .then(
      (TokenModel? model) async {
        if (model != null) {
          await ServiceLocator.get<LocalStorageRepo>()
              .saveAccessToken(token: model.accessToken)
              .then((value) => Get.offAllNamed(RouterPaths.drawer));
        }
      },
    );
    functionLoading(false);
  }
}
