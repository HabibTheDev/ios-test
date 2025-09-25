import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/repository/local/local_storage_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../../shared/widgets/pagination_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/notification_controller.dart';
import '../tiles/notification_tile.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  void initState() {
    super.initState();
    ServiceLocator.get<LocalStorageRepo>().clearPushPayload();
  }

  @override
  Widget build(BuildContext context) {
    final NotificationController controller = Get.find();
    final locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: ButtonText(text: '${locale?.notifications}'),
        titleSpacing: 0.0,
      ),
      body: Column(
        children: [
          Obx(
            () => HeaderWidget(
              title: '${locale?.allNotifications}',
              backgroundColor: AppColors.lightCardColor,
              titleColor: AppColors.lightSecondaryTextColor,
              trailing: InkWell(
                onTap: () => controller.markAllAsRead(locale),
                child: controller.markAllAsReadLoading.value
                    ? const LoadingWidget()
                    : BodyText(
                        text: '${locale?.markAllAsRead}',
                        textColor: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
              ),
            ),
          ).paddingAll(16),
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const CenterLoadingWidget()
                  : PaginationWidget(
                      onRefresh: controller.onRefresh,
                      onLoading: controller.onLoading,
                      refreshController: controller.refreshController,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 64),
                        itemCount: controller.notificationList.length,
                        itemBuilder: (context, index) => NotificationTile(
                          controller: controller,
                          model: controller.notificationList[index],
                          index: index,
                        ),
                        separatorBuilder: (context, index) => const HeightBox(height: 10),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
