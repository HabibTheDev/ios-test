import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';

class OverallInfoTile extends StatelessWidget {
  const OverallInfoTile({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SmallText(text: title, textColor: AppColors.lightSecondaryTextColor, fontWeight: FontWeight.w600),
        Expanded(child: SmallText(text: value, textAlign: TextAlign.end, fontWeight: FontWeight.w700))
      ],
    );
  }
}
