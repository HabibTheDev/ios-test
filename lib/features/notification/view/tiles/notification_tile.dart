import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../shared/extensions/date_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/notification_controller.dart';
import '../../model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.model, required this.index, required this.controller});
  final NotificationController controller;
  final Notifications model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.find();
    final locale = AppLocalizations.of(context);
    return InkWell(
      onTap: () => controller.handleNotificationTap(notification: model, index: index),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (context) {
                controller.deleteNotification(id: model.id ?? 0, index: index, locale: locale);
              },
              backgroundColor: AppColors.deleteBgColor,
              foregroundColor: AppColors.errorColor,
              icon: Icons.delete_outline,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: model.read == true ? null : AppColors.lightBgColor,
            border: Border.all(color: AppColors.lightBorderColor),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: model.title ?? '${locale?.notAvailable}',
                fontWeight: model.read == false ? FontWeight.w600 : null,
              ),
              SmallText(text: model.createdAt.timeAgo(), textColor: AppColors.lightSecondaryTextColor),
            ],
          ),
        ),
      ),
    );
  }
}
