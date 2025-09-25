import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';

class ReportInfoTable extends StatelessWidget {
  final Widget header;
  final List<List<String>> rows;

  const ReportInfoTable({super.key, required this.rows, required this.header});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: AppColors.lightCurrentUserChatColor, width: 1),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: rows.map((row) {
        return TableRow(
          children: row.asMap().entries.map((entry) {
            int columnIndex = entry.key;
            String cell = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightTextFieldFillColor, width: 0.5),
              ),
              child: SmallText(
                text: cell,
                textColor: columnIndex == 0 ? AppColors.lightSecondaryTextColor : null,
                fontWeight: columnIndex == 1 ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
