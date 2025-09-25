class ApiEndpoint {
  ApiEndpoint._();

  // Auth
  static const String login = 'customers/login';
  static const String signUp = 'customers/signup-customer';
  static const String sendOtp = 'users/send-password-otp';
  static const String verifyOtp = 'users/confirm-password-otp';
  static const String resetPassword = 'users/reset-password';
  static const String resendOtp = 'auth/send-otp';
  static const String refreshToken = 'auth/refresh-token-app';

  // Contract
  static const String contracts = 'customers/contacts';

  // Nearby location
  static const String nearbyServiceLocation = 'service-point/nearby-service-point';
  static const String nearbyCompanyLocation = 'location/nearby-service-point';

  // Map
  static const String mapDirectionsUrl = 'https://maps.googleapis.com/mapsdirections/json?';
  static const String mapGeoodeUrl = 'https://maps.googleapis.com/mapsgeocode/json?';

  // // Drawer
  static const String getMyBrand = 'brands/get-my-brand';

  // Explore car
  static const String getAllCatalogue = 'catalogues/get-all-catalogue';
  static const String getCatalogueVehicles = 'catalogues/get-explore-cars-vehicles-customer-app';
  static const String getCarDetails = 'dummy/get-car-details-customer-app/';
  static const String getCities = 'locations/get-cities-customer-app';

  // Checkout
  static const String getMileagePackages = 'catalogues/get-mileage-packages/';
  static const String getProtectionPackages = 'catalogues/get-protection-packages/';
  static const String getDriverPlan = 'catalogues/get-driver-plan/';
  static const String getExtraPackages = 'catalogues/get-extra-packages/';
  static const String getPolicies = 'catalogues/get-policies/';

  // Socket events key
  static const String getNotificationEvent = 'send-notification';
  static const String userNewMessageEvent = 'user-new-message';
  // static const String incompleteTaskEmitEvent = 'incomplete-task';
  // static const String incompleteTaskEvent = 'get-incomplete-task';

  // // More
  static const String isBiometric = 'users/isBiometric';
  static const String employeeOwnInfo = 'customers/get-customers-own-info';
  static const String updateOwnProfile = 'customers/update-own-profile';
  static const String requestChangePassword = 'users/request-change-password';
  static const String confirmChangePassword = 'users/confirm-change-password';
  static const String getCountries = 'country/get-countries';

  // Notification
  static const String getNotification = 'notifications?platform=mobile';
  static const String readNotification = 'notifications/read';
  static const String deleteNotification = 'notifications/delete';
  static const String markAllAsRead = 'notifications/mark-all-as-read';

  // Get help
  static const String getMyMessage = 'chat/get-my-message';
  static const String sendHelpMessage = 'chat/send-help-message';
}
