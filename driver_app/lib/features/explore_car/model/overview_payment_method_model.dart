class OverviewPaymentMethodModel {
  final String? title;
  final String? description;
  final String? cardNumber;
  final String? mmYY;
  final String? cvc;
  int? radioValue;

  OverviewPaymentMethodModel({
    required this.title,
    required this.description,
    required this.radioValue,
    this.cardNumber,
    this.mmYY,
    this.cvc,
  });

  OverviewPaymentMethodModel copyWith({
    String? title,
    String? description,
    String? cardNumber,
    String? mmYY,
    String? cvc,
    int? radioValue,
  }) {
    return OverviewPaymentMethodModel(
      title: title ?? this.title,
      description: description ?? this.description,
      cardNumber: cardNumber ?? this.cardNumber,
      mmYY: mmYY ?? this.mmYY,
      cvc: cvc ?? this.cvc,
      radioValue: radioValue ?? this.radioValue,
    );
  }

  static List<OverviewPaymentMethodModel> paymentMethodList = [
    OverviewPaymentMethodModel(
        title: 'Current card',
        description: 'Check out with your current active card',
        radioValue: 0),
    OverviewPaymentMethodModel(
        title: 'New card',
        description: 'Add new credit card for check outs',
        cardNumber: '',
        mmYY: '',
        cvc: '',
        radioValue: 1),
  ];
}
