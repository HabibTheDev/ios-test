import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/more/model/country_code_model.dart';
import '../../../features/more/model/employee_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';
import '../../repository/remote/profile_repo.dart';
import '../../utils/app_toast.dart';

class ProfileService extends ApiClient implements ProfileRepo {
  @override
  Future<EmployeeModel?> getEmployeeDetails() async {
    try {
      final response = await getRequest(path: ApiEndpoint.employeeOwnInfo);
      return employeeModelFromJson(jsonEncode(response.data['data']));
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
  Future<List<CountryCodeModel>?> getCountries() async {
    try {
      final response = await getRequest(path: ApiEndpoint.getCountries);
      return countryCodeModelFromJson(jsonEncode(response.data['data']));
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
  Future<bool> updateEmployeeProfile({String? filePath, required Map<String, dynamic> body}) async {
    try {
      final response = await multipartPutRequest(path: ApiEndpoint.updateOwnProfile, filePath: filePath, body: body);
      showToast(response.data['message']);
      return response.data['success'];
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  @override
  Future<bool> getLicenseVerificationLink({required String email}) async {
    try {
      final body = {"email": email, "role": "employee", "type": "license"};
      final response = await postRequest(path: ApiEndpoint.generateLinkForVerification, body: body);
      if (response.statusCode == 200) {
        showToast(response.data['message']);
        return response.data['success'];
      }
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  @override
  Future<bool> getPassportVerificationLink({required String email}) async {
    try {
      final body = {"email": email, "role": "employee", "type": "passport"};
      final response = await postRequest(path: ApiEndpoint.generateLinkForVerification, body: body);
      if (response.statusCode == 200) {
        showToast(response.data['message']);
        return response.data['success'];
      }
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }
}
