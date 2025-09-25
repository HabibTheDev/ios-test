import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/text_widget.dart';

class CollisionReportItemTile extends StatelessWidget {
  const CollisionReportItemTile(
      {super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SmallText(
                text: title,
                textColor: AppColors.lightTextFieldHintColor,
              ),
            ),
            Expanded(flex: 3, child: child),
          ],
        ),
        const AppDivider().paddingSymmetric(vertical: 10),
      ],
    );
  }
}
