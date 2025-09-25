import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/explore_car/model/catalogue_car_model.dart';
import '../../../features/explore_car/model/city_model.dart';
import '../../../features/explore_car/model/explore_car_details_model.dart';
import '../../../features/explore_car/model/filter_car_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_client.dart';
import '../../repository/remote/explore_cars_repo.dart';
import '../../utils/app_toast.dart';

class ExploreCarsService extends ApiClient implements ExploreCarsRepo {
  @override
  Future<List<CatalogueCarModel>> getCatalogueCarList() async {
    try {
      final response = await getRequest(path: ApiEndpoint.getAllCatalogue);
      return catalogueCarModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return [];
  }

  @override
  Future<FilterCarModel?> getFilteredVehicles({Map<String, dynamic>? queryParams}) async {
    try {
      final response = await getRequest(path: ApiEndpoint.getCatalogueVehicles, queryParameters: queryParams);
      return filterCarModelFromJson(jsonEncode(response.data));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<ExploreCarDetailsModel?> getCarDetails({required int id}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getCarDetails}$id');
      return exploreCarDetailsModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<List<CityModel>> getCities() async {
    try {
      final response = await getRequest(path: ApiEndpoint.getCities);
      return cityModelFromJson(jsonEncode(response.data['data']));
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
