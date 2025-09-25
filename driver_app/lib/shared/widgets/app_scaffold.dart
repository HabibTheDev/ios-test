import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/router/router_paths.dart';
import '../../features/drawer/controller/drawer_controller.dart';
import '../../features/drawer/view/app_drawer.dart';
import '../../core/constants/app_color.dart';
import '../../features/notification/controller/notification_controller.dart';
import 'app_alert_dialog.dart';
import 'status_bar_widget.dart';
import 'text_widget.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key, required this.body, this.resizeToAvoidBottomInset});
  final Widget body;
  final bool? resizeToAvoidBottomInset;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    final AppDrawerController controller = Get.find();
    final NotificationController notificationController = Get.find();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (Navigator.of(context).canPop()) {
          Navigator.pop(context);
        } else {
          // ignore: use_build_context_synchronously
          final shouldExit = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => AppAlertDialog(
              title: 'Exit app?',
              message: 'If you proceed, the app will close.',
              primaryButtonText: 'Exit',
              themeColor: AppColors.warningColor,
              buttonAction: () {
                // SystemNavigator.pop();
                exit(0);
              },
            ),
          );
          return shouldExit ?? false;
        }
      },
      child: StatusBarWidget(
        child: Scaffold(
          key: controller.drawerScaffoldKey,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset ?? false,
          endDrawer: AppDrawer(controller: controller),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            title: SvgPicture.asset(
              Assets.assetsSvgFleetboxWhite,
              height: 20,
              width: 115,
            ),
            actions: [
              Obx(
                () => IconButton(
                  onPressed: () => Get.toNamed(RouterPaths.notification),
                  icon: Badge(
                    label: notificationController.unreadNotification.value != 0
                        ? SmallText(text: notificationController.unreadNotification.toString())
                        : null,
                    backgroundColor: AppColors.lightAppBarIconColor,
                    child: const Icon(
                      Icons.notifications_none,
                      color: AppColors.lightAppBarIconColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.drawerScaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: AppColors.lightAppBarIconColor,
                  )),
            ],
          ),
          body: widget.body,
        ),
      ),
    );
  }
}
