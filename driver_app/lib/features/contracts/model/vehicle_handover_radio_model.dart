import '../../../shared/utils/enums.dart';

class VehicleHandoverRadioModel {
  final String? method;
  final String? description;
  final HandoverTypeEnum? typeEnum;
  int radioValue;

  VehicleHandoverRadioModel(
      {required this.method,
      required this.description,
      required this.typeEnum,
      required this.radioValue});

  static List<VehicleHandoverRadioModel> vehicleHandoverList = [
    VehicleHandoverRadioModel(
        method: 'Pick-up',
        description: 'Pick-up the car by yourself to the garage.',
        typeEnum: HandoverTypeEnum.pickup,
        radioValue: 0),
    VehicleHandoverRadioModel(
        method: 'Delivery',
        description: 'An valet will deliver the car to your address.',
        typeEnum: HandoverTypeEnum.delivery,
        radioValue: 1),
  ];
}
