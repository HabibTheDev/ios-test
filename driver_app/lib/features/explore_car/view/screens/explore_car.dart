import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/services/remote/explore_cars_service.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/list_refresh_ndicator.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/explore_car_controller.dart';
import '../tiles/car_catalogue_tile.dart';
import '../tiles/horizontal_list_item_tile.dart';
import '../widgets/explore_header_widget.dart';
import '../widgets/horizontal_list_widget.dart';

class ExploreCar extends StatelessWidget {
  const ExploreCar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreCarController>(
      init: ExploreCarController(ExploreCarsService()),
      autoRemove: false,
      builder: (controller) {
        return Obx(
          () => controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI(controller),
        );
      },
    );
  }

  Widget _bodyUI(ExploreCarController controller) => ListRefreshIndicator(
        onRefresh: () async => await controller.onInit(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            //Header
            const ExploreHeaderWidget().paddingOnly(bottom: 32),

            // Brand
            HorizontalListWidget(
              headerText: 'Our top makes',
              listViewWidget: ListView.separated(
                  padding: const EdgeInsets.only(right: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => HorizontalListItemTile(
                        title: 'Ferrari',
                        imageUrl: AppString.carImageUrl,
                        onTap: () {
                          Get.toNamed(
                            RouterPaths.filterCar,
                            arguments: {
                              ArgumentsKey.make: 'toyota',
                              ArgumentsKey.carFilterType: CarFilterType.brand,
                            },
                          );
                        },
                        logoWidget: CachedNetworkImage(
                          imageUrl: AppString.carBrandImageUrl,
                          height: 32,
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) => const ImagePlaceholderWidget(
                            height: 32,
                            width: 32,
                          ),
                          errorWidget: (context, url, error) => const ImagePlaceholderWidget(
                            height: 32,
                            width: 32,
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => const WidthBox(width: 10),
                  itemCount: 10),
            ).paddingOnly(bottom: 32),

            // Location
            HorizontalListWidget(
              headerText: 'Select your location',
              listViewWidget: ListView.separated(
                padding: const EdgeInsets.only(right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: controller.cityList.length,
                separatorBuilder: (context, index) => const WidthBox(width: 10),
                itemBuilder: (context, index) => HorizontalListItemTile(
                  title: controller.cityList[index].city,
                  imageUrl: AppString.locationLogoUrl,
                  onTap: () {
                    Get.toNamed(
                      RouterPaths.filterCar,
                      arguments: {
                        ArgumentsKey.id: controller.cityList[index].id,
                        ArgumentsKey.carFilterType: CarFilterType.location,
                      },
                    );
                  },
                ),
              ),
            ).paddingOnly(bottom: 32),

            // Catalogues
            const SmallText(
              text: 'Our catalogues',
              textColor: AppColors.lightSecondaryTextColor,
              fontWeight: FontWeight.w700,
            ).paddingOnly(bottom: 10, left: 16, right: 16),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemBuilder: (context, index) => CarCatalogueTile(
                      model: controller.catalogueCarList[index],
                      onTap: () {
                        Get.toNamed(
                          RouterPaths.filterCar,
                          arguments: {
                            ArgumentsKey.carFilterType: CarFilterType.catalogue,
                            ArgumentsKey.id: controller.catalogueCarList[index].id,
                          },
                        );
                      },
                    ),
                separatorBuilder: (context, index) => const HeightBox(height: 10),
                itemCount: controller.catalogueCarList.length),
          ],
        ),
      );
}
