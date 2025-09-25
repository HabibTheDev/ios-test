import '../../../features/explore_car/model/catalogue_car_model.dart';
import '../../../features/explore_car/model/city_model.dart';
import '../../../features/explore_car/model/explore_car_details_model.dart';
import '../../../features/explore_car/model/filter_car_model.dart';

abstract class ExploreCarsRepo {
  Future<List<CatalogueCarModel>> getCatalogueCarList();
  Future<FilterCarModel?> getFilteredVehicles({Map<String, dynamic>? queryParams});
  Future<ExploreCarDetailsModel?> getCarDetails({required int id});
  Future<List<CityModel>> getCities();
}
