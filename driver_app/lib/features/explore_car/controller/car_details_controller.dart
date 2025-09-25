import 'package:get/get.dart';

import '../../../shared/repository/remote/explore_cars_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../model/explore_car_details_model.dart';

class CarDetailsController extends GetxController {
  // Variables
  final RxBool isLoading = true.obs;
  final Rxn<ExploreCarDetailsModel> carDetailsModel = Rxn();

  Future<void> initializeData({required int id}) async {
    final result = await ServiceLocator.get<ExploreCarsRepo>().getCarDetails(id: id);
    carDetailsModel.value = result;
    isLoading(false);
  }
}
