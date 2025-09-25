import 'package:driver_app/shared/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';

class DocumentTile extends StatelessWidget {
  const DocumentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            alignment: Alignment.center,
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.07),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: const Icon(
              Icons.picture_as_pdf,
              color: AppColors.primaryColor,
            ),
          ),
          const Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(text: 'Police_report.pdf', fontWeight: FontWeight.w700),
              SmallText(
                text: '2.6 MB',
                textColor: AppColors.lightSecondaryTextColor,
              )
            ],
          ))
        ],
      ),
    );
  }
}
