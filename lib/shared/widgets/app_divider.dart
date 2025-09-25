part of 'widget_imports.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.color, this.height, this.thickness});
  final Color? color;
  final double? height;
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(thickness: thickness ?? 0.5, color: color ?? Colors.grey.shade200, height: height ?? 8.0);
  }
}
