import '../../../shared/utils/enums.dart';

class DriverPermissionRadioModel {
  final String? permissionType;
  final String? description;
  final DriverPermissionType? typeEnum;
  int radioValue;

  DriverPermissionRadioModel(
      {required this.permissionType,
      required this.description,
      required this.typeEnum,
      required this.radioValue});

  static List<DriverPermissionRadioModel> permissionTypes = [
    DriverPermissionRadioModel(
        permissionType: 'Full access',
        description: 'Driver will be able to drive anytime.',
        typeEnum: DriverPermissionType.fullAccess,
        radioValue: 0),
    DriverPermissionRadioModel(
        permissionType: 'Partial access',
        description: 'Driver will be limited to a fixed time',
        typeEnum: DriverPermissionType.partialAccess,
        radioValue: 1),
  ];
}
