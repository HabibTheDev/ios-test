import 'package:flutter/material.dart';

class NormalCard extends StatelessWidget {
  const NormalCard(
      {super.key,
      required this.child,
      this.contentPadding,
      this.height,
      this.width,
      this.borderRadius = 6,
      this.backgroundColor});
  final Widget child;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: contentPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
