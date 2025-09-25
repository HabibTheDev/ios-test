part of 'widget_imports.dart';

class SolidButton extends StatelessWidget {
  const SolidButton({
    super.key,
    required this.onTap,
    required this.child,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius,
    this.splashColor,
  });
  final Function() onTap;
  final Widget child;
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
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(6)),
        ),
      ).copyWith(overlayColor: splashColor ?? WidgetStateProperty.all(Colors.white.withAlpha(127))),
      onPressed: onTap,
      child: isLoading ? const CenterLoadingWidget(color: Colors.white) : child,
    );
  }
}
