import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class EmployeeInfo extends StatelessWidget {
  const EmployeeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              child: Icon(
                Icons.account_circle,
                color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
                size: 30,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleText(
                    text: 'Danish Ali',
                    textSize: 16,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: AppColors.lightSecondaryTextColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                            text: 'Office No: ',
                            style: TextStyle(color: AppColors.primaryColor)),
                        TextSpan(text: ' 6478776559 | '),
                        TextSpan(text: '3214'),
                      ],
                    ),
                  )
                ],
              ).paddingOnly(left: 8),
            )
          ],
        ).paddingOnly(bottom: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.phone_in_talk_rounded,
              color: AppColors.primaryColor,
              size: 16,
            ),
            SmallText(
              text: ' (219)555-0114',
              textColor: AppColors.lightSecondaryTextColor,
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.email,
              color: AppColors.primaryColor,
              size: 16,
            ),
            SmallText(
              text: ' mukesh@email.com',
              textColor: AppColors.lightSecondaryTextColor,
            )
          ],
        )
      ],
    );
  }
}
