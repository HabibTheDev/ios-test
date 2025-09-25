import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../tiles/info_with_icon_tile.dart';

class OtherInfo extends StatelessWidget {
  const OtherInfo({super.key, required this.gender, required this.dateOfBirth});
  final String? gender;
  final String? dateOfBirth;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyText(
            text: 'Other Info',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.bold,
          ).paddingOnly(bottom: 16),
          InfoWithIconTile(leadingIcon: Icons.person, title: gender ?? 'N/A')
              .paddingOnly(bottom: 8),
          InfoWithIconTile(
              leadingIcon: Icons.cake, title: dateOfBirth ?? 'N/A'),
        ],
      ),
    );
  }
}
