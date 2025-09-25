part of 'widget_imports.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final ProfileController profileController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: ButtonText(text: '${locale?.myProfile}', textColor: AppColors.lightAppBarIconColor),
        titleSpacing: 0.0,
      ),
      body: ListRefreshIndicator(
        onRefresh: () async => await profileController.fetchEmployeeInfo(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // User Info
              Obx(
                () => UserInfoWidget(
                  name: profileController.employeeModel.value?.fullName,
                  imageUrl: profileController.employeeModel.value?.photo,
                  phone: profileController.employeeModel.value?.phone,
                  email: profileController.employeeModel.value?.email,
                  address: profileController.employeeModel.value?.address,
                  verified: profileController.employeeModel.value?.verified ?? false,
                ),
              ).paddingOnly(bottom: 10),

              // Other Info
              Obx(
                () => OtherInfo(
                  gender: profileController.employeeModel.value?.gender,
                  dateOfBirth: readableDate(
                    profileController.employeeModel.value?.dateOfBirth ?? DateTime.now(),
                    pattern: AppString.readableDateFormat,
                  ),
                ),
              ).paddingOnly(bottom: 10),

              // License Info
              if (profileController.employeeModel.value?.license?.licenseNumber != null &&
                  profileController.employeeModel.value?.verified == true)
                LicenseInfoWidget(license: profileController.employeeModel.value?.license).paddingOnly(bottom: 10),

              // Passport Info
              if (profileController.employeeModel.value?.passport?.passportNo != null &&
                  profileController.employeeModel.value?.verified == true)
                PassportInfoWidget(passport: profileController.employeeModel.value?.passport).paddingOnly(bottom: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(
          onTap: () => Get.toNamed(RouterPaths.customizeProfile),
          buttonText: '${locale?.customizeProfile}',
        ).paddingSymmetric(horizontal: 20),
      ),
    );
  }
}
