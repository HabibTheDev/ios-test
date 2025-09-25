import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';
import '../../../shared/enums/enums.dart';
import '../model/vehicle_condition_model.dart';

class VehicleConditionController extends GetxController {
  final RxList<VehicleConditionModel> vehicleConditioneTestTypeList = <VehicleConditionModel>[].obs;

  final RxBool completedAllTesting = false.obs;

  @override
  void onInit() async {
    vehicleConditioneTestTypeList.addAll(VehicleConditionModel.testTypes);

    vehicleConditioneTestTypeList.listen((updatedList) {
      completedAllTesting.value = vehicleConditioneTestTypeList.every((type) => type.status == StepStatus.complete);
    });
    super.onInit();
  }

  void finishTestingOnTap() {
    Get.until((route) => route.settings.name == RouterPaths.generalInspection);
  }
}
