import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/contracts/model/contract_details_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_client.dart';
import '../../api/api_exception.dart';
import '../../repository/remote/contract_details_repo.dart';
import '../../utils/app_toast.dart';

class ContractDetailsService extends ApiClient implements ContractDetailsRepo {
  @override
  Future<ContractDetailsModel?> getContractDetails({required int contractId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.contracts}/$contractId');
      return contractDetailsModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }
}
