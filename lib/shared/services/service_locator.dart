import 'package:get_it/get_it.dart';

import '../repository/local/date_time_repo.dart';
import '../repository/local/debounce_repo.dart';
import '../repository/local/local_storage_repo.dart';
import '../repository/local/media_repo.dart';
import '../repository/local/orientation_repo.dart';
import '../repository/remote/auth_repo.dart';
import '../repository/remote/car_direction_repo.dart';
import '../repository/remote/change_password_repo.dart';
import '../repository/remote/crashlytics_repo.dart';
import '../repository/remote/damage_customization_repo.dart';
import '../repository/remote/drawer_repo.dart';
import '../repository/remote/forgot_password_repo.dart';
import '../repository/remote/inbox_repo.dart';
import '../repository/remote/inspection_repo.dart';
import '../repository/remote/my_task_repo.dart';
import '../repository/remote/notification_repo.dart';
import '../repository/remote/profile_repo.dart';
import '../repository/remote/single_task_repo.dart';

import 'local/date_time_service.dart';
import 'local/debounce_service.dart';
import 'local/local_storage_service.dart';
import 'local/media_service.dart';
import 'local/orientation_service.dart';
import 'remote/auth_service.dart';
import 'remote/car_direction_service.dart';
import 'remote/change_password_service.dart';
import 'remote/crashlytics_service.dart';
import 'remote/damage_customization_service.dart';
import 'remote/drawer_service.dart';
import 'remote/forgot_password_service.dart';
import 'remote/inbox_service.dart';
import 'remote/inspection_service.dart';
import 'remote/my_task_service.dart';
import 'remote/notification_service.dart';
import 'remote/profile_service.dart';
import 'remote/single_task_service.dart';

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
    _getIt.registerLazySingleton<DateTimeRepo>(() => DateTimeService());
    _getIt.registerLazySingleton<DebounceRepo>(() => DebounceService());
    _getIt.registerLazySingleton<LocalStorageRepo>(() => LocalStorageService());
    _getIt.registerLazySingleton<MediaRepo>(() => MediaService());
    _getIt.registerLazySingleton<OrientationRepo>(() => OrientationService());
  }

  // Remote services
  static void _initRemoteServices() {
    _getIt.registerLazySingleton<AuthRepo>(() => AuthService());
    _getIt.registerLazySingleton<CarDirectionRepo>(() => CarDirectionService());
    _getIt.registerLazySingleton<ChangePasswordRepo>(() => ChangePasswordService());
    _getIt.registerLazySingleton<CrashlyticsRepo>(() => CrashlyticsService());
    _getIt.registerLazySingleton<DrawerRepo>(() => DrawerService());
    _getIt.registerLazySingleton<ForgotPasswordRepo>(() => ForgotPasswordService());
    _getIt.registerLazySingleton<InboxRepo>(() => InboxService());
    _getIt.registerLazySingleton<InspectionRepo>(() => InspectionService());
    _getIt.registerLazySingleton<DamageCustomizationRepo>(() => DamageCustomizationService());
    _getIt.registerLazySingleton<MyTaskRepo>(() => MyTaskService());
    _getIt.registerLazySingleton<NotificationRepo>(() => NotificationService());
    _getIt.registerLazySingleton<ProfileRepo>(() => ProfileService());
    _getIt.registerLazySingleton<SingleTaskRepo>(() => SingleTaskService());
  }
}
