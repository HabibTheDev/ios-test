import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Fleetblox Crew'**
  String get appName;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @loginMgs.
  ///
  /// In en, this message translates to:
  /// **'Log in with your email and password'**
  String get loginMgs;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get updatePassword;

  /// No description provided for @reEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get reEnterPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @canNotEmpty.
  ///
  /// In en, this message translates to:
  /// **'can\'t be empty'**
  String get canNotEmpty;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter address'**
  String get enterAddress;

  /// No description provided for @updatePassMgs.
  ///
  /// In en, this message translates to:
  /// **'Enter and confirm your new password'**
  String get updatePassMgs;

  /// No description provided for @passwordValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must be 8-20 characters long, include at least one uppercase letter, one lowercase letter, one number, and one special character.'**
  String get passwordValidation;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// No description provided for @forgotPassMgs.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive the verification code'**
  String get forgotPassMgs;

  /// No description provided for @otp.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otp;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP'**
  String get invalidOtp;

  /// No description provided for @otpMgs.
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification code to your email. Please enter the code to update your password.'**
  String get otpMgs;

  /// No description provided for @invalidEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmailAddress;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @otpMessage.
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification code to your email. Please enter the code to update your password.'**
  String get otpMessage;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enterCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get enterFullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @haveAnAcc.
  ///
  /// In en, this message translates to:
  /// **'Have an account'**
  String get haveAnAcc;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @biometric.
  ///
  /// In en, this message translates to:
  /// **'Biometric'**
  String get biometric;

  /// No description provided for @addBiometric.
  ///
  /// In en, this message translates to:
  /// **'Add biometric'**
  String get addBiometric;

  /// No description provided for @biometricMgs.
  ///
  /// In en, this message translates to:
  /// **'Turn on biometric as an additional security. You can also do this later.'**
  String get biometricMgs;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @faceIdNotFound.
  ///
  /// In en, this message translates to:
  /// **'Face ID not found'**
  String get faceIdNotFound;

  /// No description provided for @biometricAuthFailedMgs.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed! please try again.'**
  String get biometricAuthFailedMgs;

  /// No description provided for @addBiometricMgs.
  ///
  /// In en, this message translates to:
  /// **'Add biometric on your device to get this feature.'**
  String get addBiometricMgs;

  /// No description provided for @addBiometricDescription.
  ///
  /// In en, this message translates to:
  /// **'Add biometric authentication to get faster login.'**
  String get addBiometricDescription;

  /// No description provided for @selectCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Select country code'**
  String get selectCountryCode;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit app'**
  String get exitApp;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @exitAppMgs.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, the app will close.'**
  String get exitAppMgs;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get started;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get sent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get goBack;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @continueStr.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueStr;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @changes.
  ///
  /// In en, this message translates to:
  /// **'Changes'**
  String get changes;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @finishTesting.
  ///
  /// In en, this message translates to:
  /// **'Finish testing'**
  String get finishTesting;

  /// No description provided for @reCapture.
  ///
  /// In en, this message translates to:
  /// **'Recapture'**
  String get reCapture;

  /// No description provided for @uploadNew.
  ///
  /// In en, this message translates to:
  /// **'Upload new'**
  String get uploadNew;

  /// No description provided for @viewImage.
  ///
  /// In en, this message translates to:
  /// **'View image'**
  String get viewImage;

  /// No description provided for @chooseAnOption.
  ///
  /// In en, this message translates to:
  /// **'Choose an option'**
  String get chooseAnOption;

  /// No description provided for @screenTerminationMsg.
  ///
  /// In en, this message translates to:
  /// **'If you confirm then whole processes will be terminated!'**
  String get screenTerminationMsg;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get yourLocation;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @approximateTime.
  ///
  /// In en, this message translates to:
  /// **'Approximate time'**
  String get approximateTime;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @vin.
  ///
  /// In en, this message translates to:
  /// **'VIN'**
  String get vin;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @carDirection.
  ///
  /// In en, this message translates to:
  /// **'Car direction'**
  String get carDirection;

  /// No description provided for @newCarDirection.
  ///
  /// In en, this message translates to:
  /// **'New car direction'**
  String get newCarDirection;

  /// No description provided for @customizeProfile.
  ///
  /// In en, this message translates to:
  /// **'Customize profile'**
  String get customizeProfile;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My profile'**
  String get myProfile;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @enterDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Enter date of birth'**
  String get enterDateOfBirth;

  /// No description provided for @anotherProcessRunning.
  ///
  /// In en, this message translates to:
  /// **'Another process running'**
  String get anotherProcessRunning;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @doesNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Doesn\'t match'**
  String get doesNotMatch;

  /// No description provided for @successfullyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Successfully updated'**
  String get successfullyUpdated;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @biometricEnableInstruction.
  ///
  /// In en, this message translates to:
  /// **'To enable biometric login you have to login first.'**
  String get biometricEnableInstruction;

  /// No description provided for @biometricNotEnableMgs.
  ///
  /// In en, this message translates to:
  /// **'Biometric is not enabled yet to your profile.'**
  String get biometricNotEnableMgs;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @exchange.
  ///
  /// In en, this message translates to:
  /// **'Exchange'**
  String get exchange;

  /// No description provided for @startProcess.
  ///
  /// In en, this message translates to:
  /// **'Start process'**
  String get startProcess;

  /// No description provided for @noStepsFound.
  ///
  /// In en, this message translates to:
  /// **'No steps found'**
  String get noStepsFound;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @taskDetails.
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskDetails;

  /// No description provided for @task.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @inspection.
  ///
  /// In en, this message translates to:
  /// **'Inspection'**
  String get inspection;

  /// No description provided for @generalInspection.
  ///
  /// In en, this message translates to:
  /// **'General inspection'**
  String get generalInspection;

  /// No description provided for @returnInspection.
  ///
  /// In en, this message translates to:
  /// **'Return inspection'**
  String get returnInspection;

  /// No description provided for @departureInspection.
  ///
  /// In en, this message translates to:
  /// **'Departure inspection'**
  String get departureInspection;

  /// No description provided for @entryInspection.
  ///
  /// In en, this message translates to:
  /// **'Entry inspection'**
  String get entryInspection;

  /// No description provided for @inspectionTime.
  ///
  /// In en, this message translates to:
  /// **'Inspection time'**
  String get inspectionTime;

  /// No description provided for @inspectionReport.
  ///
  /// In en, this message translates to:
  /// **'Inspection report'**
  String get inspectionReport;

  /// No description provided for @provideInfo.
  ///
  /// In en, this message translates to:
  /// **'Provide info'**
  String get provideInfo;

  /// No description provided for @checklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get checklist;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @maintenanceType.
  ///
  /// In en, this message translates to:
  /// **'Maintenance type'**
  String get maintenanceType;

  /// No description provided for @maintenanceCost.
  ///
  /// In en, this message translates to:
  /// **'Maintenance cost'**
  String get maintenanceCost;

  /// No description provided for @maintenanceReceipt.
  ///
  /// In en, this message translates to:
  /// **'Maintenance receipt'**
  String get maintenanceReceipt;

  /// No description provided for @enterExpanse.
  ///
  /// In en, this message translates to:
  /// **'Enter expanse'**
  String get enterExpanse;

  /// No description provided for @reviewDamages.
  ///
  /// In en, this message translates to:
  /// **'Review damages'**
  String get reviewDamages;

  /// No description provided for @reviewReport.
  ///
  /// In en, this message translates to:
  /// **'Review report'**
  String get reviewReport;

  /// No description provided for @damageCustomization.
  ///
  /// In en, this message translates to:
  /// **'Damage customization'**
  String get damageCustomization;

  /// No description provided for @existingDamages.
  ///
  /// In en, this message translates to:
  /// **'Existing damages'**
  String get existingDamages;

  /// No description provided for @newAddedDamages.
  ///
  /// In en, this message translates to:
  /// **'New added damages'**
  String get newAddedDamages;

  /// No description provided for @addNewDamage.
  ///
  /// In en, this message translates to:
  /// **'Add new damage'**
  String get addNewDamage;

  /// No description provided for @selectDamageType.
  ///
  /// In en, this message translates to:
  /// **'Select damage type'**
  String get selectDamageType;

  /// No description provided for @selectDamageSeverity.
  ///
  /// In en, this message translates to:
  /// **'Select damage severity'**
  String get selectDamageSeverity;

  /// No description provided for @selectRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Select recommendation'**
  String get selectRecommendation;

  /// No description provided for @updateChanges.
  ///
  /// In en, this message translates to:
  /// **'Update changes'**
  String get updateChanges;

  /// No description provided for @processTerminationMgs.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, this process will be terminated.'**
  String get processTerminationMgs;

  /// No description provided for @verifyVin.
  ///
  /// In en, this message translates to:
  /// **'Verify VIN'**
  String get verifyVin;

  /// No description provided for @analyzingVin.
  ///
  /// In en, this message translates to:
  /// **'Analyzing VIN'**
  String get analyzingVin;

  /// No description provided for @analyzingVinMsg.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we process your captured images. This won\'t take long. Thank you!'**
  String get analyzingVinMsg;

  /// No description provided for @vinMatched.
  ///
  /// In en, this message translates to:
  /// **'VIN matched'**
  String get vinMatched;

  /// No description provided for @vinMatchedMsg.
  ///
  /// In en, this message translates to:
  /// **'The vehicle’s VIN is verified. Continue to the next steps of your task.'**
  String get vinMatchedMsg;

  /// No description provided for @vinNotMatched.
  ///
  /// In en, this message translates to:
  /// **'VIN not matched'**
  String get vinNotMatched;

  /// No description provided for @vinNotMatchedMsg.
  ///
  /// In en, this message translates to:
  /// **'The vehicle’s VIN is not matching. Make sure to find the appropriate car and try again.'**
  String get vinNotMatchedMsg;

  /// No description provided for @vehiclePerformance.
  ///
  /// In en, this message translates to:
  /// **'Vehicle performance'**
  String get vehiclePerformance;

  /// No description provided for @testVehiclePerformance.
  ///
  /// In en, this message translates to:
  /// **'Test vehicle performance'**
  String get testVehiclePerformance;

  /// No description provided for @vehicleImages.
  ///
  /// In en, this message translates to:
  /// **'Vehicle images'**
  String get vehicleImages;

  /// No description provided for @inspectionTerminationMgs.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, your inspection process will be terminated.'**
  String get inspectionTerminationMgs;

  /// No description provided for @reportFinishConfirmationMgs.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, your inspection process will be completed.'**
  String get reportFinishConfirmationMgs;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @addImages.
  ///
  /// In en, this message translates to:
  /// **'Add images'**
  String get addImages;

  /// No description provided for @drivingComplete.
  ///
  /// In en, this message translates to:
  /// **'Driving complete'**
  String get drivingComplete;

  /// No description provided for @vehicleCondition.
  ///
  /// In en, this message translates to:
  /// **'Vehicle condition'**
  String get vehicleCondition;

  /// No description provided for @inspectTheFollowings.
  ///
  /// In en, this message translates to:
  /// **'Inspect the followings'**
  String get inspectTheFollowings;

  /// No description provided for @finishInspecting.
  ///
  /// In en, this message translates to:
  /// **'Finish inspecting'**
  String get finishInspecting;

  /// No description provided for @inspectionResults.
  ///
  /// In en, this message translates to:
  /// **'Inspection results'**
  String get inspectionResults;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @needServicingSoon.
  ///
  /// In en, this message translates to:
  /// **'Need servicing soon'**
  String get needServicingSoon;

  /// No description provided for @requiresImmediateAttention.
  ///
  /// In en, this message translates to:
  /// **'Requires immediate attention'**
  String get requiresImmediateAttention;

  /// No description provided for @assignedBy.
  ///
  /// In en, this message translates to:
  /// **'Assigned by'**
  String get assignedBy;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @taskStatus.
  ///
  /// In en, this message translates to:
  /// **'Task status'**
  String get taskStatus;

  /// No description provided for @scrollToBottom.
  ///
  /// In en, this message translates to:
  /// **'scroll to bottom'**
  String get scrollToBottom;

  /// No description provided for @fileSelected.
  ///
  /// In en, this message translates to:
  /// **'file selected'**
  String get fileSelected;

  /// No description provided for @chatWithAdmin.
  ///
  /// In en, this message translates to:
  /// **'Chat with admin'**
  String get chatWithAdmin;

  /// No description provided for @emptyInboxMgs.
  ///
  /// In en, this message translates to:
  /// **'Connect with the admin here! Drop a message, and we\'ll get back to you ASAP'**
  String get emptyInboxMgs;

  /// No description provided for @typeHere.
  ///
  /// In en, this message translates to:
  /// **'Type here'**
  String get typeHere;

  /// No description provided for @messageCopied.
  ///
  /// In en, this message translates to:
  /// **'Message copied'**
  String get messageCopied;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get sending;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @startCapturing.
  ///
  /// In en, this message translates to:
  /// **'Start capturing'**
  String get startCapturing;

  /// No description provided for @captureExteriorImages.
  ///
  /// In en, this message translates to:
  /// **'Capture exterior images'**
  String get captureExteriorImages;

  /// No description provided for @captureCompleted.
  ///
  /// In en, this message translates to:
  /// **'Capture completed'**
  String get captureCompleted;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @licenseInfo.
  ///
  /// In en, this message translates to:
  /// **'License info'**
  String get licenseInfo;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License number'**
  String get licenseNumber;

  /// No description provided for @classStr.
  ///
  /// In en, this message translates to:
  /// **'Class'**
  String get classStr;

  /// No description provided for @expirationDate.
  ///
  /// In en, this message translates to:
  /// **'Expiration date'**
  String get expirationDate;

  /// No description provided for @issuingCountry.
  ///
  /// In en, this message translates to:
  /// **'Issuing country'**
  String get issuingCountry;

  /// No description provided for @issuingProvince.
  ///
  /// In en, this message translates to:
  /// **'Issuing province'**
  String get issuingProvince;

  /// No description provided for @updateLicense.
  ///
  /// In en, this message translates to:
  /// **'Update license'**
  String get updateLicense;

  /// No description provided for @updateLicenseMgs.
  ///
  /// In en, this message translates to:
  /// **'You will receive a verification link to verify and update your new license.'**
  String get updateLicenseMgs;

  /// No description provided for @otherInfo.
  ///
  /// In en, this message translates to:
  /// **'Other info'**
  String get otherInfo;

  /// No description provided for @passportInfo.
  ///
  /// In en, this message translates to:
  /// **'Passport info'**
  String get passportInfo;

  /// No description provided for @passportNo.
  ///
  /// In en, this message translates to:
  /// **'Passport no'**
  String get passportNo;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @updatePassport.
  ///
  /// In en, this message translates to:
  /// **'Update passport'**
  String get updatePassport;

  /// No description provided for @updatePassportMgs.
  ///
  /// In en, this message translates to:
  /// **'You will receive a verification link to verify and update your new passport.'**
  String get updatePassportMgs;

  /// No description provided for @receiveLink.
  ///
  /// In en, this message translates to:
  /// **'Receive link'**
  String get receiveLink;

  /// No description provided for @emailAddressNotFound.
  ///
  /// In en, this message translates to:
  /// **'Email address not found'**
  String get emailAddressNotFound;

  /// No description provided for @lowDamage.
  ///
  /// In en, this message translates to:
  /// **'Low damage'**
  String get lowDamage;

  /// No description provided for @highDamage.
  ///
  /// In en, this message translates to:
  /// **'High damage'**
  String get highDamage;

  /// No description provided for @finalSummary.
  ///
  /// In en, this message translates to:
  /// **'Final summary'**
  String get finalSummary;

  /// No description provided for @departureInspectionBy.
  ///
  /// In en, this message translates to:
  /// **'Departure inspection by'**
  String get departureInspectionBy;

  /// No description provided for @returnInspectionBy.
  ///
  /// In en, this message translates to:
  /// **'Return inspection by'**
  String get returnInspectionBy;

  /// No description provided for @totalReportedIssues.
  ///
  /// In en, this message translates to:
  /// **'Total reported issues'**
  String get totalReportedIssues;

  /// No description provided for @totalMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Total maintenance'**
  String get totalMaintenance;

  /// No description provided for @carHealth.
  ///
  /// In en, this message translates to:
  /// **'Car health'**
  String get carHealth;

  /// No description provided for @departure.
  ///
  /// In en, this message translates to:
  /// **'Departure'**
  String get departure;

  /// No description provided for @odometerReading.
  ///
  /// In en, this message translates to:
  /// **'Odometer reading'**
  String get odometerReading;

  /// No description provided for @fuelTankLevel.
  ///
  /// In en, this message translates to:
  /// **'Fuel tank level'**
  String get fuelTankLevel;

  /// No description provided for @engineOilLife.
  ///
  /// In en, this message translates to:
  /// **'Engine oil life'**
  String get engineOilLife;

  /// No description provided for @tirePressure.
  ///
  /// In en, this message translates to:
  /// **'Tire pressure'**
  String get tirePressure;

  /// No description provided for @returnStr.
  ///
  /// In en, this message translates to:
  /// **'Return'**
  String get returnStr;

  /// No description provided for @regularServicing.
  ///
  /// In en, this message translates to:
  /// **'Regular servicing'**
  String get regularServicing;

  /// No description provided for @maintainedBy.
  ///
  /// In en, this message translates to:
  /// **'Maintained by'**
  String get maintainedBy;

  /// No description provided for @inspectedBy.
  ///
  /// In en, this message translates to:
  /// **'Inspected by'**
  String get inspectedBy;

  /// No description provided for @captureTheFollowings.
  ///
  /// In en, this message translates to:
  /// **'Capture the followings'**
  String get captureTheFollowings;

  /// No description provided for @processingImages.
  ///
  /// In en, this message translates to:
  /// **'Processing images'**
  String get processingImages;

  /// No description provided for @processingImageMgs.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we process your images. This won\'t take long. Thank you!'**
  String get processingImageMgs;

  /// No description provided for @exteriorCondition.
  ///
  /// In en, this message translates to:
  /// **'Exterior condition'**
  String get exteriorCondition;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic info'**
  String get basicInfo;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @backLeft.
  ///
  /// In en, this message translates to:
  /// **'Back left'**
  String get backLeft;

  /// No description provided for @backRight.
  ///
  /// In en, this message translates to:
  /// **'Back right'**
  String get backRight;

  /// No description provided for @frontLeft.
  ///
  /// In en, this message translates to:
  /// **'Front left'**
  String get frontLeft;

  /// No description provided for @frontRight.
  ///
  /// In en, this message translates to:
  /// **'Front right'**
  String get frontRight;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// No description provided for @expanse.
  ///
  /// In en, this message translates to:
  /// **'Expanse'**
  String get expanse;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @selectRepairedDamages.
  ///
  /// In en, this message translates to:
  /// **'Select repaired damages'**
  String get selectRepairedDamages;

  /// No description provided for @vehicleParts.
  ///
  /// In en, this message translates to:
  /// **'Vehicle parts'**
  String get vehicleParts;

  /// No description provided for @damagesRequired.
  ///
  /// In en, this message translates to:
  /// **'Damages required'**
  String get damagesRequired;

  /// No description provided for @noDamage.
  ///
  /// In en, this message translates to:
  /// **'No damage'**
  String get noDamage;

  /// No description provided for @noDamageFound.
  ///
  /// In en, this message translates to:
  /// **'No damage found'**
  String get noDamageFound;

  /// No description provided for @damages.
  ///
  /// In en, this message translates to:
  /// **'Damages'**
  String get damages;

  /// No description provided for @newStr.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStr;

  /// No description provided for @poor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get poor;

  /// No description provided for @fair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get fair;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get excellent;

  /// No description provided for @damagesToRepair.
  ///
  /// In en, this message translates to:
  /// **'Damages to repair'**
  String get damagesToRepair;

  /// No description provided for @overall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get overall;

  /// No description provided for @totalPartsDetected.
  ///
  /// In en, this message translates to:
  /// **'Total parts detected'**
  String get totalPartsDetected;

  /// No description provided for @damagesFound.
  ///
  /// In en, this message translates to:
  /// **'Damages found'**
  String get damagesFound;

  /// No description provided for @missingParts.
  ///
  /// In en, this message translates to:
  /// **'Missing parts'**
  String get missingParts;

  /// No description provided for @invalidScore.
  ///
  /// In en, this message translates to:
  /// **'Invalid score'**
  String get invalidScore;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @pendingTasks.
  ///
  /// In en, this message translates to:
  /// **'Pending tasks'**
  String get pendingTasks;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @readyForYourTask.
  ///
  /// In en, this message translates to:
  /// **'Ready for your task'**
  String get readyForYourTask;

  /// No description provided for @todaysTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s tasks'**
  String get todaysTasks;

  /// No description provided for @searchYourTasks.
  ///
  /// In en, this message translates to:
  /// **'Search your tasks'**
  String get searchYourTasks;

  /// No description provided for @searchTaskMgs.
  ///
  /// In en, this message translates to:
  /// **'Enter a task name, date, or time to quickly find your specific task.'**
  String get searchTaskMgs;

  /// No description provided for @itemFound.
  ///
  /// In en, this message translates to:
  /// **'Item found'**
  String get itemFound;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get searchHere;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure'**
  String get areYouSure;

  /// No description provided for @logoutMessage.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, you will be logged out from the app.'**
  String get logoutMessage;

  /// No description provided for @deleteMessage.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, the selected item will be deleted'**
  String get deleteMessage;

  /// No description provided for @damageUpdateFailedMsg.
  ///
  /// In en, this message translates to:
  /// **'Damage update failed! Please try again'**
  String get damageUpdateFailedMsg;

  /// No description provided for @damageUpdateSuccessMsg.
  ///
  /// In en, this message translates to:
  /// **'Damage updated successfully'**
  String get damageUpdateSuccessMsg;

  /// No description provided for @missingDamageDataMsg.
  ///
  /// In en, this message translates to:
  /// **'Missing damage data!'**
  String get missingDamageDataMsg;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @notVerified.
  ///
  /// In en, this message translates to:
  /// **'Not verified'**
  String get notVerified;

  /// No description provided for @viewProfile.
  ///
  /// In en, this message translates to:
  /// **'View profile'**
  String get viewProfile;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write here'**
  String get writeHere;

  /// No description provided for @enterIssue.
  ///
  /// In en, this message translates to:
  /// **'Enter issue'**
  String get enterIssue;

  /// No description provided for @incompleteTask.
  ///
  /// In en, this message translates to:
  /// **'Incomplete Task'**
  String get incompleteTask;

  /// No description provided for @addressNotFound.
  ///
  /// In en, this message translates to:
  /// **'Address not found'**
  String get addressNotFound;

  /// No description provided for @incompleteTaskMgs.
  ///
  /// In en, this message translates to:
  /// **'You have incomplete tasks. Report an issue about it.'**
  String get incompleteTaskMgs;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @allNotifications.
  ///
  /// In en, this message translates to:
  /// **'All notifications'**
  String get allNotifications;

  /// No description provided for @issue.
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get issue;

  /// No description provided for @reportIssue.
  ///
  /// In en, this message translates to:
  /// **'Report issue'**
  String get reportIssue;

  /// No description provided for @viewReportedIssueTooltip.
  ///
  /// In en, this message translates to:
  /// **'Tap here to view the reported issue.'**
  String get viewReportedIssueTooltip;

  /// No description provided for @reportIssueTooltip.
  ///
  /// In en, this message translates to:
  /// **'Report any major issue if you\'re unable to continue the task.\nNote: For minor issues, contact your admin via message for instructions.'**
  String get reportIssueTooltip;

  /// No description provided for @reportedIssue.
  ///
  /// In en, this message translates to:
  /// **'Reported issue'**
  String get reportedIssue;

  /// No description provided for @viewIssue.
  ///
  /// In en, this message translates to:
  /// **'View issue'**
  String get viewIssue;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @selectServicedAreas.
  ///
  /// In en, this message translates to:
  /// **'Select serviced areas'**
  String get selectServicedAreas;

  /// No description provided for @viewReport.
  ///
  /// In en, this message translates to:
  /// **'View report'**
  String get viewReport;

  /// No description provided for @pullUpLoad.
  ///
  /// In en, this message translates to:
  /// **'Pull up load'**
  String get pullUpLoad;

  /// No description provided for @loadFailed.
  ///
  /// In en, this message translates to:
  /// **'PLoad failed! Click retry'**
  String get loadFailed;

  /// No description provided for @releaseToLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Release to load more'**
  String get releaseToLoadMore;

  /// No description provided for @noMoreData.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get noMoreData;

  /// No description provided for @awaitingForApproval.
  ///
  /// In en, this message translates to:
  /// **'Awaiting for approval'**
  String get awaitingForApproval;

  /// No description provided for @finishAndEndProcess.
  ///
  /// In en, this message translates to:
  /// **'Finish & end process'**
  String get finishAndEndProcess;

  /// No description provided for @finishAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Finish & continue'**
  String get finishAndContinue;

  /// No description provided for @goToNextStep.
  ///
  /// In en, this message translates to:
  /// **'Go to the next step'**
  String get goToNextStep;

  /// No description provided for @goToNextStepMgs.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, you will move to next step'**
  String get goToNextStepMgs;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @signingComplete.
  ///
  /// In en, this message translates to:
  /// **'Signing complete'**
  String get signingComplete;

  /// No description provided for @signingCompleteMgs.
  ///
  /// In en, this message translates to:
  /// **'If you proceed, you will move to next step'**
  String get signingCompleteMgs;

  /// No description provided for @completeTask.
  ///
  /// In en, this message translates to:
  /// **'Complete task'**
  String get completeTask;

  /// No description provided for @completedTask.
  ///
  /// In en, this message translates to:
  /// **'Completed task'**
  String get completedTask;

  /// No description provided for @completeTaskMgs.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you\'ll finish the task and conclude the process.'**
  String get completeTaskMgs;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
