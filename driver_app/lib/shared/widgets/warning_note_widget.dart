import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_color.dart';
import 'card_widget.dart';
import 'text_widget.dart';

class WarningNoteWidget extends StatelessWidget {
  const WarningNoteWidget({super.key, this.warningMessage, this.child});
  final String? warningMessage;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      showShadow: false,
      contentPadding: const EdgeInsets.all(12),
      backgroundColor: AppColors.lightNoteBgColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.info, color: AppColors.darkGreenColor, size: 16)
              .paddingOnly(right: 4),
          Expanded(
            child: warningMessage != null
                ? SmallText(text: warningMessage ?? 'N/A')
                : child ?? const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
