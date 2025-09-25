import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../drawer/controller/drawer_controller.dart';
import '../../../drawer/model/drawer_model.dart';
import '../../model/vehicle_model.dart';

class MyVehicleExploreCarTile extends StatelessWidget {
  const MyVehicleExploreCarTile({super.key, required this.myVehicleModel});
  final VehicleModel myVehicleModel;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      contentPadding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.assetsSvgCars).paddingOnly(bottom: 40),
          const TitleText(
            text: 'Add more vehicles',
            textSize: 24,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w700,
          ),
          const SmallText(
            text: 'Explore more cars and add them to your garage',
            textAlign: TextAlign.center,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),

          // Button
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: AppColors.primaryColor,
                elevation: 0.0,
                fixedSize: const Size(140, 40),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              onPressed: () {
                final AppDrawerController controller = Get.find();
                controller.drawerItemOnTap(
                    DrawerModel(
                        asset: Assets.assetsSvgCarSearch,
                        title: 'Explore cars',
                        drawerItemEnum: DrawerItemEnum.exploreCar),
                    closeDrawer: false);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonText(text: 'Explore Cars '),
                  Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: AppColors.buttonTextColor,
                  )
                ],
              )),
        ],
      ),
    ).paddingSymmetric(horizontal: 10);
  }
}
