enum ReportIssueType { damageOrBroken, theftOrVandalism, vehicleHit, collidedOrFell, weatherDamage, none }

// Resend OTP Type
enum ResendOtpType {
  forgotPassword('forgotPassword'),
  changePassword('changePassword');

  const ResendOtpType(this.value);
  final String value;
}

// Notification Type
enum NotificationType {
  employeeTask('employeeTask');

  const NotificationType(this.value);
  final String value;
}

enum TimeSlotEnum {
  allTime('all time'),
  thisWeek('this week'),
  lastWeek('last week'),
  thisMonth('thisMonth');

  const TimeSlotEnum(this.value);
  final String value;
}

enum DrawerItemEnum {
  myVehicles('My vehicles'),
  myLocation('My location'),
  contracts('Contracts'),
  reportIssue('Report issue'),
  getHelp('Get help'),
  exploreCar('Explore car'),
  more('More');

  const DrawerItemEnum(this.value);
  final String value;
}

enum TaskStepStatusEnum {
  complete('complete'),
  awaiting('awaiting'),
  inComplete('inComplete');

  const TaskStepStatusEnum(this.value);
  final String value;
}

enum VideoRecordingStateEnum {
  awaiting,
  recording,
  complete;
}

enum MaintenanceContractTypeEnum {
  dropOff('Drop-off'),
  retrieve('Retrieve');

  const MaintenanceContractTypeEnum(this.value);
  final String value;
}

enum ExchangeTypeEnum {
  pickup('Pickup'),
  delivery('Delivery');

  const ExchangeTypeEnum(this.value);
  final String value;
}

enum HandoverTypeEnum {
  pickup('Pickup'),
  delivery('Delivery');

  const HandoverTypeEnum(this.value);
  final String value;
}

enum ReturnTypeEnum {
  dropOff('Drop-off'),
  retrieve('Retrieve');

  const ReturnTypeEnum(this.value);
  final String value;
}

enum MaintenanceServiceType {
  regularServicing('regular servicing'),
  damageRepairing('damage repairing');

  const MaintenanceServiceType(this.value);
  final String value;
}

enum ApiVersionEnum {
  v2('v2');

  const ApiVersionEnum(this.value);
  final String value;
}

enum CardActionEnum {
  add,
  edit;
}

enum CarFilterType {
  search,
  brand,
  location,
  catalogue;
}

enum MyVehicleType {
  defaultType('defaultType'),
  newContract('newContact'), // Correct: newContract
  canceledContract('canceledContract'),
  exchange('exchange'),
  maintenance('maintenance'),
  revokedAndBlocked('revokedAndBlocked'),
  exploreCar('exploreCar');

  const MyVehicleType(this.value);
  final String value;
}

enum MyVehicleState {
  awaiting('awaiting'),
  inProgress('inProgress');

  const MyVehicleState(this.value);
  final String value;
}

enum DriverPermissionType {
  fullAccess,
  partialAccess;
}

// Nearby location type
enum NearbyLocationType {
  gasStation('GAS_STATION'),
  evChargingStation('EV_CHARGING_STATION'),
  parkingLot('PARKING_LOT'),
  carWash('CAR_WASH'),
  repairCenter('REPAIR_CENTER'),
  roadsideAssistance('ROADSIDE_ASSISTANCE'),
  companyLocation('COMPANY_LOCATION');

  const NearbyLocationType(this.value);
  final String value;
}

// Inspection capture status
enum InspectionCaptureStatus {
  incomplete('incomplete'),
  awaiting('awaiting'),
  complete('complete');

  const InspectionCaptureStatus(this.value);
  final String value;
}
