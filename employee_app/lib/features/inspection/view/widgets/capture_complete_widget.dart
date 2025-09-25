import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../shared/widgets/widget_imports.dart';

class CaptureCompleteWidget extends StatelessWidget {
  const CaptureCompleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.verified, color: Colors.white, size: 30).paddingOnly(bottom: 8),
        TitleText(text: '${AppLocalizations.of(context)?.captureCompleted}', textColor: Colors.white),
      ],
    );
  }
}
