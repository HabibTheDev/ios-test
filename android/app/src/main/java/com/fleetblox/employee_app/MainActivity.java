package com.fleetblox.employee_app;

import io.flutter.embedding.android.FlutterFragmentActivity;
// Start awake lock
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
// End awake lock

public class MainActivity extends FlutterFragmentActivity {
    private static final String AWAKE_LOCK_CHANNEL = "com.fleetblox.employee_app/awake_lock";

   @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        AwakeLockMethodHandler awakeLockHandler = new AwakeLockMethodHandler(this);
        // Set the new handler for the MethodChannel
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), AWAKE_LOCK_CHANNEL)
                .setMethodCallHandler(awakeLockHandler); // Use the instance of your handler
    }
}
