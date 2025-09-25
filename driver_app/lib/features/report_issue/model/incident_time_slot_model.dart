class IncidentTimeSlotModel {
  final String slotName;
  final String startTime;
  final String endTime;
  int radioValue;

  IncidentTimeSlotModel({
    required this.radioValue,
    required this.slotName,
    required this.startTime,
    required this.endTime,
  });

  static final List<IncidentTimeSlotModel> slotList = [
    IncidentTimeSlotModel(radioValue: 0, slotName: 'Overnight', startTime: '12AM', endTime: '6AM'),
    IncidentTimeSlotModel(radioValue: 1, slotName: 'Morning', startTime: '6AM', endTime: '12PM'),
    IncidentTimeSlotModel(radioValue: 2, slotName: 'Afternoon', startTime: '12PM', endTime: '6PM'),
    IncidentTimeSlotModel(radioValue: 3, slotName: 'Evening', startTime: '6AM', endTime: '12AM'),
  ];
}
