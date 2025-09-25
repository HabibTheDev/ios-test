class AnybodyHurtModel {
  final String? title;
  int radioValue;

  AnybodyHurtModel({required this.radioValue, required this.title});

  static List<AnybodyHurtModel> anybodyHurtRadioList = [
    AnybodyHurtModel(
      title: 'Yes',
      radioValue: 0,
    ),
    AnybodyHurtModel(
      title: 'No',
      radioValue: 1,
    ),
    AnybodyHurtModel(
      title: 'I\'m not sure',
      radioValue: 2,
    ),
  ];
}
