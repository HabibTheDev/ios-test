import 'package:get/get.dart';
import '../../../shared/services/remote/my_vehicles_service.dart';
import '../../../shared/utils/enums.dart';
import '../model/vehicle_model.dart';

class MyVehiclesController extends GetxController {
  MyVehiclesController(this._myVehiclesService);
  final MyVehiclesService _myVehiclesService;
  final RxBool isLoading = true.obs;

  final RxList<VehicleModel> myVehicles = <VehicleModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchAllVehicle();
    isLoading(false);
  }

  Future<void> fetchAllVehicle() async {
    myVehicles.value = await _myVehiclesService.getAllVehicle();
    // Add explore car model
    myVehicles.add(VehicleModel(currentStatus: MyVehicleType.exploreCar.value));
  }
}
