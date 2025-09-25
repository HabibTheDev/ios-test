part of 'widget_imports.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.find();
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: const Icon(Icons.key, size: 20, color: AppColors.lightAppBarIconColor),
          title: ButtonText(text: '${locale?.change} ${locale?.password.toLowerCase()}'),
          titleSpacing: 0.0,
          actions: [IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: controller.changePassFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Password
                    TextFormFieldWithLabel(
                      controller: controller.currentPassword,
                      focusNode: controller.currentPasswordFocusNode,
                      labelText: '${locale?.currentPassword}',
                      hintText: '${locale?.enterPassword}',
                      required: true,
                      obscure: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 20,
                    ).paddingOnly(bottom: 16),

                    // New Password
                    TextFormFieldWithLabel(
                      controller: controller.newPassword,
                      hintText: '${locale?.enterPassword}',
                      labelText: '${locale?.newPassword}',
                      required: true,
                      obscure: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 20,
                    ).paddingOnly(bottom: 16),

                    // Re-enter New Password
                    TextFormFieldWithLabel(
                      controller: controller.reEnterNewPassword,
                      hintText: '${locale?.enterPassword}',
                      labelText: '${locale?.reEnterPassword}',
                      required: true,
                      obscure: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 20,
                    ).paddingOnly(bottom: 20),

                    // Change Button
                    Obx(
                      () => SolidTextButton(
                          onTap: () => controller.changePassword(locale),
                          isLoading: controller.changePassLoading.value,
                          buttonText: '${locale?.change}'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
