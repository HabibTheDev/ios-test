part of 'router_imports.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}

// Auth:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}

class FaceIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiometricController>(() => BiometricController());
  }
}

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppDrawerController>(() => AppDrawerController());
  }
}

// class NotificationBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<NotificationController>(() => NotificationController());
//   }
// }
// More:::::::::::::::::::::::::::::::::::::::::::::::::::::::
// class ProfileBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ProfileController>(() => ProfileController(ProfileService()));
//   }
// }

// Profile:::::::::::::::::::::::::::::::::::::::::::::::::::::::::
class CustomizeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomizeProfileController>(() => CustomizeProfileController());
  }
}

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}

class MyFeedbacksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(() => FeedbackController());
  }
}

// Inspection:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class InspectionFinishingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionFinishingController>(() => InspectionFinishingController());
  }
}

class InspectionReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionReportController>(() => InspectionReportController());
  }
}

// Report Issue:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class ReportIssueCarPickBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportIssueCarPickController>(() => ReportIssueCarPickController());
  }
}

class DriverInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverInfoController>(() => DriverInfoController());
  }
}

class IssueSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IssueSelectionController>(() => IssueSelectionController());
  }
}

class BasicInquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasicInquiryController>(() => BasicInquiryController());
  }
}

class TheftVandalismBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TheftVandalismController>(() => TheftVandalismController());
  }
}

class VehicleHitCollidedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleHitCollidedController>(() => VehicleHitCollidedController());
  }
}

// Explore Car:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class FilterCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterCarController>(() => FilterCarController());
  }
}

class CarDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarDetailsController>(() => CarDetailsController());
  }
}

class CarMileageAndProtectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarCheckoutController>(() => CarCheckoutController());
  }
}

// Search Vehicle:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class SearchVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchVehicleController>(() => SearchVehicleController());
  }
}

// My vehicles:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class StartDrivingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StartDrivingController>(() => StartDrivingController());
  }
}

class AdditionalDriversBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriverController>(() => DriverController());
  }
}

class SignAgreementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignAgreementController>(() => SignAgreementController());
  }
}

// Contracts:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class ContractDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractDetailsController>(() => ContractDetailsController());
  }
}

class SearchContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchContractController>(() => SearchContractController());
  }
}

class SearchFinancialHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchFinancialHistoryController>(() => SearchFinancialHistoryController());
  }
}

class AmountInHoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AmountInHoldController>(() => AmountInHoldController());
  }
}

class AllInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllInspectionController>(() => AllInspectionController());
  }
}

class ContractAgreementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContractAgreementController>(() => ContractAgreementController());
  }
}

class UpgradePlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpgradePlanController>(() => UpgradePlanController());
  }
}

class CancelContractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CancelContractController>(() => CancelContractController());
  }
}

// Request:::::::::::::::::::::::::::::::::::::::::::::::::::::::
class RequestHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestHistoryController>(() => RequestHistoryController());
  }
}

class RequestMaintenanceExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestMaintenanceExchangeController>(() => RequestMaintenanceExchangeController());
  }
}

class RequestMaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestMaintenanceController>(() => RequestMaintenanceController());
  }
}

class CarPickRequestExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestExchangeController>(() => RequestExchangeController());
  }
}

class ScheduleMaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleMaintenanceController>(() => ScheduleMaintenanceController());
  }
}

class ScheduleExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleExchangeController>(() => ScheduleExchangeController());
  }
}

// My Location:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
class LocationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationDetailsController>(() => LocationDetailsController());
  }
}

class DestinationTrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationTrackingController>(() => DestinationTrackingController());
  }
}
