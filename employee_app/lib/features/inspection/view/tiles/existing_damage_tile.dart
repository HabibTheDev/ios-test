import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/repository/local/media_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/view_or_capture_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inbox/model/message_model.dart';
import '../../controller/damage_customization_controller.dart';
import '../../model/damage_customization_model.dart';

class ExistingDamageTile extends StatelessWidget {
  const ExistingDamageTile({super.key, required this.model, required this.index, required this.controller});
  final DamageCustomizationModel model;
  final DamageCustomizationController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final Size size = MediaQuery.of(context).size;
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.deleteExistingDamage(index: index, locale: locale);
            },
            backgroundColor: AppColors.deleteBgColor,
            foregroundColor: AppColors.errorColor,
            icon: Icons.delete_outline,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
        ],
      ),
      child: CardWidget(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (_) => ViewOrCaptureImageWidget(
                    onView: () {
                      Navigator.of(context).pop();
                      String? url;
                      if (model.imagePath.value != null && model.imagePath.value!.isNotEmpty) {
                        url = model.imagePath.value;
                      } else {
                        url = model.image;
                      }
                      if (url == null) return;
                      Get.toNamed(
                        RouterPaths.filePreview,
                        arguments: {
                          ArgumentsKey.attachments: [Attachment(url: url)],
                        },
                      );
                    },
                    onUpload: () async {
                      Navigator.of(context).pop();
                      final File? file = await ServiceLocator.get<MediaRepo>().getImageFromCamera();
                      if (file != null) {
                        controller.changeExistingDamageImage(index: index, newValue: file.path);
                      }
                    },
                  ),
                );
              },
              child: model.imagePath.value != null && model.imagePath.value!.isNotEmpty
                  ? Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: Image.file(File(model.imagePath.value!), width: 96, height: 96, fit: BoxFit.cover),
                        ),
                        InkWell(
                          onTap: () => controller.deleteExistingDamageImagePath(index: index),
                          child: Icon(Icons.cancel, color: Colors.white),
                        ),
                      ],
                    )
                  : NetworkImageWidget(
                      borderRadius: 6,
                      imageUrl: model.image,
                      width: 96,
                      height: 96,
                    ).paddingOnly(right: 10),
            ),

            Expanded(
              child: Column(
                children: [
                  BasicDropdown(
                    items: AppList.damageTypeList,
                    selectedValue: model.type.value,
                    hintText: locale?.selectDamageType ?? 'Select',
                    buttonHeight: 38,
                    dropdownWidth: size.width * 0.6,
                    onChanged: (String newValue) {
                      controller.changeExistingDamageType(index: index, newValue: newValue);
                    },
                  ).paddingOnly(bottom: 6),

                  BasicDropdown(
                    items: AppList.damageSeverityList,
                    selectedValue: model.severity.value,
                    hintText: locale?.selectDamageSeverity ?? 'Select',
                    buttonHeight: 38,
                    dropdownWidth: size.width * 0.6,
                    onChanged: (String newValue) {
                      controller.changeExistingDamageSeverity(index: index, newValue: newValue);
                    },
                  ).paddingOnly(bottom: 6),

                  BasicDropdown(
                    items: AppList.recommendationList,
                    selectedValue: model.recommendation.value,
                    hintText: locale?.selectRecommendation ?? 'Select',
                    buttonHeight: 38,
                    dropdownWidth: size.width * 0.6,
                    onChanged: (String newValue) {
                      controller.changeExistingRecommendation(index: index, newValue: newValue);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
