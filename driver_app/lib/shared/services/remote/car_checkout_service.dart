import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/explore_car/model/checkout_driver_model.dart';
import '../../../features/explore_car/model/extra_model.dart';
import '../../../features/explore_car/model/mileage_plan_model.dart';
import '../../../features/explore_car/model/policy_model.dart';
import '../../../features/explore_car/model/protection_plan_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_client.dart';
import '../../api/api_exception.dart';
import '../../repository/remote/car_checkout_repo.dart';
import '../../utils/app_toast.dart';

class CarCheckoutService extends ApiClient implements CarCheckoutRepo {
  @override
  Future<MileagePlanModel?> getMileagePackages({required int catalogueId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getMileagePackages}$catalogueId');
      return mileagePlanModelFromJson(jsonEncode(response.data['data']));
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
  Future<ProtectionPlanModel?> getProtectionPackages({required int catalogueId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getProtectionPackages}$catalogueId');
      return protectionPlanModelFromJson(jsonEncode(response.data['data']['protectionPlan']));
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
  Future<CheckoutDriverModel?> getDriverPlan({required int catalogueId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getDriverPlan}$catalogueId');
      return checkoutDriverModelFromJson(jsonEncode(response.data['data']));
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
  Future<List<ExtraModel>> getExtraPackages({required int catalogueId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getExtraPackages}$catalogueId');
      return extraModelFromJson(jsonEncode(response.data['data']));
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
  Future<List<PolicyModel>> getPolicies({required int catalogueId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getPolicies}$catalogueId');
      return policyModelFromJson(jsonEncode(response.data['data']['policies']));
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
