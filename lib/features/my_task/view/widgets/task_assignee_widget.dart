import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/model/single_task/assigned_by_model.dart';
import '../../../../shared/widgets/widget_imports.dart';

class TaskAssigneeWidget extends StatelessWidget {
  const TaskAssigneeWidget({super.key, required this.assignedBy});

  final AssignedBy? assignedBy;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ButtonText(text: '${locale?.assignedBy}', textColor: AppColors.lightSecondaryTextColor),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(RouterPaths.chatWithTaskAssignee, arguments: {ArgumentsKey.assignedBy: assignedBy});
              },
              child: BodyText(text: '${locale?.chat}', textColor: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            Icon(Icons.chevron_right, color: AppColors.primaryColor, size: 20),
          ],
        ),
        HeightBox(height: 10),

        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: assignedBy?.profilePicture == null
              ? Icon(Icons.account_circle, size: 48, color: AppColors.lightCurrentUserChatColor)
              : ProfilePhotoWidget(imageUrl: assignedBy?.profilePicture, imageSize: 50),
          title: BodyText(text: assignedBy?.fullName ?? '${locale?.notAvailable}', fontWeight: FontWeight.w600),
          subtitle: SmallText(
            text: assignedBy?.designation ?? '${locale?.notAvailable}',
            textColor: AppColors.lightSecondaryTextColor,
          ),
        ),
      ],
    );
  }
}
