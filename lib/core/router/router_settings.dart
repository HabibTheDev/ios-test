part of 'router_imports.dart';

class GeneratedPages {
  static List<GetPage> pages = [
    GetPage(name: RouterPaths.initializer, page: () => const SplashScreen(), transition: Transition.fadeIn),

    //Auth::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.login,
      page: () => const Login(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: RouterPaths.signUp,
    //   page: () => const Signup(),
    //   binding: SignupBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: RouterPaths.addBiometric,
      page: () => const AddBiometric(),
      binding: FaceIdBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.forgotPassword,
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: RouterPaths.otpScreen, page: () => const OtpScreen(), transition: Transition.rightToLeft),
    GetPage(name: RouterPaths.updatePassword, page: () => const UpdatePassword(), transition: Transition.rightToLeft),

    //Drawer::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.drawer,
      page: () => const AppDrawerScreen(),
      binding: DrawerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouterPaths.search,
      page: () => const SearchTask(),
      binding: SearchBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: RouterPaths.notification, page: () => const Notification(), transition: Transition.rightToLeft),
    GetPage(
      name: RouterPaths.inProgress,
      page: () => const InProgress(),
      binding: InProgressBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.pendingTasks,
      page: () => const PendingTasks(),
      binding: PendingTasksBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.completedTasks,
      page: () => const CompletedTask(),
      binding: CompletedTasksBinding(),
      transition: Transition.rightToLeft,
    ),

    //More::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.myProfile,
      page: () => const MyProfile(),
      // binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.customizeProfile,
      page: () => const CustomizeProfile(),
      binding: CustomizeProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.changePassword,
      page: () => const ChangePassword(),
      binding: ChangePasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.changePasswordOtp,
      page: () => const ChangePassOtpScreen(),
      transition: Transition.rightToLeft,
    ),

    //Task Details::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.generalTask,
      page: () => const GeneralTask(),
      binding: GeneralTaskBinding(),
      transition: Transition.rightToLeft,
    ),

    //Maintenance::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.maintenanceTask,
      page: () => const Maintenance(),
      binding: MaintenanceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.carDirection,
      page: () => const CarDirection(),
      binding: CarDirectionBinding(),
      transition: Transition.rightToLeft,
    ),

    //Entry Inspection::::::::::::::::::::::
    GetPage(
      name: RouterPaths.entryInspection,
      page: () => const EntryInspection(),
      binding: EntryInspectionBinding(),
      transition: Transition.rightToLeft,
    ),

    //General Inspection::::::::::::::::::::::
    GetPage(
      name: RouterPaths.generalInspection,
      page: () => const GeneralInspection(),
      binding: GeneralInspectionBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: RouterPaths.vehiclePerformance,
      page: () => const VehiclePerformance(),
      binding: VehiclePerformanceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.carStationarySteps,
      page: () => const CarStationarySteps(),
      binding: CarStationaryStepsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.carRunningSteps,
      page: () => const CarRunningSteps(),
      binding: CarRunningStepsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.vehicleCondition,
      page: () => const VehicleCondition(),
      binding: VehicleConditionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.inspectionResults,
      page: () => const InspectionResults(),
      binding: InspectionResultsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.generalInspectionReport,
      page: () => const GeneralInspectionReport(),
      binding: GeneralInspectionReportBinding(),
      transition: Transition.rightToLeft,
    ),

    //Inspection:::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.captureVin,
      page: () => const CaptureVin(),
      binding: CaptureVinBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: RouterPaths.analyzingVin, page: () => const AnalyzingVin(), transition: Transition.rightToLeft),
    GetPage(
      name: RouterPaths.carExteriorReport,
      page: () => const CarExteriorReport(),
      binding: CarExteriorReportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.damageCustomization,
      page: () => const DamageCustomization(),
      binding: DamageCustomizationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.inspectionCaptureType,
      page: () => const InspectionCaptureType(),
      binding: InspectionCaptureTypeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.captureInspectionImage,
      page: () => const CaptureInspectionImage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.carExteriorInstruction,
      page: () => const CarExteriorCaptureInstruction(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.processingImage,
      page: () => const ProcessingImage(),
      binding: ProcessingImageBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.reviewReport,
      page: () => const ReviewReport(),
      binding: ReviewReportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.finalSummary,
      page: () => const FinalSummary(),
      binding: FinalSummaryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.chatWithTaskAssignee,
      page: () => const ChatWithAdmin(),
      transition: Transition.rightToLeft,
    ),

    //Exchange:::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.exchange,
      page: () => const Exchange(),
      binding: ExchangeBinding(),
      transition: Transition.rightToLeft,
    ),

    //Handover:::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.handover,
      page: () => const Handover(),
      binding: HandoverBinding(),
      transition: Transition.rightToLeft,
    ),

    //Return:::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.returnTask,
      page: () => const ReturnTask(),
      binding: ReturnBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(name: RouterPaths.filePreview, page: () => const FilePreviewScreen(), transition: Transition.fade),
  ];
}
