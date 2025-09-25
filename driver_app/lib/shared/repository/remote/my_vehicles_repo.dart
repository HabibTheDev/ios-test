import '../../../features/my_vehicles/model/vehicle_model.dart';

abstract class MyVehiclesRepo {
  Future<List<VehicleModel>> getAllVehicle({Map<String, dynamic>? queryParams});
}
