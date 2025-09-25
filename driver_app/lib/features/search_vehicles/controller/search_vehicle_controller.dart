import 'dart:async';
import 'package:get/get.dart';

import '../../../shared/repository/remote/my_vehicles_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../my_vehicles/model/vehicle_model.dart';

class SearchVehicleController extends GetxController {
  Timer? debounceTimer;
  final RxnString searchKey = RxnString();
  final RxBool isLoading = false.obs;

  final RxList<VehicleModel> searchedVehicles = <VehicleModel>[].obs;

  Future<void> fetchVehicles({required String contractId}) async {
    debouncing(fn: () async {
      searchKey.value = contractId;
      if (searchKey.value != null && searchKey.value!.isNotEmpty) {
        isLoading(true);
        searchedVehicles.value =
            await ServiceLocator.get<MyVehiclesRepo>().getAllVehicle(queryParams: {'searchQuery': searchKey.value});

        isLoading(false);
      } else {
        searchedVehicles.clear();
      }
    });
  }

  void debouncing({required Function() fn, int waitForMs = 800}) {
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }
}
