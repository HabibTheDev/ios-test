// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/constants/app_list.dart';
// import '../../../shared/data_sources/remote/services/auth_service.dart';
// import '../model/country_code_model.dart';

// class SignupController extends GetxController {
//   SignupController(this._authService);
//   final AuthService _authService;

//   final TextEditingController name = TextEditingController();
//   final TextEditingController phone = TextEditingController();
//   final TextEditingController userId = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final TextEditingController confirmPassword = TextEditingController();

//   final Rx<CountryCodeModel> selectedCountryCode =
//       AppList.countryCodeList.first.obs;

//   void changeCountryCode(CountryCodeModel newModel) {
//     selectedCountryCode.value = newModel;
//   }
// }
