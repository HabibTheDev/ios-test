import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Load local.properties
val localProperties = Properties().apply {
    val file = rootProject.file("local.properties")
    if (file.exists()) {
        file.inputStream().use { load(it) }
    }
}

// Load keystore properties
val keystoreProperties = Properties().apply {
    val file = rootProject.file("key.properties")
    if (file.exists()) {
        file.inputStream().use { load(it) }
    }
}

android {
    namespace = "com.fleetblox.employee_app"
    compileSdk = (localProperties.getProperty("flutter.compileSdkVersion") ?: "35").toInt()
    ndkVersion = (localProperties.getProperty("flutter.ndkVersion") ?: "29.0.13113456")

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // Enable Core Library Desugaring for "flutter_local_notifications"
        isCoreLibraryDesugaringEnabled = true 
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.fleetblox.employee_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = (localProperties.getProperty("flutter.minSdkVersion") ?: "23").toInt()
        targetSdk = (localProperties.getProperty("flutter.targetSdkVersion") ?: "35").toInt()
        versionCode = (localProperties.getProperty("flutter.versionCode") ?: "1").toInt()
        versionName = localProperties.getProperty("flutter.versionName") ?: "0.0.1"
        multiDexEnabled = true
    }

   signingConfigs {
    create("release") {
        val storeFilePath = keystoreProperties["storeFile"] as String?
        if (storeFilePath != null) {
            storeFile = file(storeFilePath)
            storePassword = keystoreProperties["storePassword"] as String?
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
        }
    }
}

buildTypes {
    getByName("release") {
        // Only apply signingConfig if key.properties exists
        if (keystoreProperties["storeFile"] != null) {
            signingConfig = signingConfigs.getByName("release")
        }
        isMinifyEnabled = true
        isShrinkResources = true
    }
}

    flavorDimensions += "default"
    productFlavors {
        create("dev") {
            dimension = "default"
            resValue("string", "app_name", "Dev Fleetblox Crew")
            // applicationIdSuffix = ".dev"
        }
        create("prod") {
            dimension = "default"
            resValue("string", "app_name", "Fleetblox Crew")
        }
    }

}

dependencies {
    // Enable Core Library Desugaring for "flutter_local_notifications"
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

flutter {
    source = "../.."
}
