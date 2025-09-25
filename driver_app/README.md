# driver_app
Fleetblox App for drivers.

## Preferred environment versions
- Flutter: 3.27.2
- JDK: 17.0.12
- Android Studio: Ladybug Feature Drop | 2024.2.2
- Xcode: Version 16.2 (16C5032a)
- Swift Language Version: Swift 5

## Generate localizations command
- If you want to add new localization variables then go to this `lib/l10n` directory and add required variables to this `app_en.arb` (for english) file.
- Now run this following command to generate Localizations.
- `flutter gen-l10n`

## Env setup
Create `env.dart` file inside the `lib` directory and create variables with name:
- `AI_JWT_TOKEN`
- `MAP_KEY`
- `SENTRY_DSN`

Then put the valid credentials into these variables.

## Install FlutterFire CLI and Configure Firebase

To install FlutterFire CLI.

- `dart pub global activate flutterfire_cli`

## Some necessary commands

#### Dev apk build command
- `flutter build apk --flavor dev --target lib/main_dev.dart`

#### Dev iOS build command
- `flutter build ios --verbose --flavor dev --target lib/main_dev.dart`

#### Dev apk with code obfuscation (Recommended)
- `flutter build apk --flavor dev --obfuscate --split-debug-info=./debug --target-platform android-arm,android-arm64 -t ./lib/main_dev.dart`

#### Production apk build command
- `flutter build apk --flavor prod --target lib/main_prod.dart`

#### Production apk with code obfuscation (Recommended)
- `flutter build apk --flavor prod --obfuscate --split-debug-info=./debug --target-platform android-arm,android-arm64 -t ./lib/main_prod.dart`

### Production appBundle with code obfuscation (Recommended)
- `flutter build appbundle --flavor prod --obfuscate --split-debug-info=./debug --release --target-platform android-arm,android-arm64 -t ./lib/main_prod.dart`


## Fix - Play store warning: App Bundle contains native code, and you've not uploaded debug symbols
- Go to this directory (given below) and zip all the folder.
- `*Your app directory*/build/app/intermediates/merged_native_libs/prodRelease/mergeProdReleaseNativeLibs/out/lib`
- Now open terminal on this directory & run this command `zip -d Archive.zip "__MACOSX*"`
- Upload this (Archive.zip) file to the play console.