import '../../../shared/utils/enums.dart';

class MaintenanceTypeRadioModel {
  final String? serviceType;
  final String? description;
  final MaintenanceServiceType? typeEnum;
  int radioValue;

  MaintenanceTypeRadioModel(
      {required this.serviceType,
      required this.description,
      required this.typeEnum,
      required this.radioValue});

  static List<MaintenanceTypeRadioModel> maintenanceServiceTypes = [
    MaintenanceTypeRadioModel(
        serviceType: 'Regular servicing',
        description: 'Regular check-up of the car to maintain vehicle health.',
        typeEnum: MaintenanceServiceType.regularServicing,
        radioValue: 0),
    MaintenanceTypeRadioModel(
        serviceType: 'Damage repairing',
        description:
            'Fixing all existing damages to maintain car\'s condition.',
        typeEnum: MaintenanceServiceType.damageRepairing,
        radioValue: 1),
  ];
}
