import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import 'loading_widget.dart';
import 'text_widget.dart';

class SolidTextButton extends StatelessWidget {
  const SolidTextButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.splashColor,
  });
  final Function() onTap;
  final String buttonText;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final WidgetStateProperty<Color?>? splashColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        elevation: 0.0,
        fixedSize: Size(width ?? double.infinity, height ?? 40),
        minimumSize: Size(width ?? double.infinity, height ?? 40),
        shape: RoundedRectangleBorder(
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(6)),
        ),
      ).copyWith(
          overlayColor: splashColor ??
              WidgetStateProperty.all(Colors.white.withOpacity(0.5))),
      onPressed: onTap,
      child: isLoading
          ? const ThreeBounceIndicator(
              color: Colors.white,
              size: 24,
            )
          : ButtonText(text: buttonText),
    );
  }
}
