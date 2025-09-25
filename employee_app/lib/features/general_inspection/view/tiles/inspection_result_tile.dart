import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import 'add_image_widget.dart';

class InspectionResultTile extends StatelessWidget {
  const InspectionResultTile({
    super.key,
    required this.title,
    required this.radioGroupValue,
    required this.onRadioValueChanged,
    required this.imageList,
    required this.onDeleteImages,
    required this.onAddImage,
    required this.noteController,
  });
  final String title;
  final int radioGroupValue;
  final Function(int? newValue) onRadioValueChanged;
  final List<File> imageList;
  final Function(List<int> selectedImageIndex) onDeleteImages;
  final Function(File imageFile) onAddImage;
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BorderCardWidget(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: ExpandableWidget(
        title: Row(
          children: [
            BodyText(
              text: title,
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ),
            if (radioGroupValue >= 0 && radioGroupValue <= 2)
              Icon(
                Icons.check_circle,
                size: 18,
                color: radioGroupValue == 0
                    ? AppColors.lightProgressColor
                    : radioGroupValue == 1
                        ? AppColors.inProgressColor
                        : radioGroupValue == 2
                            ? AppColors.errorColor
                            : Colors.grey,
              ).paddingOnly(left: 8)
          ],
        ),
        children: [
          Transform.scale(
            scale: 0.9,
            alignment: Alignment.centerLeft,
            child: RadioListTile(
              title: BodyText(text: '${locale?.good}', textColor: AppColors.lightSecondaryTextColor),
              onChanged: onRadioValueChanged,
              value: 0,
              groupValue: radioGroupValue,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            alignment: Alignment.centerLeft,
            child: RadioListTile(
              title: BodyText(text: '${locale?.needServicingSoon}', textColor: AppColors.lightSecondaryTextColor),
              onChanged: onRadioValueChanged,
              value: 1,
              groupValue: radioGroupValue,
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            alignment: Alignment.centerLeft,
            child: RadioListTile(
              title: BodyText(
                text: '${locale?.requiresImmediateAttention}',
                textColor: AppColors.lightSecondaryTextColor,
              ),
              onChanged: onRadioValueChanged,
              value: 2,
              groupValue: radioGroupValue,
              contentPadding: EdgeInsets.zero,
              dense: true,
            ),
          ),
          const AppDivider(height: 40),

          // Images
          SizedBox(
            width: double.infinity,
            child: BodyText(
              text: '${locale?.addImages} (${locale?.optional})',
              textAlign: TextAlign.start,
              fontWeight: FontWeight.bold,
              textColor: AppColors.lightSecondaryTextColor,
            ),
          ).paddingOnly(bottom: 16),
          SizedBox(
            width: double.infinity,
            child: AddImageWidget(imageList: imageList.toList(), onDelete: onDeleteImages, onAddImage: onAddImage),
          ).paddingOnly(bottom: 28),

          // Notes
          TextFormFieldWithLabel(
            controller: noteController,
            labelText: '${locale?.notes} (${locale?.optional})',
            hintText: '${locale?.writeHere}',
            textCapitalization: TextCapitalization.sentences,
            minLine: 5,
            maxLine: 10,
          )
        ],
      ),
    );
  }
}
