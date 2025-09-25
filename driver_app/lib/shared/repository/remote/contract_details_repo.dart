import '../../../features/contracts/model/contract_details_model.dart';

abstract class ContractDetailsRepo {
  Future<ContractDetailsModel?> getContractDetails({required int contractId});
}
