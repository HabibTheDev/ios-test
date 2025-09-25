import 'package:flutter/material.dart';
import 'package:get/utils.dart';

import '../../core/constants/app_color.dart';
import '../../core/l10n/app_localizations.dart';
import 'widget_imports.dart';

class ViewOrCaptureImageWidget extends StatelessWidget {
  const ViewOrCaptureImageWidget({super.key, required this.onView, required this.onUpload});
  final Function() onView;
  final Function() onUpload;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return SafeArea(
      child: Container(
        height: 200,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.lightCardColor, borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleText(text: '${locale?.chooseAnOption}', fontWeight: FontWeight.w700).paddingOnly(bottom: 20),
            SolidButton(
              onTap: onUpload,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonText(text: '${locale?.uploadNew} '),
                  Icon(Icons.upload_sharp, color: AppColors.buttonTextColor),
                ],
              ),
            ).paddingOnly(bottom: 6),

            OutlineTextButton(onTap: onView, buttonText: '${locale?.viewImage}'),
          ],
        ),
      ),
    );
  }
}
