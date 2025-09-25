import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/tiles/label_tile.dart';
import '../../../explore_car/view/widgets/catalogue_radio_list_widget.dart';
import '../../controller/contracts_controller.dart';

class ContractFilterWidget extends StatelessWidget {
  const ContractFilterWidget({super.key, required this.controller});
  final ContractsController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter List
                Obx(
                  () => controller.selectedCarFilterList.length > 1
                      ? Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 10,
                          runSpacing: 10,
                          runAlignment: WrapAlignment.start,
                          children: controller.selectedCarFilterList
                              .map((item) => LabelTile(
                                    label: item,
                                    onTap: () {
                                      if (item == 'Clear all') {
                                        controller.clearCarFilter();
                                      } else {
                                        controller.removeCarFilterItem(item);
                                      }
                                    },
                                  ))
                              .toList(),
                        ).paddingOnly(bottom: 16)
                      : const SizedBox.shrink(),
                ),

                // Catalogues
                ExpandableWidget(
                    isExpanded: true,
                    title: const BodyText(
                      text: 'Catalogues',
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      CatalogueRadioListWidget(
                        catalogues: [],
                        onCatalogueSelected: (value) {
                          debugPrint('Selected category: $value');
                          // controller.addCarFilterItem(value);
                        },
                      )
                    ]),
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
                child: SolidTextButton(
                  buttonText: 'Done',
                  onTap: () {},
                ),
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
