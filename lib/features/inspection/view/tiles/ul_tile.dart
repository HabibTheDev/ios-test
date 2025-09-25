import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';

class UlTile extends StatelessWidget {
  const UlTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(radius: 4, backgroundColor: AppColors.lightTextFieldHintColor)
            .paddingOnly(right: 10, top: 4),
        Expanded(
          child: SmallText(text: title, textColor: AppColors.lightSecondaryTextColor),
        )
      ],
    );
  }
}
