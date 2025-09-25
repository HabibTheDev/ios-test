import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/logo_primary.dart';
import '../../../shared/widgets/network_image_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/drawer_controller.dart';
import 'tiles/dwawer_item_tile.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.controller});
  final AppDrawerController controller;

  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (context, index) => DrawerItemTile(
                  model: AppList.drawerItemList[index],
                ),
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
                        ),
                        BodyText(
                          text: controller.brandModel.value?.brandName ?? 'N/A',
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
            ).paddingOnly(bottom: 20),
          ],
        ).paddingSymmetric(horizontal: 12),
      ),
    );
  }
}
