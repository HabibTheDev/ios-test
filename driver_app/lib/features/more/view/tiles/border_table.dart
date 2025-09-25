import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class BorderedTable extends StatelessWidget {
  final List<List<String>> rows;

  const BorderedTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Table(
      border:
          TableBorder.all(color: AppColors.lightTextFieldFillColor, width: 1),
      children: rows.map((row) {
        return TableRow(
          children: row.asMap().entries.map((entry) {
            int columnIndex = entry.key;
            String cell = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.lightTextFieldFillColor, width: 0.5),
              ),
              child: SmallText(
                text: cell,
                textColor:
                    columnIndex == 0 ? AppColors.lightSecondaryTextColor : null,
                fontWeight:
                    columnIndex == 1 ? FontWeight.w600 : FontWeight.normal,
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
