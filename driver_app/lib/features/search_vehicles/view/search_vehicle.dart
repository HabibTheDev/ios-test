import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/widgets/appbar_leading_icon.dart';
import '../../../shared/widgets/empty_content_widget.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/text_widget.dart';
import '../../../shared/widgets/widthbox.dart';
import '../../my_vehicles/view/tiles/my_vehicle_tile.dart';
import '../controller/search_vehicle_controller.dart';

class SearchVehicle extends StatelessWidget {
  const SearchVehicle({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchVehicleController controller = Get.find();
    final PageController pageController = PageController(viewportFraction: 0.9);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const AppBarLeadingIcon(),
          titleSpacing: -8,
          title: SearchField(
            onChanged: (value) => controller.fetchVehicles(contractId: value),
            hintText: 'Search with contract ID',
          ),
          centerTitle: false,
          actions: const [WidthBox(width: 24)],
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const CenterLoadingWidget()
              : controller.searchKey.value == null || controller.searchKey.value!.isEmpty
                  ? const EmptyContentWidget(
                      title: 'Search your car',
                      subTitle: 'Enter your car band or model to find your specific car',
                      svgAsset: Assets.assetsSvgSearch,
                    )
                  : _bodyUI(context, controller, pageController),
        ));
  }

  Widget _bodyUI(BuildContext context, SearchVehicleController controller, PageController pageController) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            color: AppColors.lightBgColor,
            child: Row(
              children: [
                const Icon(Icons.search, size: 20, color: AppColors.lightTextColor),
                TitleText(text: ' ${controller.searchedVehicles.length} items found', textSize: 16),
              ],
            ),
          ).paddingOnly(left: 16, right: 16, top: 20.h, bottom: 32.h),

          // Vehicles
          Expanded(
              child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            pageSnapping: true,
            itemCount: controller.searchedVehicles.length,
            itemBuilder: (context, index) => MyVehicleTile(vehicle: controller.searchedVehicles[index]),
          )),

          // Swipe instruction
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.swipe,
                color: AppColors.lightSecondaryTextColor,
                size: 16,
              ),
              SmallText(
                text: ' Swipe to change car',
                textColor: AppColors.lightSecondaryTextColor,
              )
            ],
          ).paddingOnly(left: 16, right: 16, top: 32.h, bottom: 44.h)
        ],
      );
}
