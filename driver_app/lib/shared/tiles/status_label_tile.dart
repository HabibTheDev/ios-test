import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/text_widget.dart';

class StatusLabelTile extends StatelessWidget {
  const StatusLabelTile(
      {super.key, required this.status, required this.statusColor});
  final String status;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: statusColor,
          radius: 3,
        ).paddingOnly(right: 4),
        SmallText(
          text: status,
          fontWeight: FontWeight.w600,
          textColor: statusColor,
        )
      ],
    );
  }
}
