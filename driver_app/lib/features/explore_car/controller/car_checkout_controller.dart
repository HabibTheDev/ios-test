import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../shared/repository/local/date_time_repo.dart';
import '../../../shared/repository/local/time_repo.dart';
import '../../../shared/repository/remote/car_checkout_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/utils/utils.dart';

import '../model/checkout_driver_model.dart';
import '../model/extra_model.dart';
import '../model/handover_method_radio_model.dart';
import '../model/mileage_plan_model.dart';
import '../model/policy_model.dart';
import '../model/protection_plan_model.dart';

import 'car_details_controller.dart';

class CarCheckoutController extends GetxController {
  final _carCheckoutRepo = ServiceLocator.get<CarCheckoutRepo>();
  // variables
  final RxBool isLoading = true.obs;

  // Mileage
  final Rxn<MileagePlanModel> mileagePlan = Rxn();
  MileagePackageModel? selectedMileagePackage;

  // Protection Plan
  final Rxn<ProtectionPlanModel> protectionPlan = Rxn();
  ProtectionPackageModel? selectedProtectionPackage;

  // Custom package
  List<CustomProtectionModel> selectedCustomProtectionList = [];

  // Driver
  Rxn<CheckoutDriverModel> driverPlan = Rxn();
  CheckoutDriverModel? selectedDriverPlan;

  // Extra
  RxList<ExtraModel> extraList = <ExtraModel>[].obs;
  List<ExtraModel> selectedExtraList = [];

  // Policy
  RxList<PolicyModel> policyList = <PolicyModel>[].obs;

  final RxBool isMinimumAge = false.obs;
  final RxBool agreePolicy = true.obs;

  // Handover method
  final Rxn<HandoverMethodRadioModel> selectedHandoverMethod = Rxn();
  // Date
  final Rxn<DateTime> handoverDate = Rxn();
  final TextEditingController handoverDateController = TextEditingController();
  // Time
  final Rxn<TimeOfDay> handoverTime = Rxn();
  final TextEditingController handoverTimeController = TextEditingController();

  final RxnString selectedPickupLocation = RxnString();
  final TextEditingController deliveryAddressController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    final CarDetailsController carDetailsController = Get.find();
    if (carDetailsController.carDetailsModel.value?.catalogue?.id == null) {
      showToast('Car catalogue id not found');
      return;
    }
    final catalogueId = carDetailsController.carDetailsModel.value!.catalogue!.id!;
    await Future.wait([
      fetchMileagePackages(catalogueId: catalogueId),
      fetchProtectionPackages(catalogueId: catalogueId),
      fetchDriverPlan(catalogueId: catalogueId),
      fetchExtraPackages(catalogueId: catalogueId),
      fetchPolicies(catalogueId: catalogueId),
    ]);
    isLoading(false);
  }

  // UI functions
  void changeMileagePlan(MileagePackageModel value) {
    selectedMileagePackage = value;
    debugPrint(selectedMileagePackage!.title);
  }

  void changeProtectionPackage(ProtectionPackageModel value) {
    selectedProtectionPackage = value;
    debugPrint(selectedProtectionPackage!.title);
  }

  void changeCustomProtection(List<CustomProtectionModel> value) {
    selectedCustomProtectionList = value;
    for (var e in selectedCustomProtectionList) {
      debugPrint('${e.id}-${e.coverageTitle}: ${e.checkValue}');
    }
  }

  void changeDriverPlan(CheckoutDriverModel value) {
    selectedDriverPlan = value;
    debugPrint('${selectedDriverPlan?.quantity}');
  }

  void changeExtraPackages(List<ExtraModel> value) {
    selectedExtraList = value;
    for (var e in selectedExtraList) {
      debugPrint('${e.id}-${e.title}: ${e.quantity}');
    }
  }

  Future<void> pickDateOnTap(BuildContext context) async {
    final date = await ServiceLocator.get<DateTimeRepo>().iOSDatePicker(context, initialDate: handoverDate.value);
    if (date != null) {
      handoverDate.value = date;
      handoverDateController.text = DateFormat('dd MMM, yyyy').format(handoverDate.value!);
    }
  }

  Future<void> pickTimeOnTap(BuildContext context) async {
    final timeOfDay = await ServiceLocator.get<TimeRepo>().iOSTimePicker(context);
    if (timeOfDay != null) {
      handoverTime.value = timeOfDay;
      handoverTimeController.text = formatTimeOfDay(handoverTime.value!);
    }
  }

  void changePickupLocation(String newModel) {
    selectedPickupLocation.value = newModel;
  }

  // API functions
  Future<void> fetchMileagePackages({required int catalogueId}) async {
    final result = await _carCheckoutRepo.getMileagePackages(catalogueId: catalogueId);
    if (result != null) {
      mileagePlan.value = result;
    }
  }

  Future<void> fetchProtectionPackages({required int catalogueId}) async {
    final result = await _carCheckoutRepo.getProtectionPackages(catalogueId: catalogueId);
    if (result != null) {
      protectionPlan.value = result;
    }
  }

  Future<void> fetchDriverPlan({required int catalogueId}) async {
    final result = await _carCheckoutRepo.getDriverPlan(catalogueId: catalogueId);
    if (result != null) {
      driverPlan.value = result;
    }
  }

  Future<void> fetchExtraPackages({required int catalogueId}) async {
    final result = await _carCheckoutRepo.getExtraPackages(catalogueId: catalogueId);
    extraList.value = result;
  }

  Future<void> fetchPolicies({required int catalogueId}) async {
    final result = await _carCheckoutRepo.getPolicies(catalogueId: catalogueId);
    policyList.value = result;
  }
}
