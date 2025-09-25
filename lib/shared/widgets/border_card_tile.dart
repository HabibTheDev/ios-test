part of 'widget_imports.dart';

class BorderCardTile extends StatelessWidget {
  const BorderCardTile({
    super.key,
    required this.leading,
    required this.title,
    this.secondaryTitle,
    required this.subTitle,
    this.onTap,
    this.bgColor,
    this.hideBorder = false,
  });
  final Widget leading;
  final String title;
  final String? secondaryTitle;
  final String subTitle;
  final Function()? onTap;
  final Color? bgColor;
  final bool hideBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: !hideBorder ? Border.all(color: AppColors.lightTextFieldFillColor, width: 1) : null,
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        dense: true,
        leading: leading.paddingOnly(left: 12),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BodyText(text: title, fontWeight: FontWeight.w600),
            if (secondaryTitle != null)
              BodyText(
                text: secondaryTitle!,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(left: 4),
          ],
        ),
        subtitle: SmallText(text: subTitle, textColor: AppColors.lightSecondaryTextColor),
      ),
    );
  }
}
