part of 'widget_imports.dart';

class LogoPrimary extends StatelessWidget {
  const LogoPrimary({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(Assets.assetsSvgFleetblox, height: (height ?? 36), width: (width ?? 207));
  }
}
