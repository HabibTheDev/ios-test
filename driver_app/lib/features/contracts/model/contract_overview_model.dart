class ContractOverviewModel {
  final String? title;
  final String? value;

  ContractOverviewModel({this.title, this.value});

  static List<ContractOverviewModel> list = [
    ContractOverviewModel(title: 'Active contracts', value: '03'),
    ContractOverviewModel(title: 'Canceled contracts', value: '15'),
    ContractOverviewModel(title: 'Total failed payments', value: '13'),
    ContractOverviewModel(title: 'Total collisions', value: '11'),
    ContractOverviewModel(title: 'Total maintenance', value: '08'),
    ContractOverviewModel(title: 'Total exchanges', value: '05'),
  ];
}
