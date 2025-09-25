import '../../../shared/utils/enums.dart';

class ReturnMethodRadioModel {
  final String? method;
  final String? description;
  final ReturnTypeEnum? typeEnum;
  int radioValue;

  ReturnMethodRadioModel(
      {required this.method,
      required this.description,
      required this.typeEnum,
      required this.radioValue});

  static List<ReturnMethodRadioModel> returnMethodList = [
    ReturnMethodRadioModel(
        method: 'Drop-off',
        description: 'Drop-off the car yourself to the garage.',
        typeEnum: ReturnTypeEnum.dropOff,
        radioValue: 0),
    ReturnMethodRadioModel(
        method: 'Retrieve',
        description: 'An valet will return the car from your address.',
        typeEnum: ReturnTypeEnum.retrieve,
        radioValue: 1),
  ];
}
