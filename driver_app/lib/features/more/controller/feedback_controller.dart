import 'package:get/get.dart';

class FeedbackController extends GetxController {
  RxBool selectedRadioValue = true.obs;

  void onChanged(bool? value) {
    if (value != null) {
      selectedRadioValue.value = value;
    }
  }
}
