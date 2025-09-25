# Fleetblox Crew
The Fleetblox Crew App is a Flutter-based mobile application designed for employees to manage their daily assigned tasks. The application supports both iOS and Android platforms and follows a modern, scalable architecture.

## Preferred environment versions
- Flutter: 3.32.4
- JDK: 17.0.12
- Android Studio: Ladybug Feature Drop | 2024.2.2
- Xcode: Version 16.4
- Swift Version: Swift 5

## Local project setup
- Clone from git: https://github.com/AI-car-damage-recognition/Mobile-APP-Flutter.git
- Setup Flutter environment with fvm:  https://fvm.app/documentation/getting-started/installation
- Follow the Environment Configuration below: ⬇️

## Env setup
Create `env.dart` file inside the `lib` directory and create variables with name:
- `AI_JWT_TOKEN`
- `MAP_KEY`
- `SENTRY_DSN`

## Generate localizations command
- If you want to add new localization variables then go to this `lib/l10n` directory and add required variables to this `app_en.arb` (for english) file.
- Now run this following command to generate Localizations.
- `flutter gen-l10n`

Then put the valid credentials into these variables.

## Install flutterFire CLI and configure firebase

To install FlutterFire CLI.
- `dart pub global activate flutterfire_cli`

Connect project with firebase (optional).
- `flutterfire configure --project=fb-mobile-app-a329f`

## Some necessary commands

#### Dev apk build command
- `flutter build apk --flavor dev --target-platform android-arm64 --target lib/main_dev.dart`

#### Production apk build command
- `flutter build apk --flavor prod --target-platform android-arm64 --target lib/main_prod.dart`

#### Production apk with code obfuscation (Recommended)
- `flutter build apk --flavor prod --obfuscate --split-debug-info=./debug --target-platform android-arm,android-arm64 -t ./lib/main_prod.dart`

### Production appBundle with code obfuscation (Recommended)
- `flutter build appbundle --flavor prod --obfuscate --split-debug-info=./debug --release --target-platform android-arm,android-arm64 -t ./lib/main_prod.dart`

## Fix - Play store warning: App Bundle contains native code, and you've not uploaded debug symbols
- Go to this directory (given below) and zip all the folder. 
- `YOUR_APP_DIRECTORY/build/app/intermediates/merged_native_libs/prodRelease/mergeProdReleaseNativeLibs/out/lib`
- Now open terminal on this directory & run this command `zip -d Archive.zip "__MACOSX*"`
- Upload this (Archive.zip) file to the play console.


## iOS build instruction

### iOS Staging IPA
- `flutter build ipa --flavor dev --obfuscate --split-debug-info -t ./lib/main_dev.dart`

### iOS Production Release
- `flutter build ipa --flavor prod --obfuscate --split-debug-info -t ./lib/main_prod.dart`

Then open `build/ios/archive/Runner.xcarchive` in Xcode.

Click the **Validate App** button. If any issues are reported, address them and produce another build.
After the archive has been successfully validated, click **Distribute App**.