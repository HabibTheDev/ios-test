import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../shared/widgets/basic_dropdown.dart';
import '../../../../shared/widgets/country_code_dropdown.dart';
import '../../../../shared/widgets/list_refresh_ndicator.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/profile_photo_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/customize_profile_controller.dart';
import '../../controller/profile_controller.dart';

class CustomizeProfile extends StatelessWidget {
  const CustomizeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomizeProfileController controller = Get.find();
    final ProfileController profileController = Get.find();
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: const Icon(Icons.person,
            size: 20, color: AppColors.lightAppBarIconColor),
        title: const ButtonText(text: 'Customize Profile'),
        titleSpacing: 0.0,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const CenterLoadingWidget()
            : _bodyUI(controller, profileController, context),
      ),
      bottomNavigationBar: SafeArea(child: _bottomWidget(controller)),
    );
  }

  Widget _bodyUI(CustomizeProfileController controller,
          ProfileController profileController, BuildContext context) =>
      ListRefreshIndicator(
        onRefresh: () async => await controller.onInit(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // User image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.2),
                      child: controller.selectedProfilePhoto.value != null
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.file(
                                controller.selectedProfilePhoto.value!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ProfilePhotoWidget(
                              imageUrl:
                                  profileController.customerModel.value?.photo,
                              imageSize: 100,
                              iconSize: 60,
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
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                        ),
                      ),
                    )
                  ],
                ).paddingOnly(bottom: 32),
              ),

              // Full Name
              TextFormFieldWithLabel(
                controller: controller.fullName,
                labelText: 'Full name',
                hintText: 'Enter full name',
                required: true,
                textInputType: TextInputType.visiblePassword,
              ).paddingOnly(bottom: 16),

              // Phone
              const BodyText(
                text: 'Phone',
                fontWeight: FontWeight.w600,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 4),
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.lightTextFieldFillColor,
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CountryCodeDropdown(
                      items: controller.countries,
                      selectedValue: controller.selectedCountryCode.value,
                      hintText: 'Select',
                      onChanged: (value) {
                        controller.changeCountryCode(value);
                      },
                    ),
                    // Divider
                    Container(
                      height: 24,
                      width: 1,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                    ).paddingOnly(left: 8),
                    Expanded(
                      child: TextFormFieldWidget(
                        controller: controller.phone,
                        hintText: AppString.phoneNumber,
                        required: true,
                        textInputType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 16),

              // Gender
              const BodyText(
                text: 'Gender (optional)',
                fontWeight: FontWeight.w600,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 4),

              BasicDropdown(
                items: AppList.genderList,
                selectedValue: controller.selectedGender.value,
                hintText: 'Select',
                width: MediaQuery.of(context).size.width * .9,
                dropdownWidth: MediaQuery.of(context).size.width * .9,
                onChanged: (value) {
                  controller.changeGender(value);
                },
              ).paddingOnly(bottom: 16),

              // Date of birth (optional)
              TextFormFieldWithLabel(
                controller: controller.dobController,
                labelText: 'Date of birth',
                hintText: 'Enter date of birth',
                suffixIcon: Icons.calendar_month,
                suffixColor: AppColors.lightTextColor,
                readOnly: true,
                onTap: () {
                  controller.pickDobOnTap(context);
                },
              ).paddingOnly(bottom: 16),

              // Address (optional)
              TextFormFieldWithLabel(
                controller: controller.address,
                labelText: 'Address (optional)',
                hintText: 'Enter address',
                textInputType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.sentences,
              ).paddingOnly(bottom: 16),
            ],
          ),
        ),
      );

  Widget _bottomWidget(CustomizeProfileController controller) =>
      Obx(() => SolidTextButton(
              isLoading: controller.updateLoading.value,
              onTap: () => controller.updateProfile(),
              buttonText: 'Save')
          .paddingSymmetric(horizontal: 16));
}
