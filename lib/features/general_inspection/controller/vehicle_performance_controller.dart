import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';
import '../../../shared/enums/enums.dart';
import '../model/car_running_step_model.dart';
import '../model/car_stationary_step_model.dart';
import '../model/vehicle_performance_model.dart';

class VehiclePerformanceController extends GetxController {
  final RxList<VehiclePerformanceModel> performanceTestTypeList = <VehiclePerformanceModel>[].obs;

  List<CarStationaryStepModel> carStationaryStepList = [];
  List<CarRunningStepModel> carRunningStepList = [];

  final RxBool completedAllTesting = false.obs;

  @override
  void onInit() async {
    performanceTestTypeList.addAll(VehiclePerformanceModel.testTypes);

    performanceTestTypeList.listen((updatedList) {
      completedAllTesting.value = performanceTestTypeList.every((type) => type.status == StepStatus.complete);
    });
    super.onInit();
  }

  void finishTestingOnTap() {
    Get.until((route) => route.settings.name == RouterPaths.generalInspection);
  }
}
