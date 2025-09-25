import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/pagination_widget.dart';
import '../../../../shared/widgets/search_field.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/explore_car_controller.dart';
import '../../controller/filter_car_controller.dart';
import '../tiles/explore_car_tile.dart';
import '../widgets/car_filter_widget.dart';

class FilterCar extends StatefulWidget {
  const FilterCar({super.key});

  @override
  State<FilterCar> createState() => _FilterCarState();
}

class _FilterCarState extends State<FilterCar> {
  late FilterCarController controller;
  late ExploreCarController exploreCarController;
  late CarFilterType? filterType;
  late int? id;
  late String? make;
  late String searchKey = '';

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    exploreCarController = Get.find();
    filterType = Get.arguments?[ArgumentsKey.carFilterType];
    make = Get.arguments?[ArgumentsKey.make];
    id = Get.arguments?[ArgumentsKey.id];

    // Prevent initial fetch for search
    if (filterType != CarFilterType.search) {
      controller.fetchVehicles(id: id, carFilterType: filterType, make: make);
    }
    debugPrint('filterType: $filterType\nId: $id');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: _appBarByFilterType(),
        body: controller.isLoading.value ? const CenterLoadingWidget() : SafeArea(child: _bodyUI()),
      ),
    );
  }

  Widget _bodyUI() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            color: AppColors.lightBgColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                filterType == CarFilterType.search
                    ? Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 20, color: AppColors.lightTextColor),
                            TitleText(text: ' ${controller.filterCarList.length} items found', textSize: 16),
                          ],
                        ),
                      )
                    : const Expanded(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleText(text: 'Choose a car'),
                          SmallText(
                            text: 'Pick your preferred car from the available list',
                            textColor: AppColors.lightSecondaryTextColor,
                          ),
                        ],
                      )),
                IconButton(
                  onPressed: () {
                    modalBottomSheet(
                      context: context,
                      title: 'Filter vehicles',
                      child: CarFilterWidget(
                        controller: controller,
                        exploreCarController: exploreCarController,
                        showCatalogue: filterType != CarFilterType.catalogue,
                        showLocation: filterType != CarFilterType.location,
                        showMake: filterType != CarFilterType.brand,
                        carFilterType: filterType,
                        id: id,
                        make: make,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    size: 20,
                    color: AppColors.lightSecondaryTextColor,
                  ),
                ),
              ],
            ),
          ).paddingOnly(left: 16, top: 8, bottom: 16),

          // Car List
          Expanded(
            child: PaginationWidget(
              onRefresh: () =>
                  controller.onRefresh(carFilterType: filterType, id: id, make: make, searchKey: searchKey),
              onLoading: () =>
                  controller.onLoading(carFilterType: filterType, id: id, make: make, searchKey: searchKey),
              refreshController: controller.refreshController,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                itemCount: controller.filterCarList.length,
                separatorBuilder: (context, index) => const HeightBox(height: 10),
                itemBuilder: (context, index) => ExploreCarTile(
                  carFilterType: filterType ?? CarFilterType.search,
                  model: controller.filterCarList[index],
                ),
              ),
            ),
          )
        ],
      );

  AppBar _appBarByFilterType() => filterType == CarFilterType.brand
      ? AppBar(
          leading: const AppBarLeadingIcon(),
          titleSpacing: -16,
          centerTitle: false,
          title: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            NetworkImageWidget(
              imageUrl: controller.filterCarModel.value?.data?.data?.brandLogo,
              height: 40,
              width: 32,
              fit: BoxFit.cover,
            ).paddingOnly(right: 4),
            Expanded(
                child: ButtonText(
              text: controller.filterCarModel.value?.data?.data?.make ?? 'N/A',
              textSize: 16,
            ))
          ]),
        )
      : filterType == CarFilterType.location
          ? AppBar(
              leading: const AppBarLeadingIcon(),
              titleSpacing: -8,
              centerTitle: false,
              title: ButtonText(
                text: controller.filterCarModel.value?.data?.data?.city ?? 'N/A',
                textSize: 16,
              ),
            )
          : filterType == CarFilterType.catalogue
              ? AppBar(
                  leading: const AppBarLeadingIcon(),
                  titleSpacing: -8,
                  centerTitle: false,
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ButtonText(
                              text:
                                  '${controller.filterCarModel.value?.data?.data?.catalogueName ?? 'N/A'} (${controller.filterCarList.length} cars)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textSize: 16,
                            ),
                            SmallText(
                              text: controller.filterCarModel.value?.data?.data?.description ?? 'N/A',
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.lightAppBarIconColor,
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'from ',
                          style: const TextStyle(
                              color: AppColors.lightAppBarIconColor, fontSize: 12, fontWeight: FontWeight.w400),
                          children: [
                            TextSpan(
                                text: '${controller.filterCarModel.value?.data?.data?.subscriptionCharge ?? 0.0}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                            const TextSpan(text: '\$'),
                            const TextSpan(text: ' /m'),
                          ],
                        ),
                      ).paddingOnly(right: 24)
                    ],
                  ),
                )
              : AppBar(
                  leading: const AppBarLeadingIcon(),
                  titleSpacing: -8,
                  title: SearchField(
                    onChanged: (value) {
                      searchKey = value;
                      controller.onSearch(carFilterType: filterType, searchKey: searchKey);
                    },
                  ),
                  centerTitle: false,
                  actions: const [WidthBox(width: 24)],
                );
}
