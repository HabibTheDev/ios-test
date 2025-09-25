import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../controller/login_controller.dart';
import '../model/jwt_token_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthRepo _authRepo = ServiceLocator.get<AuthRepo>();
  late LoginController controller;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    controller = Get.find();

    WidgetsBinding.instance.addPostFrameCallback((value) async {
      final locale = AppLocalizations.of(context);

      final bool isBiometricCapable = await _authRepo.isBiometricCapable();
      if (isBiometricCapable) {
        final JwtTokenModel? jwtTokenModel = await _authRepo.decodeJwtToken();
        if (jwtTokenModel?.isBiometric == true) {
          controller.biometricLogin(locale);
        } else {
          controller.emailFocusNode.requestFocus();
        }
      } else {
        controller.emailFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations? locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeightBox(height: 40),

                    // Logo
                    const LogoPrimary(height: 24, width: 136).paddingOnly(bottom: 60),

                    // Login message
                    TitleText(text: '${locale?.login}').paddingOnly(bottom: 4),
                    SmallText(
                      text: '${locale?.loginMgs}',
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),

                    // Email
                    TextFormFieldWidget(
                      controller: controller.email,
                      focusNode: controller.emailFocusNode,
                      hintText: '${locale?.email}',
                      required: true,
                      textInputType: TextInputType.emailAddress,
                    ).paddingOnly(bottom: 10),

                    // Password
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.lightTextFieldFillColor,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextFormFieldWidget(
                              controller: controller.password,
                              hintText: '${locale?.password}',
                              required: true,
                              obscure: true,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            height: 24,
                            width: 1,
                            color: Colors.grey.withAlpha(127),
                          ),
                          InkWell(
                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                            onTap: () => controller.biometricLogin(locale),
                            child: SvgPicture.asset(
                              Assets.assetsSvgScanFaceId,
                            ).paddingSymmetric(horizontal: 10, vertical: 12),
                          ).paddingOnly(left: 8),
                        ],
                      ),
                    ).paddingOnly(bottom: 20),

                    // Login Button
                    Obx(
                      () => SolidTextButton(
                        onTap: () => controller.login(locale),
                        isLoading: controller.functionLoading.value,
                        buttonText: '${locale?.login}',
                      ),
                    ).paddingOnly(bottom: 22),

                    // Forgot password
                    InkWell(
                      onTap: () => Get.toNamed(RouterPaths.forgotPassword),
                      child: BodyText(
                        text: '${locale?.forgotPassword}',
                        textColor: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ).paddingOnly(bottom: 30),
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
