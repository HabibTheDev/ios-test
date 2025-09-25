import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/services/service_locator.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();

    final showOnboarding = await ServiceLocator.get<LocalStorageRepo>().getIsShowOnboard();
    await Future.delayed(const Duration(milliseconds: 2000));

    if (showOnboarding == null || showOnboarding == true) {
      Get.offAllNamed(RouterPaths.onboarding);
    } else {
      Get.offAllNamed(RouterPaths.signUp);
    }
  }
}
