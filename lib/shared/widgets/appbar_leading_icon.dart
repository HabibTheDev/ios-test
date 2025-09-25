part of 'widget_imports.dart';

class AppBarLeadingIcon extends StatelessWidget {
  const AppBarLeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.arrow_back_ios, size: 20, color: AppColors.lightAppBarIconColor),
    );
  }
}
