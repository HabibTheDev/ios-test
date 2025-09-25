import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';
import '../widgets/text_widget.dart';

class InformationTile extends StatelessWidget {
  const InformationTile(
      {super.key,
      required this.keyText,
      required this.title,
      this.subtitle,
      this.titleFontWeight,
      this.titleFontSize});
  final String keyText;
  final String title;
  final List<String>? subtitle;
  final FontWeight? titleFontWeight;
  final double? titleFontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: SmallText(
            text: '$keyText:',
            textColor: AppColors.lightTextFieldHintColor,
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text: title,
                fontWeight: titleFontWeight ?? FontWeight.w600,
                textSize: titleFontSize,
              ),
              if (subtitle != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: subtitle!
                      .map((item) => SmallText(
                            text: item,
                            textColor: AppColors.lightTextFieldHintColor,
                          ))
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
