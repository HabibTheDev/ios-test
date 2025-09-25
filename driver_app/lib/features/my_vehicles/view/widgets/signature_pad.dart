import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/sign_agreement_controller.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key, required this.controller});
  final SignAgreementController controller;

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  // Variables
  Color selectedColor = AppList.signatureColorList.first;
  late SignatureController signatureController;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  void initData() {
    signatureController = SignatureController(
      penStrokeWidth: 2,
      penColor: selectedColor,
      exportBackgroundColor: Colors.transparent,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Draw your signature
        const SmallText(
          text: 'Draw your signature',
          textColor: AppColors.lightSecondaryTextColor,
          fontWeight: FontWeight.w600,
        ).paddingOnly(bottom: 10),

        // Colors bar
        Row(
          children: [
            Expanded(
              child: Row(
                children: AppList.signatureColorList
                    .map((item) => InkWell(
                          onTap: () {
                            selectedColor = item;
                            initData();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 18,
                                width: 18,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: item,
                                ),
                              ),
                              if (item == selectedColor)
                                Container(
                                  height: 25,
                                  width: 25,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5,
                                          color: AppColors.primaryColor)),
                                )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() => signatureController.clear());
              },
              child: const BodyText(
                text: 'Clear',
                textColor: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        const AppDivider(height: 24),
        Expanded(
          child: Signature(
            controller: signatureController,
            backgroundColor: Colors.white,
          ),
        ),
        const AppDivider(height: 20).paddingOnly(bottom: 10),

        //Button
        Row(
          children: [
            Expanded(
              child: OutlineTextButton(
                buttonText: 'Cancel',
                onTap: () => Get.back(),
              ),
            ),
            const WidthBox(width: 8),
            Expanded(
              child: Obx(
                () => SolidTextButton(
                  buttonText: 'Done',
                  isLoading: widget.controller.signatureLoading.value,
                  onTap: () async {
                    widget.controller.saveSignature(
                        signatureController: signatureController);
                  },
                ),
              ),
            ),
          ],
        )
      ],
    ).paddingAll(16);
  }
}
