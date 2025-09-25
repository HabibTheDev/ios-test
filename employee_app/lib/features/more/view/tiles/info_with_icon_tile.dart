part of '../widgets/widget_imports.dart';

class InfoWithIconTile extends StatelessWidget {
  const InfoWithIconTile({super.key, required this.leadingIcon, required this.title});
  final IconData leadingIcon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(leadingIcon, color: AppColors.primaryColor, size: 16).paddingOnly(right: 4),
        Expanded(
            child: SmallText(
                text: title ?? '${AppLocalizations.of(context)?.notAvailable}',
                textColor: AppColors.lightSecondaryTextColor))
      ],
    );
  }
}
