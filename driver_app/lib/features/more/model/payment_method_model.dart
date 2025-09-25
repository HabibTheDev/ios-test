class PaymentMethodModel {
  final String? cardNo;
  final DateTime? expireDate;
  int? radioValue;

  PaymentMethodModel({this.cardNo, this.expireDate, this.radioValue});

  static List<PaymentMethodModel> paymentsList = [
    PaymentMethodModel(
        cardNo: '4000 *** *** 9010',
        expireDate: DateTime.now().subtract(const Duration(days: 365)),
        radioValue: 0),
    PaymentMethodModel(
        cardNo: '2412 **** ****2345',
        expireDate: DateTime.now().subtract(const Duration(days: 365)),
        radioValue: 1),
    PaymentMethodModel(
        cardNo: '3759 ****** 21001',
        expireDate: DateTime.now().subtract(const Duration(days: 365)),
        radioValue: 2),
  ];
}
