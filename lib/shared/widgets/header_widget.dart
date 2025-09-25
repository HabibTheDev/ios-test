part of 'widget_imports.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget(
      {super.key,
      required this.title,
      this.trailing,
      this.titleColor,
      this.backgroundColor});
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleText(text: title, textColor: titleColor),
          const WidthBox(width: 8),
          trailing ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
