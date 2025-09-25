// part of 'widget_imports.dart';

// class Signup extends StatelessWidget {
//   const Signup({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final SignupController controller = Get.find();
//     return Scaffold(
//       backgroundColor: AppColors.lightCardColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 HeightBox(height: 40.h),
//                 //Logo
//                 const LogoPrimary(
//                   height: 24,
//                   width: 136,
//                 ),
//                 HeightBox(height: 60.h),

//                 //Signup Message
//                 const TitleText(text: AppString.signup),
//                 HeightBox(height: 4.h),
//                 const SmallText(
//                   text: 'Sign up and set up your password',
//                   textColor: AppColors.lightSecondaryTextColor,
//                 ),
//                 HeightBox(height: 20.h),

//                 //Name
//                 TextFormFieldWidget(
//                   controller: controller.name,
//                   hintText: AppString.name,
//                   required: true,
//                   textInputType: TextInputType.name,
//                   textCapitalization: TextCapitalization.words,
//                 ),
//                 HeightBox(height: 10.h),

//                 //Phone
//                 Container(
//                   decoration: const BoxDecoration(
//                       color: AppColors.lightTextFieldFillColor,
//                       borderRadius: BorderRadius.all(Radius.circular(6))),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Obx(
//                         () => CountryCodeDropdown(
//                             items: AppList.countryCodeList,
//                             selectedValue: controller.selectedCountryCode.value,
//                             hintText: 'Select',
//                             onChanged: (value) {
//                               controller.changeCountryCode(value);
//                             }),
//                       ),
//                       //Divider
//                       Container(
//                         height: 24,
//                         width: 1,
//                         decoration:
//                             BoxDecoration(color: Colors.grey.withAlpha(127)),
//                       ).paddingOnly(left: 8),
//                       Expanded(
//                         child: TextFormFieldWidget(
//                           controller: controller.phone,
//                           hintText: AppString.phoneNumber,
//                           required: true,
//                           textInputType: TextInputType.phone,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 HeightBox(height: 10.h),

//                 //User ID
//                 TextFormFieldWidget(
//                   controller: controller.userId,
//                   hintText: AppString.userId,
//                   required: true,
//                   textInputType: TextInputType.text,
//                 ),
//                 HeightBox(height: 10.h),

//                 //Password
//                 TextFormFieldWidget(
//                   controller: controller.password,
//                   hintText: AppString.password,
//                   required: true,
//                   obscure: true,
//                   textInputType: TextInputType.visiblePassword,
//                 ),
//                 HeightBox(height: 10.h),

//                 //Re-enter Password
//                 TextFormFieldWidget(
//                   controller: controller.confirmPassword,
//                   hintText: AppString.reEnterPassword,
//                   required: true,
//                   obscure: true,
//                   textInputType: TextInputType.visiblePassword,
//                 ),
//                 HeightBox(height: 20.h),

//                 //Signup Button
//                 SolidTextButton(
//                     onTap: () {
//                       Get.toNamed(RouterPaths.drawer);
//                     },
//                     buttonText: AppString.signup),
//                 HeightBox(height: 30.h),

//                 //Have an account?
//                 RichText(
//                   text: TextSpan(
//                     style: const TextStyle(
//                         color: AppColors.lightTextColor, fontSize: 14),
//                     children: [
//                       const TextSpan(text: 'Have an account? '),
//                       TextSpan(
//                           text: AppString.login,
//                           style: const TextStyle(
//                               color: AppColors.primaryColor,
//                               fontWeight: FontWeight.w600),
//                           recognizer: TapGestureRecognizer()
//                             ..onTap = () {
//                               Get.toNamed(RouterPaths.login);
//                             }),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
