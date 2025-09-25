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
  // static const String sentryDsn = SENTRY_DSN;

  static late String apiBaseUrl;
  static late String socketUrl;
  static late String aiBaseUrl;
  static late String envName;

  static const String mapDirectionsUrl = 'https://maps.googleapis.com/maps/api/directions/json?';
  static const String mapGeocodeUrl = 'https://maps.googleapis.com/maps/api/geocode/json?';
  static const String mapSnapToRoadsUrl = 'https://roads.googleapis.com/v1/snapToRoads?';

  static late Env _env;
  static Env get env => _env;

  static void setupEnv(Env environment) {
    _env = environment;

    switch (environment) {
      case Env.prod:
        envName = Env.prod.name;
        apiBaseUrl = 'https://api.fleetblox.com/api/';
        socketUrl = 'https://api.fleetblox.com';
        aiBaseUrl = 'https://car-damage.fleetblox.com/';
        break;

      case Env.dev:
        envName = Env.dev.name;
        apiBaseUrl = 'https://dev-api.fleetblox.com/api/';
        socketUrl = 'https://dev-api.fleetblox.com';
        aiBaseUrl = 'https://car-damage.fleetblox.com/';
        break;
    }
  }
}
