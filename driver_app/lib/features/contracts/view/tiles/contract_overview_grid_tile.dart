import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class ContractOverviewGridTile extends StatelessWidget {
  const ContractOverviewGridTile(
      {super.key, required this.title, required this.subTitle});
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
      contentPadding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(
            text: title ?? 'N/A',
            fontWeight: FontWeight.w700,
          ),
          SmallText(
            text: subTitle ?? 'N/A',
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
            textColor: AppColors.lightSecondaryTextColor,
          )
        ],
      ),
    );
  }
}
