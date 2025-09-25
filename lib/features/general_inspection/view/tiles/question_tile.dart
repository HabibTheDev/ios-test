import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';

class QuestionTile extends StatelessWidget {
  const QuestionTile({
    super.key,
    required this.question,
    required this.serialNo,
    required this.groupValue,
    required this.onChanged,
  });
  final String question;
  final int serialNo;
  final int groupValue;
  final Function(int? newValue) onChanged;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BorderCardWidget(
      contentPadding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BodyText(text: '$serialNo. $question', fontWeight: FontWeight.w500).paddingOnly(bottom: 8),
          Transform.scale(
            scale: 0.9,
            alignment: Alignment.centerLeft,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: 0,
              groupValue: groupValue,
              visualDensity: VisualDensity.compact,
              title: BodyText(text: '${locale?.yes}', textColor: AppColors.lightSecondaryTextColor),
              onChanged: onChanged,
            ),
          ),
          Transform.scale(
            scale: 0.9,
            alignment: Alignment.centerLeft,
            child: RadioListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: 1,
              groupValue: groupValue,
              title: BodyText(text: '${locale?.no}', textColor: AppColors.lightSecondaryTextColor),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
