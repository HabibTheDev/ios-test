import 'env.dart';

enum Env {
  dev('dev'),
  prod('prod');

  final String name;
  const Env(this.name);
}

abstract class AppFlavor {
  static const String aiJWT = AI_JWT_TOKEN;
  static const String mapApiKey = MAP_KEY;
  static const String sentryDsn = SENTRY_DSN;

  static late String apiBaseUrl;
  static late String socketBaseUrl;
  static late String aiBaseUrl;
  static late String envName;

  static const String mapDirectionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  static const String mapGeoodeUrl = 'https://maps.googleapis.com/maps/api/geocode/json?';

  static late Env _env;
  static Env get env => _env;

  static setupEnv(Env environment) {
    _env = environment;

    switch (environment) {
      case Env.prod:
        envName = Env.prod.name;
        apiBaseUrl = 'https://api.fleetblox.com/api/';
        socketBaseUrl = 'https://api.fleetblox.com';
        aiBaseUrl = 'https://car-damage.illama360.com/';
        break;

      case Env.dev:
        envName = Env.dev.name;
        apiBaseUrl = 'https://backend.illama360.com/api/';
        socketBaseUrl = 'https://backend.illama360.com';
        aiBaseUrl = 'https://car-damage.illama360.com/';
        break;
    }
  }
}
