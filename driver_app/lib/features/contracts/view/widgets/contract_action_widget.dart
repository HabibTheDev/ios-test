import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/normal_card.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../more/controller/feedback_controller.dart';

class ContractActionWidget extends StatelessWidget {
  const ContractActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NormalCard(
          child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: AppList.contractActionList.length,
        separatorBuilder: (context, index) => const HeightBox(height: 22),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.pop(context);
              Get.toNamed(RouterPaths.requestMaintenance);
            }
            if (index == 1) {
              Navigator.pop(context);
              Get.toNamed(RouterPaths.carPickRequestExchange);
            }
            if (index == 2) {
              Navigator.pop(context);
              Get.toNamed(RouterPaths.upgradePlan);
            }
            if (index == 3) {
              Navigator.pop(context);
              Get.put(FeedbackController());
              Get.toNamed(RouterPaths.giveFeedback);
            }
            if (index == 4) {
              Navigator.pop(context);
              Get.toNamed(RouterPaths.cancelContract);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                AppList.contractActionList[index].icon,
                color: AppList.contractActionList[index].iconColor,
                size: 24,
              ).paddingOnly(right: 10),
              BodyText(
                text: AppList.contractActionList[index].title ?? 'N/A',
                textColor: AppColors.lightSecondaryTextColor,
              )
            ],
          ),
        ),
      )),
    );
  }
}
