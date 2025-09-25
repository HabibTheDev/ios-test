import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class ActiveContractTile extends StatelessWidget {
  const ActiveContractTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouterPaths.contractDetails),
      child: BorderCardWidget(
        contentPadding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: 'Luxury fleet',
                      textSize: 18,
                    ),
                    SmallText(
                      text: '02 May 2023 -',
                      textColor: AppColors.lightSecondaryTextColor,
                    )
                  ],
                )),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                        color: AppColors.lightSecondaryTextColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                    children: [
                      TextSpan(
                          text: '400',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColors.lightTextColor)),
                      TextSpan(
                          text: r'$',
                          style: TextStyle(color: AppColors.lightTextColor)),
                      TextSpan(text: ' /m'),
                    ],
                  ),
                )
              ],
            ).paddingOnly(bottom: 10),
            const Row(
              children: [
                Expanded(
                  child: CarInfoTile(
                      leading: Icon(
                        Icons.account_circle_outlined,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      titleKey: 'Drivers',
                      titleValue: '03'),
                ),
                Expanded(
                  child: CarInfoTile(
                      leading: Icon(
                        Icons.warning_amber_rounded,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      titleKey: 'Issues',
                      titleValue: '02'),
                ),
              ],
            ).paddingOnly(bottom: 8),
            const CarInfoTile(
                    leading: Icon(
                      Icons.book_outlined,
                      color: AppColors.primaryColor,
                      size: 18,
                    ),
                    titleKey: 'Extras',
                    titleValue: '04')
                .paddingOnly(bottom: 10),
            const CarInfoTile(titleKey: 'Contract ID', titleValue: '#ID20034'),
          ],
        ),
      ),
    );
  }
}
