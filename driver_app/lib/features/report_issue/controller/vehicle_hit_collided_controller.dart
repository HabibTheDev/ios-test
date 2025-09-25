import 'package:get/get.dart';

import '../model/vehicle_hit_collided_model.dart';

class VehicleHitCollidedController extends GetxController {
  Rxn<VehicleHitCollidedModel> selectedIssue = Rxn();
  // UI functions
  void changeIssue(VehicleHitCollidedModel model) {
    selectedIssue(model);
  }
}
