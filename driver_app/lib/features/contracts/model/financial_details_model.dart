class FinancialDetailsModel {
  final String? title;
  final String? value;

  FinancialDetailsModel({this.title, this.value});

  static List<FinancialDetailsModel> list = [
    FinancialDetailsModel(title: 'Next billing ', value: '11,43'),
    FinancialDetailsModel(title: 'Failed amount', value: '11,43'),
    FinancialDetailsModel(title: 'Total refunded', value: '560'),
    FinancialDetailsModel(title: 'Total in hold', value: '40,32')
  ];
}
