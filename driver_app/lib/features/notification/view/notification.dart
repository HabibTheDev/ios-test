import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/widgets/appbar_leading_icon.dart';
import '../../../shared/widgets/header_widget.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/pagination_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/notification_controller.dart';
import 'tiles/notification_tile.dart';

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
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(text: 'Notifications'),
        titleSpacing: 0.0,
      ),
      body: Column(
        children: [
          Obx(
            () => HeaderWidget(
              title: 'All notifications',
              backgroundColor: AppColors.lightCardColor,
              titleColor: AppColors.lightSecondaryTextColor,
              trailing: InkWell(
                onTap: () => controller.markAllAsRead(),
                child: controller.markAllAsReadLoading.value
                    ? const LoadingWidget()
                    : const BodyText(
                        text: 'Mark all as read',
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
