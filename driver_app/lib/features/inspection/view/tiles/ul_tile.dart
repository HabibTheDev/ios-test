import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class UlTile extends StatelessWidget {
  const UlTile({super.key, required this.title, this.titleSize, this.pointerRadius});
  final String title;
  final double? titleSize;
  final double? pointerRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: pointerRadius ?? 4,
          backgroundColor: AppColors.lightTextFieldHintColor,
        ).paddingOnly(right: pointerRadius != null ? 4 : 10, top: 4),
        Expanded(
          child: BodyText(
            text: title,
            textColor: AppColors.lightSecondaryTextColor,
            textSize: titleSize,
          ),
        )
      ],
    );
    // return Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     const CircleAvatar(
    //       radius: 4,
    //       backgroundColor: AppColors.lightTextFieldHintColor,
    //     ).paddingOnly(right: 10, top: 4),
    //     Expanded(
    //       child: BodyText(
    //         text: title,
    //         textColor: AppColors.lightSecondaryTextColor,
    //       ),
    //     )
    //   ],
    // );
  }
}
