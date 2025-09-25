part of 'router_imports.dart';

// Authentication:::::::::::::::::::::::::::::::::::::
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        authRepo: ServiceLocator.get<AuthRepo>(),
        localStorageRepo: ServiceLocator.get<LocalStorageRepo>(),
      ),
    );
  }
}

class FaceIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BiometricController>(
      () => BiometricController(
        authRepo: ServiceLocator.get<AuthRepo>(),
        localStorageRepo: ServiceLocator.get<LocalStorageRepo>(),
      ),
    );
  }
}

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(forgotPasswordRepo: ServiceLocator.get<ForgotPasswordRepo>()),
    );
  }
}

class DrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppDrawerController>(() => AppDrawerController());
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskSearchController>(
      () => TaskSearchController(
        debounceRepo: ServiceLocator.get<DebounceRepo>(),
        myTaskRepo: ServiceLocator.get<MyTaskRepo>(),
      ),
    );
  }
}

class InProgressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InProgressController>(() => InProgressController(myTaskRepo: ServiceLocator.get<MyTaskRepo>()));
  }
}

class PendingTasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingTasksController>(() => PendingTasksController(myTaskRepo: ServiceLocator.get<MyTaskRepo>()));
  }
}

class CompletedTasksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompletedTasksController>(() => CompletedTasksController());
  }
}

// More
// class ProfileBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<ProfileController>(() => ProfileController(ProfileService()));
//   }
// }

class CustomizeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomizeProfileController>(
      () => CustomizeProfileController(
        profileRepo: ServiceLocator.get<ProfileRepo>(),
        dateTimeRepo: ServiceLocator.get<DateTimeRepo>(),
        mediaRepo: ServiceLocator.get<MediaRepo>(),
      ),
    );
  }
}

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(changePassRepo: ServiceLocator.get<ChangePasswordRepo>()),
    );
  }
}

// Task Details
class GeneralTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralTaskController>(
      () => GeneralTaskController(singleTaskRepo: ServiceLocator.get<SingleTaskRepo>()),
    );
  }
}

// Maintenance
class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceController>(
      () => MaintenanceController(
        singleTaskRepo: ServiceLocator.get<SingleTaskRepo>(),
        mediaRepo: ServiceLocator.get<MediaRepo>(),
      ),
    );
  }
}

class CarDirectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarDirectionController>(
      () => CarDirectionController(carDirectionRepo: ServiceLocator.get<CarDirectionRepo>()),
    );
  }
}

// Entry Inspection
class EntryInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EntryInspectionController>(
      () => EntryInspectionController(
        singleTaskRepo: ServiceLocator.get<SingleTaskRepo>(),
        orientationRepo: ServiceLocator.get<OrientationRepo>(),
      ),
    );
  }
}

// General Inspection
class GeneralInspectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralInspectionController>(
      () => GeneralInspectionController(singleTaskRepo: ServiceLocator.get<SingleTaskRepo>()),
    );
  }
}

class VehiclePerformanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehiclePerformanceController>(() => VehiclePerformanceController());
  }
}

class CarStationaryStepsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarStationaryStepsController>(() => CarStationaryStepsController());
  }
}

class CarRunningStepsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarRunningStepsController>(() => CarRunningStepsController());
  }
}

class VehicleConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleConditionController>(() => VehicleConditionController());
  }
}

class InspectionResultsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionResultsController>(() => InspectionResultsController());
  }
}

class GeneralInspectionReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralInspectionReportController>(() => GeneralInspectionReportController());
  }
}

// Inspection

class CaptureVinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyVinController>(
      () => VerifyVinController(
        inspectionRepo: ServiceLocator.get<InspectionRepo>(),
        orientationRepo: ServiceLocator.get<OrientationRepo>(),
      ),
    );
  }
}

class CarExteriorReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarExteriorReportController>(
      () => CarExteriorReportController(inspectionRepo: ServiceLocator.get<InspectionRepo>()),
    );
  }
}

class DamageCustomizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DamageCustomizationController>(
      () => DamageCustomizationController(damageCustomizationRepo: ServiceLocator.get<DamageCustomizationRepo>()),
    );
  }
}

class InspectionCaptureTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionCaptureController>(
      () => InspectionCaptureController(
        inspectionRepo: ServiceLocator.get<InspectionRepo>(),
        mediaRepo: ServiceLocator.get<MediaRepo>(),
      ),
    );
  }
}

class ProcessingImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProcessingImageController>(
      () => ProcessingImageController(inspectionRepo: ServiceLocator.get<InspectionRepo>()),
    );
  }
}

class ReviewReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewReportController>(
      () => ReviewReportController(inspectionRepo: ServiceLocator.get<InspectionRepo>()),
    );
  }
}

class FinalSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinalSummaryController>(
      () => FinalSummaryController(inspectionRepo: ServiceLocator.get<InspectionRepo>()),
    );
  }
}

// Exchange
class ExchangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeController>(() => ExchangeController(singleTaskRepo: ServiceLocator.get<SingleTaskRepo>()));
  }
}

// Handover
class HandoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HandoverController>(() => HandoverController(singleTaskRepo: ServiceLocator.get<SingleTaskRepo>()));
  }
}

// Return
class ReturnBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReturnController>(() => ReturnController(singleTaskRepo: ServiceLocator.get<SingleTaskRepo>()));
  }
}
