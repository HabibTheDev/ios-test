import 'package:get/get.dart';

import '../../../shared/services/remote/explore_cars_service.dart';
import '../model/catalogue_car_model.dart';
import '../model/city_model.dart';

class ExploreCarController extends GetxController {
  ExploreCarController(this._service);
  final ExploreCarsService _service;

  // Variables
  final RxBool isLoading = true.obs;
  final RxList<CatalogueCarModel> catalogueCarList = <CatalogueCarModel>[].obs;
  final RxList<CityModel> cityList = <CityModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchCatalogueCarList();
    await fetchCityList();
    isLoading(false);
  }

  Future<void> fetchCatalogueCarList() async {
    catalogueCarList.value = await _service.getCatalogueCarList();
  }

  Future<void> fetchCityList() async {
    cityList.value = await _service.getCities();
  }
}
