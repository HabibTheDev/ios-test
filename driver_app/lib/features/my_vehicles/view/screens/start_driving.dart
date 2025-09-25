import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/start_driving_controller.dart';
import '../widgets/driving_contract_widget.dart';
import '../widgets/driving_controller_widget.dart';
import '../widgets/image_stack_widget.dart';

class StartDriving extends StatefulWidget {
  const StartDriving({super.key});

  @override
  State<StartDriving> createState() => _StartDrivingState();
}

class _StartDrivingState extends State<StartDriving> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: AppList.startDrivingTabBarList.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final StartDrivingController controller = Get.find();
    return Obx(() => Scaffold(
          backgroundColor: AppColors.lightCardColor,
          appBar: AppBar(
            backgroundColor: controller.lockedUnlockedColor(),
            leading: const AppBarLeadingIcon(),
            titleSpacing: -16,
            centerTitle: false,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: AppString.carBrandImageUrl,
                  height: 40,
                  width: 32,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const ImagePlaceholderWidget(height: 32),
                  errorWidget: (context, url, error) => const ImagePlaceholderWidget(height: 32),
                ).paddingOnly(right: 4),
                const Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonText(
                      text: 'Ferrari',
                      textSize: 16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ExtraSmallText(
                      text: 'Infinite QA 2023',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textColor: AppColors.lightAppBarIconColor,
                    )
                  ],
                )),

                // Driver list
                Expanded(
                    child: ImageStack(
                  onTap: () => Get.toNamed(RouterPaths.additionalDrivers),
                  imageUrls: AppList.dummyImageList,
                  borderColor: controller.lockedUnlockedColor(),
                ).paddingOnly(right: 32))
              ],
            ),

            // Tab Bar
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(44),
                child: TabBar(
                  controller: tabController,
                  tabs: AppList.startDrivingTabBarList
                      .map((item) => Tab(
                              child: SmallText(
                            text: item,
                            textColor: AppColors.lightAppBarIconColor,
                            fontWeight: FontWeight.w600,
                          )))
                      .toList(),
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerHeight: 0,
                  indicatorColor: AppColors.lightAppBarIconColor,
                  dividerColor: Colors.transparent,
                ).paddingOnly(bottom: 4, left: 16, right: 16)),
          ),
          body: SafeArea(
            child: TabBarView(
              controller: tabController,
              children: const [DrivingControllerWidget(), DrivingContractWidget()],
            ).paddingOnly(bottom: 16),
          ),
        ));
  }
}
