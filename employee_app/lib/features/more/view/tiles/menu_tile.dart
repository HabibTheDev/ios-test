part of '../widgets/widget_imports.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.leadingSvgAsset, required this.title, this.trailing, required this.onTap});
  final String leadingSvgAsset;
  final String title;
  final Widget? trailing;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: BodyText(text: title, textSize: 16),
      leading: SvgPicture.asset(leadingSvgAsset, height: 20, width: 20),
      trailing: trailing,
    );
  }
}
