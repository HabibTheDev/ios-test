import 'dart:ui';
import '../../../core/constants/app_color.dart';
import 'package:get/get.dart';

class StartDrivingController extends GetxController {
  final RxBool isCarLocked = true.obs;

  Color lockedUnlockedColor() =>
      isCarLocked.value ? AppColors.primaryColor : AppColors.deepPrimaryColor;

  void lockedUnlockedToggle() {
    isCarLocked(!isCarLocked.value);
  }
}
