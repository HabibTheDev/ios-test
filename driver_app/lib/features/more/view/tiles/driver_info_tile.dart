import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class DriverInfoTile extends StatelessWidget {
  const DriverInfoTile({super.key, required this.verified});
  final bool verified;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          child: Icon(
            Icons.account_circle,
            color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
            size: 40,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const TitleText(text: 'Danish Ali'),
                  if (verified)
                    const Icon(
                      Icons.verified,
                      color: Colors.green,
                      size: 14,
                    ).paddingOnly(left: 8),
                  if (verified)
                    const SmallText(
                      text: 'verified',
                      textColor: Colors.green,
                    ).paddingOnly(left: 4)
                ],
              ),
              const SmallText(
                text: 'danish@email.com',
                textColor: AppColors.lightSecondaryTextColor,
              ),
            ],
          ).paddingOnly(left: 8),
        )
      ],
    );
  }
}
