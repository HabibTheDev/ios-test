import '../../../shared/enums/enums.dart';

class DrawerModel {
  final String asset;
  final String title;
  final DrawerItemEnum drawerItemEnum;

  DrawerModel({
    required this.asset,
    required this.title,
    required this.drawerItemEnum,
  });
}
