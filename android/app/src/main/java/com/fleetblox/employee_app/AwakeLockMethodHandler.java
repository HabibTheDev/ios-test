package com.fleetblox.employee_app; // Ensure this matches your package name

import android.app.Activity; // Import Activity
import android.view.WindowManager;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class AwakeLockMethodHandler implements MethodChannel.MethodCallHandler {

    private final Activity activity;

    // Constructor to receive the Activity instance
    public AwakeLockMethodHandler(Activity activity) {
        this.activity = activity;
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        // We need a reference to the Activity's Window.
        // The activity is passed through the constructor.
        if (activity == null || activity.getWindow() == null) {
            result.error("UNAVAILABLE", "Activity or Window not available.", null);
            return; // Exit early if activity or window is null
        }

        switch (call.method) {
            case "enableAwakeLock":
                activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                result.success(true);
                break;
            case "disableAwakeLock":
                activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
                result.success(true);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}