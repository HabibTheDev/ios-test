import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/damage_customization_controller.dart';
import '../../model/inspection_report_model.dart';
import '../tiles/add_new_damage_tile.dart';
import '../tiles/existing_damage_tile.dart';

class DamageCustomization extends StatefulWidget {
  const DamageCustomization({super.key});

  @override
  State<DamageCustomization> createState() => _DamageCustomizationState();
}

class _DamageCustomizationState extends State<DamageCustomization> {
  late DamageCustomizationController controller;
  String? partName;
  String? part;
  int? carId;
  String? reportOverviewId;
  List<PartAreaList>? partAreaList;

  @override
  void initState() {
    controller = Get.find();

    partName = Get.arguments?[ArgumentsKey.partName];
    part = Get.arguments?[ArgumentsKey.part];
    carId = Get.arguments?[ArgumentsKey.carID];
    reportOverviewId = Get.arguments?[ArgumentsKey.reportOverviewId];
    partAreaList = Get.arguments?[ArgumentsKey.partAreaList] ?? [];

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      controller.mapExistingDamageList(reportOverviewId: reportOverviewId, carId: carId, partAreaList: partAreaList);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.processTerminationMgs, RouterPaths.carExteriorReport);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(Assets.assetsSvgCarInfo),
          ),
          title: ButtonText(text: '${locale?.damageCustomization}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () =>
                  screenTerminationWarning(locale, locale?.processTerminationMgs, RouterPaths.carExteriorReport),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            _bodyUI(locale, controller),
            Obx(
              () => controller.isLoading.value
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.black12),
                      child: LoadingWidget(),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          () => controller.isAddedNewDamage.value || controller.isUpdatedCurrentDamage.value
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: SolidTextButton(
                      onTap: () => controller.updateButtonOnTap(locale),
                      buttonText: '${locale?.update}',
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale, DamageCustomizationController controller) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Part name
          Center(child: TitleText(text: partName ?? '${locale?.notFound}').paddingOnly(bottom: 20)),

          // Existing damages
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.existingDamageList.isNotEmpty)
                  ButtonText(
                    text: '${locale?.existingDamages}',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 10),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 16),
                  itemCount: controller.existingDamageList.length,
                  separatorBuilder: (context, index) => HeightBox(height: 10),
                  itemBuilder: (context, index) => ExistingDamageTile(
                    model: controller.existingDamageList[index],
                    index: index,
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),

          // New added damages
          Obx(
            () => controller.newDamageList.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ButtonText(
                        text: '${locale?.newAddedDamages}',
                        textColor: AppColors.lightSecondaryTextColor,
                      ).paddingOnly(bottom: 10),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 16),
                        itemCount: controller.newDamageList.length,
                        separatorBuilder: (context, index) => HeightBox(height: 10),
                        itemBuilder: (context, index) => AddNewDamageTile(
                          model: controller.newDamageList[index],
                          controller: controller,
                          index: index,
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ),

          // Add new damage button
          Center(
            child: OutlineButton(
              onTap: () {
                controller.addNewDamage(reportOverviewId: reportOverviewId, carId: carId, part: part);
              },
              primaryColor: AppColors.primaryColor,
              fixedSize: Size(196, 40),
              minimumSize: Size(196, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: AppColors.primaryColor, size: 18),
                  ButtonText(text: ' ${locale?.addNewDamage}', textColor: AppColors.primaryColor),
                ],
              ),
            ),
          ).paddingOnly(bottom: 20),
        ],
      ),
    );
  }
}
