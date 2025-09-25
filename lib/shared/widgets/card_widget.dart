part of 'widget_imports.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.child,
    this.contentPadding,
    this.height,
    this.width,
    this.borderRadius = 6,
    this.gradient,
    this.showShadow = true,
    this.bgColor,
  });
  final Widget child;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? width;
  final double borderRadius;
  final Gradient? gradient;
  final bool showShadow;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: contentPadding,
      decoration: BoxDecoration(
        color: gradient == null ? bgColor ?? AppColors.lightCardColor : null,
        gradient: gradient,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        boxShadow: showShadow
            ? [BoxShadow(color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(1, 4))]
            : null,
      ),
      child: child,
    );
  }
}
