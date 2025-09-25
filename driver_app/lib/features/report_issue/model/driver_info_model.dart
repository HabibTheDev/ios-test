class DriverInfoModel {
  final String? name;
  final String? driverType;
  final String? imageUrl;
  int radioValue;

  DriverInfoModel({required this.radioValue, required this.name, this.driverType, this.imageUrl});

  static List<DriverInfoModel> driverRadioList = [
    DriverInfoModel(
      name: 'Nasir Shah Ali',
      driverType: 'Main driver',
      imageUrl: '',
      radioValue: 0,
    ),
    DriverInfoModel(
      name: 'Takbir Alam',
      driverType: 'Additional driver 01',
      imageUrl: '',
      radioValue: 1,
    ),
    DriverInfoModel(
      name: 'Takbir Alam',
      driverType: 'Additional driver 01',
      imageUrl: '',
      radioValue: 2,
    ),
    DriverInfoModel(
      name: 'No one was driving',
      radioValue: 3,
    ),
  ];
}
