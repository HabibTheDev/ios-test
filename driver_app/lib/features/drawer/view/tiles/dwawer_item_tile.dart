import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/drawer_controller.dart';
import '../../model/drawer_model.dart';

class DrawerItemTile extends StatelessWidget {
  const DrawerItemTile({super.key, required this.model});
  final DrawerModel model;

  @override
  Widget build(BuildContext context) {
    final AppDrawerController controller = Get.find();
    return Obx(() => InkWell(
          onTap: () {
            controller.drawerItemOnTap(model);
          },
          child: Ink(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: model.drawerItemEnum ==
                        controller.selectedItem.value.drawerItemEnum
                    ? AppColors.lightBgColor
                    : null,
                borderRadius: const BorderRadius.all(Radius.circular(6))),
            child: Row(
              children: [
                SvgPicture.asset(
                  model.asset,
                  colorFilter: ColorFilter.mode(
                      model.drawerItemEnum ==
                              controller.selectedItem.value.drawerItemEnum
                          ? AppColors.primaryColor
                          : AppColors.lightTextFieldHintColor,
                      BlendMode.srcIn),
                ),
                const WidthBox(width: 8),
                BodyText(
                  text: ' ${model.title}',
                  textColor: model.drawerItemEnum ==
                          controller.selectedItem.value.drawerItemEnum
                      ? AppColors.primaryColor
                      : AppColors.lightTextFieldHintColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ));
  }
}
