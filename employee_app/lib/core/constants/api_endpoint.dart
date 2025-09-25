class ApiEndpoint {
  ApiEndpoint._();

  // Drawer
  static const String getMyBrand = 'brands/get-my-brand';

  // Inspection
  static const String aiDetectDamage = 'detect_damage';
  static const String entryInspectionReport = 'inspection/entry';
  static const String departureInspectionReport = 'inspection/departure';
  static const String returnInspectionReport = 'inspection/return';
  static const String generalInspectionReport = 'inspection/general';
  static const String maintenanceInspectionReport = 'inspection/maintenance';
  static const String finalSummaryReport = 'customers/contract-final-summary';
  static const String getCurrentDamages = 'inspection/get-current-damages';
  static const String getEntryInspection = 'inspection/get-entry-inspection';
  static const String detectDamage = 'inspection/damage-detect';
  static const String vinData = 'vindata';

  // Customize damages
  static const String addNewDamage = 'inspection/add-new-damages';
  static const String editCurrentDamage = 'inspection/edit-damages';
  static const String deleteCurrentDamage = 'inspection/damage';

  // Provide maintenance info
  static const String provideInfo = 'maintenance/provide-info';
  static const String damageRepairProvideInfo = 'maintenance/damage-repair-provide-info';
  static const String servicingProvideInfo = 'maintenance/servicing-provide-info';

  // Authentication
  static const String login = 'auth/employees/login';
  static const String sendOtp = 'users/send-password-otp';
  static const String verifyOtp = 'users/confirm-password-otp';
  static const String resetPassword = 'users/reset-password';
  static const String resendOtp = 'auth/send-otp';
  static const String refreshToken = 'auth/refresh-token-app';

  // My-Task
  static const String overviewUserTask = 'tasks/overview-user-task';
  static const String taskDates = 'tasks/get-task-dates';
  static const String getUserTask = 'tasks/get-user-task';
  static const String getSingleTask = 'tasks/get-task/';
  static const String reportTaskIssue = 'tasks/create-issue';
  static const String getServicePoint = 'maintenance/get-service-point';

  // More
  static const String isBiometric = 'users/isBiometric';
  static const String employeeOwnInfo = 'employees/get-employee-own-info';
  static const String updateOwnProfile = 'employees/update-own-profile';
  static const String requestChangePassword = 'users/request-change-password';
  static const String confirmChangePassword = 'users/confirm-change-password';
  static const String getCountries = 'country/get-countries';
  static const String generateLinkForVerification = 'users/generate-link-for-verification';

  // Notification
  static const String getNotification = 'notifications?platform=mobile';
  static const String readNotification = 'notifications/read';
  static const String deleteNotification = 'notifications/delete';
  static const String markAllAsRead = 'notifications/mark-all-as-read';

  // Stepper
  static const String stepperInspection = 'customers/stepper-inspection';
  static const String stepperMaintenance = 'customers/stepper-maintenance';
  static const String stepperHandover = 'customers/stepper-handover';
  static const String stepperReturn = 'customers/stepper-return';
  static const String stepperExchange = 'customers/stepper-exchange';
  static const String stepperCommon = 'customers/stepper-common';
  static const String startTask = 'customers/starting-task';

  // Inbox
  static const String getMyMessage = 'chat/get-my-message';
  static const String sendInboxMessage = 'chat/send-inbox-message';
}
