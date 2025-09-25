import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/my_vehicles/model/vehicle_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../repository/remote/my_vehicles_repo.dart';
import '../../api/api_client.dart';
import '../../utils/app_toast.dart';

class MyVehiclesService extends ApiClient implements MyVehiclesRepo {
  @override
  Future<List<VehicleModel>> getAllVehicle({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await getRequest(path: ApiEndpoint.contracts, queryParameters: queryParams);
      return vehicleModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return [];
  }
}
