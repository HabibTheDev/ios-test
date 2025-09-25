// Task filter
enum TaskFilterType {
  allTask(''),
  inProgress('in-progress'),
  pending('pending'),
  completed('completed'),
  reportedIssue('reported-issue');

  const TaskFilterType(this.value);
  final String value;
}

// Pending Task filter
enum PendingTaskFilterType {
  all(''),
  upcoming('upcoming'),
  due('due');

  const PendingTaskFilterType(this.value);
  final String value;
}

// In-progress Task filter
enum InProgressTaskFilterType {
  all(''),
  highPriority('high'),
  regular('regular');

  const InProgressTaskFilterType(this.value);
  final String value;
}

// Task status
enum TaskStatusType {
  active('active'),
  draft('draft'),
  incomplete('incomplete');

  const TaskStatusType(this.value);
  final String value;
}

// Time slot
enum TimeSlotEnum {
  allTime('all-time'),
  thisWeek('this-week'),
  lastWeek('last-week'),
  thisMonth('this-month');

  const TimeSlotEnum(this.value);
  final String value;
}

// Drawer item
enum DrawerItemEnum {
  myTask('my task'),
  inbox('inbox'),
  more('more');

  const DrawerItemEnum(this.value);
  final String value;
}

// Task type enum
enum TaskStepStatusEnum {
  awaiting('awaiting'),
  completed('completed'),
  inComplete('incomplete'),
  inProgress('in-progress'),
  pendingApproval('pending-approval');

  const TaskStepStatusEnum(this.value);
  final String value;
}

enum VideoRecordingStateEnum { awaiting, recording, complete }

// API version
enum ApiVersionEnum {
  v1('v1');

  const ApiVersionEnum(this.value);
  final String value;
}

// Task State
enum TaskStateEnum {
  defaultType('default'),
  entryInspection('entry-inspection'),
  generalInspection('general-inspection'),
  maintenance('maintenance'),
  exchange('exchange'),
  handover('handover'),
  returnTask('return');

  const TaskStateEnum(this.value);
  final String value;
}

// Task Type
enum TaskTypeEnum {
  regular('regular'),
  dropOff('drop-off'),
  retrieve('retrieve'),
  pickUp('pick-up'),
  delivery('delivery'),
  defaultType('default');

  const TaskTypeEnum(this.value);
  final String value;
}

// Regular Maintenance Type
enum RegularMaintenanceType {
  regular('regular'),
  damage('damage');

  const RegularMaintenanceType(this.value);
  final String value;
}

// Resend OTP Type
enum ResendOtpType {
  forgotPassword('forgotPassword'),
  changePassword('changePassword');

  const ResendOtpType(this.value);
  final String value;
}

// Notification Type
enum NotificationType {
  employeeTask('EMPLOYEE_TASK');

  const NotificationType(this.value);
  final String value;
}

// Inspection capture status
enum StepStatus {
  incomplete('incomplete'),
  awaiting('awaiting'),
  complete('complete');

  const StepStatus(this.value);
  final String value;
}

enum InspectionCaptureTypeEnum {
  carExterior('Car exterior'),
  licensePlate('License plate'),
  odometer('Odometer');

  const InspectionCaptureTypeEnum(this.value);
  final String value;
}

enum InspectionStateEnum {
  completed('completed'),
  draft('draft');

  const InspectionStateEnum(this.value);
  final String value;
}

enum InspectionTypeEnum {
  entryInspection('Entry Inspection'),
  returnInspection('Return Inspection'),
  departureInspection('Departure Inspection'),
  generalInspection('General Inspection'),
  maintenanceInspection('Maintenance Inspection'),
  finalSummery('Final Summery');

  const InspectionTypeEnum(this.value);
  final String value;
}

enum VehicleType {
  diesel('DIESEL'),
  gasoline('GASOLINE'),
  electric('ELECTRIC'),
  hybrid('HYBRID');

  const VehicleType(this.value);
  final String value;
}

enum VehiclePerformanceType {
  stationary('While car is stationary'),
  running('While car is running');

  const VehiclePerformanceType(this.value);
  final String value;
}

enum VehicleConditionType {
  engine('Engine'),
  brakeSystem('Brake system'),
  tiresAndWheels('Tires and wheels');

  const VehicleConditionType(this.value);
  final String value;
}

enum CarStationaryStep {
  startEngineState('Start the engine'),
  pressAndReleaseBrakeState('Press and release the brake'),
  turnSteeringWheelLeftRightState('Turn steering wheel left and right'),
  changeGearState('Change the gears ');

  const CarStationaryStep(this.value);
  final String value;
}

enum CarRunningStep {
  driveCar('Drive the car for a while'),
  shareObservations('Share your observations');

  const CarRunningStep(this.value);
  final String value;
}
