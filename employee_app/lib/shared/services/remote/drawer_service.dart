import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/drawer/model/brand_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';
import '../../repository/remote/drawer_repo.dart';
import '../../utils/app_toast.dart';

class DrawerService extends ApiClient implements DrawerRepo {
  @override
  Future<BrandModel?> getBrandDetails() async {
    try {
      final response = await getRequest(path: ApiEndpoint.getMyBrand);
      return brandModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }
}
