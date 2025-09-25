import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../widgets/text_widget.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      this.leadingText,
      this.title,
      this.subtitle,
      this.trailingText,
      this.leadingColor,
      this.titleColor,
      this.trailingColor,
      this.contentPadding,
      this.titleFontWeight,
      this.trailingFontWeight,
      this.titleFontSize,
      this.trailingFontSize,
      this.leadingFlex = 1,
      this.titleFlex = 5,
      this.trailingFlex = 2,
      this.trailingTextAlign});
  final String? leadingText;
  final String? title;
  final String? subtitle;
  final String? trailingText;
  final Color? leadingColor;
  final Color? titleColor;
  final Color? trailingColor;
  final FontWeight? titleFontWeight;
  final FontWeight? trailingFontWeight;
  final double? titleFontSize;
  final double? trailingFontSize;
  final EdgeInsetsGeometry? contentPadding;
  final int leadingFlex;
  final int titleFlex;
  final int trailingFlex;
  final TextAlign? trailingTextAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: leadingFlex,
            child: leadingText != null
                ? SmallText(
                    text: leadingText!,
                    textColor: leadingColor,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.start,
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            flex: titleFlex,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                title != null
                    ? SmallText(
                        text: title!,
                        textColor: titleColor,
                        fontWeight: titleFontWeight ?? FontWeight.w500,
                        textSize: titleFontSize,
                      )
                    : const SizedBox.shrink(),
                subtitle != null
                    ? SmallText(
                        text: subtitle!,
                        textColor: AppColors.lightSecondaryTextColor,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Expanded(
            flex: trailingFlex,
            child: trailingText != null
                ? SmallText(
                    text: trailingText!,
                    textColor: trailingColor,
                    textAlign: trailingTextAlign ?? TextAlign.end,
                    fontWeight: trailingFontWeight,
                    textSize: trailingFontSize,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
