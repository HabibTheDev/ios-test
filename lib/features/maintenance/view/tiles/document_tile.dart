import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';

class DocumentTile extends StatelessWidget {
  const DocumentTile({super.key, required this.fileName, required this.fileSizeInMB, required this.onClose});
  final String fileName;
  final double fileSizeInMB;
  final Function() onClose;

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            alignment: Alignment.center,
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withAlpha(18),
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
            ),
            child: const Icon(Icons.description, color: AppColors.primaryColor),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BodyText(text: fileName, fontWeight: FontWeight.w700),
                SmallText(
                  text: '${fileSizeInMB.toStringAsFixed(2)} MB',
                  textColor: AppColors.lightSecondaryTextColor,
                )
              ],
            ),
          ),
          IconButton(
              onPressed: onClose,
              icon: const Icon(
                Icons.close,
                color: AppColors.lightSecondaryTextColor,
                size: 18,
              ))
        ],
      ),
    );
  }
}
