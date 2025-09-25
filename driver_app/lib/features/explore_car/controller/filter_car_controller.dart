import 'dart:async';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../shared/repository/remote/explore_cars_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/utils/enums.dart';
import '../model/catalogue_car_model.dart';
import '../model/city_model.dart';
import '../model/filter_car_model.dart';

class FilterCarController extends GetxController {
  // Variables
  final RxBool isLoading = false.obs;
  final Rxn<CatalogueCarModel> selectedCatalogue = Rxn();
  final Rxn<CityModel> selectedLocation = Rxn();
  final Rxn<String> selectedFuelType = Rxn();
  final Rxn<String> selectedCarMake = Rxn();
  final Rxn<String> selectedCarStyle = Rxn();
  final Rxn<String> selectedTransmission = Rxn();
  final Rxn<String> minBudget = Rxn();
  final Rxn<String> maxBudget = Rxn();

  final Rxn<FilterCarModel> filterCarModel = Rxn();
  final RxList<ExploreCar> filterCarList = <ExploreCar>[].obs;

  // Pagination
  int page = 1;
  int totalPages = 1;
  int limit = 10;
  final RefreshController refreshController = RefreshController();
  Map<String, dynamic> queryParameters = {};

  // Search
  Timer? debounceTimer;

  // UI functions:::::::::::::::::
  // Catalogue
  void addCatalogueItem(CatalogueCarModel value) {
    selectedCatalogue.value = value;
  }

  void removeCatalogueItem() {
    selectedCatalogue.value = null;
  }

  // Location
  void addLocationItem(CityModel value) {
    selectedLocation.value = value;
  }

  void removeLocationItem() {
    selectedLocation.value = null;
  }

  // Fuel type
  void addFuelTypeItem(String value) {
    selectedFuelType.value = value;
  }

  void removeFuelTypeItem() {
    selectedFuelType.value = null;
  }

  // Transmission
  void addTransmissionItem(String value) {
    selectedTransmission.value = value;
  }

  void removeTransmissionItem() {
    selectedTransmission.value = null;
  }

  // Car style
  void addCarStyleItem(String value) {
    selectedCarStyle.value = value;
  }

  void removeCarStyleItem() {
    selectedCarStyle.value = null;
  }

  // Car make
  void addCarMakeItem(String value) {
    selectedCarMake.value = value;
  }

  void removeCarMakeItem() {
    selectedCarMake.value = null;
  }

  // Min budget
  void changeMinBudget(String value) {
    if (value.isEmpty) {
      minBudget.value = null;
      return;
    }
    minBudget.value = value;
  }

  void removeMinBudget() {
    minBudget.value = null;
  }

  // Max budget
  void changeMaxBudget(String value) {
    if (value.isEmpty) {
      maxBudget.value = null;
      return;
    }
    maxBudget.value = value;
  }

  void removeMaxBudget() {
    maxBudget.value = null;
  }

  // Clear all filter
  void clearCarFilter() {
    selectedCatalogue.value = null;
    selectedLocation.value = null;
    selectedFuelType.value = null;
    selectedCarMake.value = null;
    selectedTransmission.value = null;
    selectedCarStyle.value = null;
    minBudget.value = null;
    maxBudget.value = null;
  }

  bool showClearAllButton() =>
      selectedCatalogue.value != null ||
      selectedLocation.value != null ||
      selectedFuelType.value != null ||
      selectedCarMake.value != null ||
      selectedTransmission.value != null ||
      selectedCarStyle.value != null ||
      minBudget.value != null ||
      maxBudget.value != null;

  Future<void> onSearch({required CarFilterType? carFilterType, String? searchKey}) async {
    debouncing(fn: () async {
      await fetchVehicles(carFilterType: carFilterType, searchKey: searchKey);
    });
  }

  Future<void> onLoading({required CarFilterType? carFilterType, int? id, String? make, String? searchKey}) async {
    await fetchVehicles(carFilterType: carFilterType, id: id, make: make, searchKey: searchKey, pagination: true);
    refreshController.loadComplete();
  }

  Future<void> onRefresh({required CarFilterType? carFilterType, int? id, String? make, String? searchKey}) async {
    page = 1;
    totalPages = 1;
    filterCarList.clear();
    await fetchVehicles(carFilterType: carFilterType, id: id, make: make, searchKey: searchKey, pagination: true);
    refreshController.refreshCompleted();
  }

  void prepareFilter({required CarFilterType? carFilterType, int? id, String? make, String? searchKey}) {
    queryParameters = {};
    if (id != null) {
      if (carFilterType == CarFilterType.catalogue) {
        queryParameters.addEntries({'catalogueId': id}.entries);
      } else if (carFilterType == CarFilterType.location) {
        queryParameters.addEntries({'cityId': id}.entries);
      }
    }
    if (carFilterType != CarFilterType.catalogue && selectedCatalogue.value != null) {
      queryParameters.addEntries({'catalogueId': selectedCatalogue.value?.id}.entries);
    }
    if (carFilterType != CarFilterType.location && selectedLocation.value != null) {
      queryParameters.addEntries({'cityId': id}.entries);
    }
    if (make != null) {
      queryParameters.addEntries({'make': make}.entries);
    }
    if (make == null && selectedCarMake.value != null) {
      queryParameters.addEntries({'make': selectedCarMake.value}.entries);
    }
    if (selectedTransmission.value != null) {
      queryParameters.addEntries({'transmission': selectedTransmission.value}.entries);
    }
    if (selectedCarStyle.value != null) {
      queryParameters.addEntries({'style': selectedCarStyle.value}.entries);
    }
    if (selectedFuelType.value != null) {
      queryParameters.addEntries({'fuelType': selectedFuelType.value}.entries);
    }
    if (minBudget.value != null) {
      queryParameters.addEntries({'budgetLow': minBudget.value}.entries);
    }
    if (maxBudget.value != null) {
      queryParameters.addEntries({'budgetHigh': maxBudget.value}.entries);
    }
    if (searchKey != null) {
      queryParameters.addEntries({'search': searchKey}.entries);
    }

    // Add limit
    queryParameters.addEntries({'limit': limit}.entries);
    queryParameters.addEntries({'page': page}.entries);
  }

  // API functions:::::::::::::::::::::::::::::::::::
  // Fetch vehicle
  Future<void> fetchVehicles({
    required CarFilterType? carFilterType,
    int? id,
    String? make,
    String? searchKey,
    bool pagination = false,
  }) async {
    if (page <= totalPages) {
      // prepare filter for search
      prepareFilter(carFilterType: carFilterType, id: id, make: make, searchKey: searchKey);

      if (pagination == false) isLoading(true);
      filterCarModel.value =
          await ServiceLocator.get<ExploreCarsRepo>().getFilteredVehicles(queryParams: queryParameters);
      filterCarList.addAll(filterCarModel.value?.data?.data?.cars ?? []);
      page++;
      totalPages = filterCarModel.value?.meta?.total ?? 1;

      if (filterCarList.isEmpty) {
        showToast('Car not found');
      }
      isLoading(false);
    }
  }

  // Filter car
  Future<void> fetchFilteredVehicles({required CarFilterType? carFilterType, int? id, String? make}) async {
    // prepare filter for search
    prepareFilter(carFilterType: carFilterType, id: id, make: make);
    page = 1;
    totalPages = 1;
    filterCarList.clear();
    await fetchVehicles(carFilterType: carFilterType, id: id, make: make);
  }

  void debouncing({required Function() fn, int waitForMs = 800}) {
    debounceTimer?.cancel();
    debounceTimer = Timer(Duration(milliseconds: waitForMs), fn);
  }
}
