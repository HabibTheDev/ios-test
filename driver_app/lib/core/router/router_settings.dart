part of 'router_imports.dart';

class GeneratedPages {
  static List<GetPage> pages = [
    GetPage(
      name: RouterPaths.initializer,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouterPaths.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
      transition: Transition.fadeIn,
    ),

    // Auth::::::::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.login,
      page: () => const Login(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.signUp,
      page: () => const SignUp(),
      binding: SignUpBinding(),
      transition: Transition.rightToLeft,
    ),
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
    GetPage(
      name: RouterPaths.otpScreen,
      page: () => const OtpScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.updatePassword,
      page: () => const UpdatePassword(),
      transition: Transition.rightToLeft,
    ),

    //Drawer::::::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.drawer,
      page: () => const AppDrawerScreen(),
      binding: DrawerBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouterPaths.notification,
      page: () => const Notification(),
      // binding: NotificationBinding(),
      transition: Transition.rightToLeft,
    ),

    // More:::::::::::::::::::::::::::::::::
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
    GetPage(
      name: RouterPaths.cardInfo,
      page: () => const CardInfo(),
      transition: Transition.rightToLeft,
    ),

    // Feedbacks:::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.myFeedbacks,
      page: () => const MyFeedbacks(),
      binding: MyFeedbacksBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.pickFeedbackCar,
      page: () => const PickFeedbackCar(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.giveFeedback,
      page: () => const GiveFeedback(),
      transition: Transition.rightToLeft,
    ),

    // My locations::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.locationDetails,
      page: () => const LocationDetails(),
      binding: LocationDetailsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.destinationTracking,
      page: () => const DestinationTracking(),
      binding: DestinationTrackingBinding(),
      transition: Transition.rightToLeft,
    ),

    // Inspection:::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.captureInspectionImage,
      page: () => const CaptureInspectionImage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.captureImageInstruction,
      page: () => const CaptureImageInstruction(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.processingImage,
      page: () => const ProcessingImage(),
      binding: InspectionReportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.inspectionFinishing,
      page: () => const InspectionFinishing(),
      binding: InspectionFinishingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.inspectionReport,
      page: () => const InspectionReport(),
      transition: Transition.rightToLeft,
    ),

    // Report Issue::::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.reportIssueCarPick,
      page: () => const ReportIssueCarPick(),
      binding: ReportIssueCarPickBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.driverInfoSelection,
      page: () => const DriverInfoSelection(),
      binding: DriverInfoBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.issueSelection,
      page: () => const IssueSelection(),
      binding: IssueSelectionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.basicInquirySelection,
      page: () => const BasicInquirySelection(),
      binding: BasicInquiryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.theftVandalismSelection,
      page: () => const TheftVandalismSelection(),
      binding: TheftVandalismBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.vehicleHitCollidedSelection,
      page: () => const VehicleHitCollidedSelection(),
      binding: VehicleHitCollidedBinding(),
      transition: Transition.rightToLeft,
    ),

    // Explore car:::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.filterCar,
      page: () => const FilterCar(),
      binding: FilterCarBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.carDetails,
      page: () => const CarDetails(),
      binding: CarDetailsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.mileageAndProtection,
      page: () => const MileageAndProtection(),
      binding: CarMileageAndProtectionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.driverAndExtra,
      page: () => const DriverAndExtra(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.checkoutPolicies,
      page: () => const CheckoutPolicies(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.checkoutOverview,
      page: () => const CheckoutOverview(),
      transition: Transition.rightToLeft,
    ),

    // Search Vehicle::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.searchVehicle,
      page: () => const SearchVehicle(),
      binding: SearchVehicleBinding(),
      transition: Transition.rightToLeft,
    ),

    // My Vehicle::::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.startDriving,
      page: () => const StartDriving(),
      binding: StartDrivingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.additionalDrivers,
      page: () => const AdditionalDrivers(),
      binding: AdditionalDriversBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.addDrivers,
      page: () => const AddDrivers(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.editDriverAccess,
      page: () => const EditDriverAccess(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.signAgreement,
      page: () => const SignAgreement(),
      binding: SignAgreementBinding(),
      transition: Transition.rightToLeft,
    ),

    // Contract::::::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.contractDetails,
      page: () => const ContractDetails(),
      binding: ContractDetailsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.searchContract,
      page: () => const SearchContract(),
      binding: SearchContractBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.searchFinancialHistory,
      page: () => const SearchFinancialHistory(),
      binding: SearchFinancialHistoryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.amountInHold,
      page: () => const AmountInHold(),
      binding: AmountInHoldBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.allInspection,
      page: () => const AllInspections(),
      binding: AllInspectionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.contractAgreement,
      page: () => const ContractAgreement(),
      binding: ContractAgreementBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.upgradePlan,
      page: () => const UpgradePlan(),
      binding: UpgradePlanBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.upgradePlanSummary,
      page: () => const UpgradePlanSummary(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.cancelContract,
      page: () => const CancelContract(),
      binding: CancelContractBinding(),
      transition: Transition.rightToLeft,
    ),

    // Request::::::::::::::::::::::::::::::::
    GetPage(
      name: RouterPaths.requestHistory,
      page: () => const RequestHistory(),
      binding: RequestHistoryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.requestMaintenanceExchange,
      page: () => const RequestMaintenanceExchange(),
      binding: RequestMaintenanceExchangeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.requestMaintenance,
      page: () => const RequestMaintenance(),
      binding: RequestMaintenanceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.carPickRequestExchange,
      page: () => const CarPickRequestExchange(),
      binding: CarPickRequestExchangeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.requestExchange,
      page: () => const RequestExchange(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.scheduleMaintenance,
      page: () => const ScheduleMaintenance(),
      binding: ScheduleMaintenanceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouterPaths.scheduleExchange,
      page: () => const ScheduleExchange(),
      binding: ScheduleExchangeBinding(),
      transition: Transition.rightToLeft,
    ),

    // Get Help
    GetPage(
      name: RouterPaths.filePreview,
      page: () => const FilePreviewScreen(),
      transition: Transition.fade,
    ),
  ];
}
