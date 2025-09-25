class ContractDetailsOverviewModel {
  final String? title;
  final String? value;

  ContractDetailsOverviewModel({this.title, this.value});

  static List<ContractDetailsOverviewModel> list = [
    ContractDetailsOverviewModel(title: 'Failed payments', value: '03'),
    ContractDetailsOverviewModel(title: 'No of collisions', value: '15'),
    ContractDetailsOverviewModel(title: 'Total maintenance', value: '13'),
    ContractDetailsOverviewModel(title: 'Total exchanges', value: '11'),
    ContractDetailsOverviewModel(title: 'Total driven', value: '08'),
    ContractDetailsOverviewModel(title: 'Total extra mileage', value: '05'),
  ];
}
