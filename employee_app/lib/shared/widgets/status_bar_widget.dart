part of 'widget_imports.dart';

class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({super.key, required this.child, this.statusBarColor, this.statusBarIconBrightness});
  final Widget child;
  final Color? statusBarColor;
  final Brightness? statusBarIconBrightness;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.primaryColor,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
      ),
      child: child,
    );
  }
}
