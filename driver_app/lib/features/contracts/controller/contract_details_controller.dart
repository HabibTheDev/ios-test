import 'package:get/get.dart';

import '../../../shared/repository/remote/contract_details_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';

import '../model/contract_details_model.dart';

class ContractDetailsController extends GetxController {
  final _contractDetailsRepo = ServiceLocator.get<ContractDetailsRepo>();

  final RxBool isLoading = true.obs;

  final Rxn<ContractDetailsModel> contractDetails = Rxn();

  Future<void> getContractDetails({required int? contractId}) async {
    if (contractId == null) {
      showToast('Contract id not found!');
      isLoading(false);
      return;
    }
    contractDetails.value = await _contractDetailsRepo.getContractDetails(contractId: contractId);
    isLoading(false);
  }
}
