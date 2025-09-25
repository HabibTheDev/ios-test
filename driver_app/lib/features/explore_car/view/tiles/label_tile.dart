import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class LabelTile extends StatelessWidget {
  const LabelTile({super.key, required this.label, required this.onTap});
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return label != 'Clear all'
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightTextColor, width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            child: Wrap(
              alignment: WrapAlignment.start,
              children: [
                SmallText(text: '$label '),
                InkWell(
                  onTap: onTap,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.lightTextColor,
                    size: 16,
                  ),
                )
              ],
            ),
          )
        : InkWell(
            onTap: onTap,
            child: BodyText(
              text: label,
              textAlign: TextAlign.center,
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ).paddingOnly(right: 12, top: 6, bottom: 6),
          );
  }
}
