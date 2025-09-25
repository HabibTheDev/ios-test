import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_color.dart';
import '../widgets/text_widget.dart';

class UnOrderList extends StatelessWidget {
  const UnOrderList({super.key, required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items
          .map(
            (item) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 2,
                  backgroundColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(right: 6, top: 6),
                Expanded(
                    child: SmallText(
                  text: item,
                  textColor: AppColors.lightSecondaryTextColor,
                ))
              ],
            ).paddingOnly(bottom: 8),
          )
          .toList(),
    );
  }
}
