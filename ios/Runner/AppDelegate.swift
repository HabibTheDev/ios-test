import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    // Google map API key
    GMSServices.provideAPIKey("AIzaSyDvG6DFRT_vbVgB8Kezb8wfUje-Pxl2ohs")

    // Start awake lock
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let awakeLockChannel = FlutterMethodChannel(name: "com.fleetblox.employee_app/awake_lock",binaryMessenger: controller.binaryMessenger)

    awakeLockChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      switch call.method {
      case "enableAwakeLock":
        UIApplication.shared.isIdleTimerDisabled = true
        result(true)
      case "disableAwakeLock":
        UIApplication.shared.isIdleTimerDisabled = false
        result(true)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    // End awake lock

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
