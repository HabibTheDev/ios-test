part of '../../features/maintenance/view/widgets/widget_imports.dart';

class CarInfoTile extends StatelessWidget {
  const CarInfoTile({super.key, this.leading, required this.titleKey, required this.titleValue, this.fontSize = 12});
  final Widget? leading;
  final String titleKey;
  final String titleValue;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leading ?? const SizedBox.shrink(),
        SmallText(text: '$titleKey: ', textColor: AppColors.lightSecondaryTextColor, textSize: fontSize),
        Expanded(
          child: SmallText(text: titleValue, fontWeight: FontWeight.bold, textSize: fontSize),
        ),
      ],
    );
  }
}
