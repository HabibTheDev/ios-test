import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/drawer_controller.dart';
import '../tiles/drawer_item_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.controller});
  final AppDrawerController controller;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Drawer(
      width: MediaQuery.of(context).size.width * .7,
      child: SafeArea(
        child: Column(
          children: [
            const HeightBox(height: 40),
            const LogoPrimary(height: 20, width: 115),
            const HeightBox(height: 80),
            Expanded(
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: AppList.drawerItemList.length,
                itemBuilder: (context, index) => DrawerItemTile(model: AppList.drawerItemList[index]),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? const CenterLoadingWidget()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NetworkImageWidget(
                          imageUrl: controller.brandModel.value?.logo,
                          fit: BoxFit.cover,
                          height: 24,
                          width: 24,
                        ).paddingOnly(right: 6),
                        BodyText(
                          text: controller.brandModel.value?.brandName ?? '${locale?.notAvailable}',
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
            ).paddingOnly(bottom: 20),
          ],
        ).paddingSymmetric(horizontal: 12),
      ),
    );
  }
}
