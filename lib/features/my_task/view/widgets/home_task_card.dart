part of 'widget_imports.dart';

class HomeTaskCard extends StatelessWidget {
  const HomeTaskCard({super.key, required this.title, required this.value, required this.onTap});
  final String title;
  final String value;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(text: title, maxLine: 1, textColor: AppColors.lightAppBarIconColor),
                BodyText(
                  text: value,
                  textSize: 16,
                  maxLine: 1,
                  textColor: AppColors.lightAppBarIconColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_outlined, color: AppColors.lightAppBarIconColor, size: 14)
        ],
      ),
    );
  }
}
