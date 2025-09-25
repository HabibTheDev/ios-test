import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../shared/extensions/date_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/notification_controller.dart';
import '../../model/notification_model.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.model, required this.index, required this.controller});
  final NotificationController controller;
  final Notifications model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.handleNotificationTap(notification: model, index: index),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                controller.deleteNotification(id: model.id ?? 0, index: index);
              },
              backgroundColor: AppColors.errorColor.withOpacity(0.15),
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
              Row(
                children: [
                  Expanded(
                      child: BodyText(
                    text: model.title ?? 'N/A',
                    fontWeight: model.read == false ? FontWeight.w600 : null,
                  )),
                  SmallText(text: model.createdAt!.timeAgo(), textColor: AppColors.lightSecondaryTextColor)
                ],
              ),
              SmallText(text: model.message ?? 'N/A', textColor: AppColors.lightSecondaryTextColor)
            ],
          ),
        ),
      ),
    );
  }
}
