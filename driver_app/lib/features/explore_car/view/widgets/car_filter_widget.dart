import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../contracts/view/widgets/basic_radio_list_widget.dart';
import '../../controller/explore_car_controller.dart';
import '../tiles/label_tile.dart';
import '../../controller/filter_car_controller.dart';
import 'catalogue_radio_list_widget.dart';
import 'location_radio_list_widget.dart';

class CarFilterWidget extends StatelessWidget {
  const CarFilterWidget({
    super.key,
    required this.controller,
    required this.exploreCarController,
    this.showMake = false,
    this.showCatalogue = false,
    this.showLocation = false,
    required this.carFilterType,
    this.id,
    this.make,
  });
  final FilterCarController controller;
  final ExploreCarController exploreCarController;
  final bool showMake;
  final bool showCatalogue;
  final bool showLocation;
  final CarFilterType? carFilterType;
  final int? id;
  final String? make;

  @override
  Widget build(BuildContext context) {
    final min = TextEditingController();
    final max = TextEditingController();
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter List
          Obx(
            () => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                // Catalogue
                if (controller.selectedCatalogue.value != null)
                  LabelTile(
                    label: controller.selectedCatalogue.value?.catalogueName ?? 'N/A',
                    onTap: () => controller.removeCatalogueItem(),
                  ),

                // Location
                if (showLocation)
                  if (controller.selectedLocation.value != null)
                    LabelTile(
                      label: controller.selectedLocation.value?.city ?? 'N/A',
                      onTap: () => controller.removeLocationItem(),
                    ),

                // Fuel type
                if (controller.selectedFuelType.value != null)
                  LabelTile(
                    label: controller.selectedFuelType.value ?? 'N/A',
                    onTap: () => controller.removeFuelTypeItem(),
                  ),

                // Transmission
                if (controller.selectedTransmission.value != null)
                  LabelTile(
                    label: controller.selectedTransmission.value ?? 'N/A',
                    onTap: () => controller.removeTransmissionItem(),
                  ),

                // Car style
                if (controller.selectedCarStyle.value != null)
                  LabelTile(
                    label: controller.selectedCarStyle.value ?? 'N/A',
                    onTap: () => controller.removeCarStyleItem(),
                  ),

                // Car make
                if (controller.selectedCarMake.value != null)
                  LabelTile(
                    label: controller.selectedCarMake.value ?? 'N/A',
                    onTap: () => controller.removeCarMakeItem(),
                  ),

                // Min budget
                if (controller.minBudget.value != null)
                  LabelTile(
                    label: 'Min \$${controller.minBudget.value}',
                    onTap: () {
                      controller.removeMinBudget();
                      min.clear();
                    },
                  ),

                // Max budget
                if (controller.maxBudget.value != null)
                  LabelTile(
                    label: 'Max \$${controller.maxBudget.value}',
                    onTap: () {
                      controller.removeMaxBudget();
                      max.clear();
                    },
                  ),

                // Clear all button
                if (controller.showClearAllButton())
                  LabelTile(
                    label: 'Clear all',
                    onTap: () => controller.clearCarFilter(),
                  ),
              ],
            ),
          ).paddingOnly(bottom: 16),

          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Catalogues
                if (showCatalogue)
                  ExpandableWidget(
                    title: const BodyText(
                      text: 'Catalogues',
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      CatalogueRadioListWidget(
                        catalogues: exploreCarController.catalogueCarList,
                        onCatalogueSelected: controller.addCatalogueItem,
                      )
                    ],
                  ),
                const AppDivider(),

                // Locations
                if (showLocation)
                  ExpandableWidget(
                    title: const BodyText(
                      text: 'Locations',
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      LocationRadioListWidget(
                        locations: exploreCarController.cityList,
                        onLocationSelected: controller.addLocationItem,
                      )
                    ],
                  ),
                const AppDivider(),

                // Fuel type
                ExpandableWidget(
                  title: const BodyText(
                    text: 'Fuel type',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    BasicRadioListWidget(
                      items: AppList.fuelTypes,
                      onItemSelected: controller.addFuelTypeItem,
                    )
                  ],
                ),
                const AppDivider(),

                // Transmission
                ExpandableWidget(
                  title: const BodyText(
                    text: 'Transmission',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    BasicRadioListWidget(
                      items: AppList.carTransmissions,
                      onItemSelected: controller.addTransmissionItem,
                    )
                  ],
                ),
                const AppDivider(),

                // Budget
                ExpandableWidget(
                  title: const BodyText(
                    text: 'Budget',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: min,
                            hintText: 'min',
                            textInputType: TextInputType.number,
                            onChanged: controller.changeMinBudget,
                          ),
                        ),
                        const WidthBox(width: 12),
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: max,
                            hintText: 'max',
                            textInputType: TextInputType.number,
                            onChanged: controller.changeMaxBudget,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const AppDivider(),

                // Car style
                ExpandableWidget(
                  title: const BodyText(
                    text: 'Car style',
                    fontWeight: FontWeight.w700,
                  ),
                  children: [
                    BasicRadioListWidget(
                      items: AppList.carStyles,
                      onItemSelected: controller.addCarStyleItem,
                    )
                  ],
                ),
                const AppDivider(),

                // Car make
                if (showMake)
                  ExpandableWidget(
                    title: const BodyText(
                      text: 'Car make',
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      BasicRadioListWidget(
                        items: AppList.carMakes,
                        onItemSelected: controller.addCarMakeItem,
                      )
                    ],
                  ),
              ],
            ),
          )),

          //Button
          Row(
            children: [
              Expanded(
                child: OutlineTextButton(
                  buttonText: 'Cancel',
                  onTap: () => Get.back(),
                ),
              ),
              const WidthBox(width: 8),
              Expanded(
                  child: Obx(
                () => SolidTextButton(
                  buttonText: 'Done',
                  isLoading: controller.isLoading.value,
                  onTap: () async {
                    await controller.fetchFilteredVehicles(carFilterType: carFilterType, id: id, make: make);
                    Get.back();
                  },
                ),
              )),
            ],
          ).paddingOnly(top: 16, bottom: 16)
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
