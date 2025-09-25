import '../../../features/drawer/model/brand_model.dart';

abstract class DrawerRepo {
  Future<BrandModel?> getBrandDetails();
}
