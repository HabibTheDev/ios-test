import 'dart:async';
import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';

import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/services/service_locator.dart';

class OnboardingController extends GetxController {
  final List<String> strings = [
    'Hi there 👋',
    'Congratulations on your first car subscription🎉',
    'Sign up and wait for your car\'s handover',
    'Let\'s go👍',
  ];
  RxInt currentIndex = 0.obs;
  RxBool visible = true.obs;
  Timer? _timer;

  @override
  Future<void> onInit() async {
    super.onInit();
    startOnboardingTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startOnboardingTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) async {
        visible(false);
        if (currentIndex.value == 3) {
          await ServiceLocator.get<LocalStorageRepo>().saveIsShowOnboard(isShowOnboard: false).then((value) {
            _timer?.cancel();
            Get.offAllNamed(RouterPaths.signUp);
          });
        } else {
          Future.delayed(
            const Duration(milliseconds: 700),
            () {
              currentIndex.value = (currentIndex.value + 1) % strings.length;
              visible.value = true;
            },
          );
        }
      },
    );
  }
}
