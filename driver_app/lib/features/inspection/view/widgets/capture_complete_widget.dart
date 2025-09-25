import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../shared/widgets/text_widget.dart';

class CaptureCompleteWidget extends StatelessWidget {
  const CaptureCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.verified, color: Colors.white, size: 30).paddingOnly(bottom: 8),
        const TitleText(
          text: 'Capture completed',
          textColor: Colors.white,
        ),
      ],
    );
  }
}
