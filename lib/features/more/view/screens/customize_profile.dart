part of 'widget_imports.dart';

class CustomizeProfile extends StatelessWidget {
  const CustomizeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomizeProfileController controller = Get.find();
    final ProfileController profileController = Get.find();
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: const Icon(Icons.person, size: 20, color: AppColors.lightAppBarIconColor),
          title: ButtonText(text: '${locale?.customizeProfile}'),
          titleSpacing: 0.0,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const CenterLoadingWidget()
              : _bodyUI(controller, profileController, context, locale),
        ),
        bottomNavigationBar: SafeArea(child: _bottomWidget(controller, locale)),
      ),
    );
  }

  Widget _bodyUI(
    CustomizeProfileController controller,
    ProfileController profileController,
    BuildContext context,
    AppLocalizations? locale,
  ) =>
      ListRefreshIndicator(
        onRefresh: () async => await controller.onInit(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // User image
              Center(
                child: Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primaryColor.withAlpha(51),
                        child: controller.selectedProfilePhoto.value != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                child: Image.file(
                                  controller.selectedProfilePhoto.value!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ProfilePhotoWidget(
                                imageUrl: profileController.employeeModel.value?.photo,
                                imageSize: 100,
                                iconSize: 60,
                              ),
                      ),
                    ),
                    Positioned(
                      right: 0.0,
                      bottom: 10.0,
                      child: InkWell(
                        onTap: () => controller.getPhotoFromGallery(),
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: AppColors.lightCardColor,
                          child: Icon(Icons.camera_alt, color: AppColors.primaryColor, size: 18),
                        ),
                      ),
                    )
                  ],
                ).paddingOnly(bottom: 32),
              ),

              //Full Name
              TextFormFieldWithLabel(
                controller: controller.fullName,
                labelText: '${locale?.fullName}',
                hintText: '${locale?.enterFullName}',
                required: true,
                textInputType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
              ).paddingOnly(bottom: 16),

              //Phone
              BodyText(
                text: '${locale?.phone}',
                fontWeight: FontWeight.w600,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 4),
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.lightTextFieldFillColor, borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(
                      () => CountryCodeDropdown(
                          items: controller.countries,
                          selectedValue: controller.selectedCountryCode.value,
                          hintText: '${locale?.select}',
                          onChanged: (value) {
                            controller.changeCountryCode(value);
                          }),
                    ),
                    //Divider
                    Container(
                      height: 24,
                      width: 1,
                      decoration: BoxDecoration(color: Colors.grey.withAlpha(127)),
                    ).paddingOnly(left: 8),
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: controller.phone,
                        hintText: '${locale?.phoneNumber}',
                        required: true,
                        textInputType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 16),

              //Gender
              BodyText(
                text: '${locale?.gender} (${locale?.optional.toLowerCase()})',
                fontWeight: FontWeight.w600,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 4),
              Obx(
                () => BasicDropdown(
                  items: AppList.genderList,
                  selectedValue: controller.selectedGender.value,
                  hintText: '${locale?.select}',
                  dropdownWidth: MediaQuery.of(context).size.width * .9,
                  onChanged: (value) => controller.changeGender(value),
                ),
              ).paddingOnly(bottom: 16),

              //Date of birth (optional)
              TextFormFieldWithLabel(
                controller: controller.dobController,
                labelText: '${locale?.dateOfBirth} (${locale?.optional.toLowerCase()})',
                hintText: '${locale?.enterDateOfBirth}',
                suffixIcon: Icons.calendar_month,
                suffixColor: AppColors.lightTextColor,
                readOnly: true,
                onTap: () => controller.pickDobOnTap(context),
                textInputType: TextInputType.visiblePassword,
              ).paddingOnly(bottom: 16),

              //Address (optional)
              TextFormFieldWithLabel(
                controller: controller.address,
                labelText: '${locale?.address} (${locale?.optional.toLowerCase()})',
                hintText: '${locale?.enterAddress}',
                textInputType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.sentences,
              ).paddingOnly(bottom: 16),
            ],
          ),
        ),
      );

  Widget _bottomWidget(CustomizeProfileController controller, AppLocalizations? locale) => Obx(() => SolidTextButton(
          isLoading: controller.updateLoading.value,
          onTap: () => controller.updateProfile(locale),
          buttonText: '${locale?.save}')
      .paddingSymmetric(horizontal: 16));
}
