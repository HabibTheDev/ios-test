class DaySlotModel {
  final String day;
  bool checkValue;

  DaySlotModel({required this.day, required this.checkValue});

  static final daySlotList = [
    DaySlotModel(day: 'Saturday', checkValue: false),
    DaySlotModel(day: 'Sunday', checkValue: true),
    DaySlotModel(day: 'Monday', checkValue: true),
    DaySlotModel(day: 'Tuesday', checkValue: false),
    DaySlotModel(day: 'Wednesday', checkValue: true),
    DaySlotModel(day: 'Thursday', checkValue: true),
    DaySlotModel(day: 'Friday', checkValue: false),
  ];
}
