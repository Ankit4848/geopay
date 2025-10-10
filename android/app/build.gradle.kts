plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.softieons.fintech"
    compileSdk = 36
    ndkVersion = "25.1.8937393"
    buildToolsVersion = "34.0.0"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.softieons.fintech"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        // Adding explicit version code and name for app bundle generation
        versionCode = 13
        versionName = "1.0.5"
    }

    signingConfigs {
        create("release") {
            storeFile = file("../../geopay.jks")
            storePassword = "123456"
            keyAlias = "key0"
            keyPassword = "123456"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            
            // Disable ProGuard/R8 for now to avoid build issues
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Fix for app bundle generation
            ndk {
                abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86", "x86_64"))
            }
        }

        debug {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
    bundle {
        language {
            enableSplit = false
        }
        density {
            enableSplit = true
        }
        abi {
            enableSplit = true
        }
    }

    // ✅ FIX: Prevent invalid .so file from being stripped or causing build failure
    packaging {
        resources {
            pickFirsts += "**/libc++_shared.so"
            pickFirsts += "**/libRecogKitAndroid.so"
            // Add additional pickFirst rules to resolve conflicts
            pickFirsts += "META-INF/DEPENDENCIES"
            pickFirsts += "META-INF/LICENSE"
            pickFirsts += "META-INF/LICENSE.txt"
            pickFirsts += "META-INF/license.txt"
            pickFirsts += "META-INF/NOTICE"
            pickFirsts += "META-INF/NOTICE.txt"
            pickFirsts += "META-INF/notice.txt"
            pickFirsts += "META-INF/ASL2.0"
            pickFirsts += "META-INF/*.kotlin_module"
        }
        jniLibs {
            // Exclude problematic native libs from being stripped
            excludes += listOf("**/libRecogKitAndroid.so")
        }
    }
}

flutter {
    source = "../.."
}

// Automatically copy APK and Bundle to Flutter's expected location after build
afterEvaluate {
    tasks.findByName("assembleDebug")?.finalizedBy(":copyApkToFlutterLocation")
    tasks.findByName("assembleRelease")?.finalizedBy(":copyApkToFlutterLocation")
    tasks.findByName("bundleRelease")?.finalizedBy(":copyBundleToFlutterLocation")
}
