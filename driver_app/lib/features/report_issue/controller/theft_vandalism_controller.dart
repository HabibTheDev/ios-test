import 'package:get/get.dart';

import '../model/theft_vandalism_model.dart';

class TheftVandalismController extends GetxController {
  Rxn<TheftVandalismModel> selectedIssue = Rxn();

  // UI functions
  void changeIssue(TheftVandalismModel model) {
    selectedIssue(model);
  }
}
