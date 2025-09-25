import '../../../features/explore_car/model/checkout_driver_model.dart';
import '../../../features/explore_car/model/extra_model.dart';
import '../../../features/explore_car/model/mileage_plan_model.dart';
import '../../../features/explore_car/model/policy_model.dart';
import '../../../features/explore_car/model/protection_plan_model.dart';

abstract class CarCheckoutRepo {
  Future<MileagePlanModel?> getMileagePackages({required int catalogueId});
  Future<ProtectionPlanModel?> getProtectionPackages({required int catalogueId});
  Future<CheckoutDriverModel?> getDriverPlan({required int catalogueId});
  Future<List<ExtraModel>> getExtraPackages({required int catalogueId});
  Future<List<PolicyModel>> getPolicies({required int catalogueId});
}
