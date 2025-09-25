import 'package:flutter/material.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';

class StartStopButton extends StatelessWidget {
  const StartStopButton({super.key, required this.startTracking, required this.onTap});
  final bool startTracking;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return SolidButton(
      width: 100,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      backgroundColor: startTracking ? AppColors.warningColor : null,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            startTracking ? Icons.close : Icons.navigation_outlined,
            size: 24,
            color: Colors.white,
          ),
          ButtonText(
            text: startTracking ? ' ${locale?.stop}' : ' ${locale?.start}',
          ),
        ],
      ),
    );
  }
}
