import 'package:get_it/get_it.dart';

import 'local/date_time_service.dart';
import 'local/local_storage_service.dart';
import 'local/media_service.dart';
import 'local/orientation_service.dart';
import 'local/time_service.dart';

import 'remote/auth_service.dart';
import 'remote/car_checkout_service.dart';
import 'remote/change_password_service.dart';
import 'remote/collisions_service.dart';
import 'remote/contract_details_service.dart';
import 'remote/contracts_service.dart';
import 'remote/drawer_service.dart';
import 'remote/explore_cars_service.dart';
import 'remote/feedback_service.dart';
import 'remote/forgot_password_service.dart';
import 'remote/get_help_service.dart';
import 'remote/more_service.dart';
import 'remote/my_location_service.dart';
import 'remote/my_vehicles_service.dart';
import 'remote/notification_service.dart';
import 'remote/profile_service.dart';

import '../repository/remote/car_checkout_repo.dart';
import '../repository/remote/collisions_repo.dart';
import '../repository/remote/contract_details_repo.dart';
import '../repository/remote/contracts_repo.dart';
import '../repository/remote/explore_cars_repo.dart';
import '../repository/remote/feedback_repo.dart';
import '../repository/remote/get_help_repo.dart';
import '../repository/remote/more_repo.dart';
import '../repository/remote/my_location_repo.dart';
import '../repository/remote/auth_repo.dart';
import '../repository/remote/change_password_repo.dart';
import '../repository/remote/drawer_repo.dart';
import '../repository/remote/forgot_password_repo.dart';
import '../repository/remote/notification_repo.dart';
import '../repository/remote/profile_repo.dart';
import '../repository/remote/my_vehicles_repo.dart';

import '../repository/local/date_time_repo.dart';
import '../repository/local/local_storage_repo.dart';
import '../repository/local/media_repo.dart';
import '../repository/local/orientation_repo.dart';
import '../repository/local/time_repo.dart';

class ServiceLocator {
  static final GetIt _getIt = GetIt.instance;

  // Get Services
  static T get<T extends Object>() => _getIt<T>();

  // Locate services
  static void initServices() {
    _initLocalServices();
    _initRemoteServices();
  }

  // Local services
  static void _initLocalServices() {
    _getIt.registerLazySingleton<LocalStorageRepo>(() => LocalStorageService());
    _getIt.registerLazySingleton<DateTimeRepo>(() => DateTimeService());
    _getIt.registerLazySingleton<MediaRepo>(() => MediaService());
    _getIt.registerLazySingleton<OrientationRepo>(() => OrientationService());
    _getIt.registerLazySingleton<TimeRepo>(() => TimeService());
  }

  // Remote services
  static void _initRemoteServices() {
    _getIt.registerLazySingleton<AuthRepo>(() => AuthService());
    _getIt.registerLazySingleton<CarCheckoutRepo>(() => CarCheckoutService());
    _getIt.registerLazySingleton<ChangePasswordRepo>(() => ChangePasswordService());
    _getIt.registerLazySingleton<CollisionsRepo>(() => CollisionsService());
    _getIt.registerLazySingleton<ContractDetailsRepo>(() => ContractDetailsService());
    _getIt.registerLazySingleton<ContractsRepo>(() => ContractsService());
    _getIt.registerLazySingleton<DrawerRepo>(() => DrawerService());
    _getIt.registerLazySingleton<ExploreCarsRepo>(() => ExploreCarsService());
    _getIt.registerLazySingleton<FeedbackRepo>(() => FeedbackService());
    _getIt.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordService());
    _getIt.registerLazySingleton<GetHelpRepo>(() => GetHelpService());
    _getIt.registerLazySingleton<MoreRepo>(() => MoreService());
    _getIt.registerLazySingleton<MyLocationRepo>(() => MyLocationService());
    _getIt.registerLazySingleton<MyVehiclesRepo>(() => MyVehiclesService());
    _getIt.registerLazySingleton<NotificationRepo>(() => NotificationService());
    _getIt.registerLazySingleton<ProfileRepo>(() => ProfileService());
  }
}
