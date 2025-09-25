import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/list_refresh_ndicator.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/profile_controller.dart';
import '../../model/payment_method_model.dart';
import '../widgets/license_info_widget.dart';
import '../widgets/other_info.dart';
import '../widgets/passport_info.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/user_info_widget.dart';
import 'package:intl/intl.dart' as intl;

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'My Profile',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
      ),
      body: ListRefreshIndicator(
        onRefresh: () async => await profileController.fetchEmployeeInfo(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              //User Info
              Obx(
                () => UserInfoWidget(
                  name: profileController.customerModel.value?.fullName,
                  imageUrl: profileController.customerModel.value?.photo,
                  phone: profileController.customerModel.value?.phone,
                  email: profileController.customerModel.value?.email,
                  address: profileController.customerModel.value?.address,
                  verified:
                      profileController.customerModel.value?.verified ?? false,
                ),
              ).paddingOnly(bottom: 10),

              //Other Info
              Obx(
                () => OtherInfo(
                  gender: profileController.customerModel.value?.gender,
                  dateOfBirth: intl.DateFormat(AppString.readableDateFormat)
                      .format(
                          profileController.customerModel.value?.dateOfBirth ??
                              DateTime.now()),
                ),
              ).paddingOnly(bottom: 10),

              PaymentMethodWidget(
                header: 'Payment method',
                paymentMethodList: PaymentMethodModel.paymentsList,
                onChanged: (value) {
                  debugPrint('${value.cardNo}');
                },
              ).paddingOnly(bottom: 10),

              //License Info
              LicenseInfoWidget(
                license: profileController.customerModel.value?.license,
              ).paddingOnly(bottom: 10),

              //Passport Info
              PassportInfo(
                passport: profileController.customerModel.value?.passport,
              ).paddingOnly(bottom: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(
                onTap: () => Get.toNamed(RouterPaths.customizeProfile),
                buttonText: 'Customize Profile')
            .paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
