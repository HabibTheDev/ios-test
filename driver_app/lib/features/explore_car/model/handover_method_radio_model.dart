import '../../../shared/utils/enums.dart';

class HandoverMethodRadioModel {
  final String? method;
  final String? description;
  final String? rate;
  final HandoverTypeEnum? typeEnum;
  int radioValue;

  HandoverMethodRadioModel(
      {required this.method,
      required this.description,
      required this.rate,
      required this.typeEnum,
      required this.radioValue});

  static List<HandoverMethodRadioModel> handoverMethodList = [
    HandoverMethodRadioModel(
        method: 'Pick-up',
        description: 'Save on fees, pick up in person.',
        rate: '0',
        typeEnum: HandoverTypeEnum.pickup,
        radioValue: 0),
    HandoverMethodRadioModel(
        method: 'Delivery',
        description: 'Home, office, hotel or other address',
        rate: '70',
        typeEnum: HandoverTypeEnum.delivery,
        radioValue: 1),
  ];
}
