plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // Flutter Gradle Plugin ต้องอยู่หลัง Android และ Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

// =============================
// 1️⃣ บังคับเวอร์ชัน library ซ้ำ
// =============================
configurations.all {
    resolutionStrategy {
        // Library ที่มักซ้ำ
        force("com.google.guava:guava:31.1-jre")
        force("org.jetbrains.kotlin:kotlin-stdlib:1.8.10")
        force("org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.10")
        force("org.jetbrains.kotlin:kotlin-stdlib-jdk8:1.8.10")
        force("com.squareup.okio:okio:3.3.0")
        force("com.squareup.okhttp3:okhttp:4.11.0")
    }
}



android {
    // =============================
    // 2️⃣ NDK Version สำหรับ plugin ที่ต้องการ
    // =============================
    ndkVersion = "27.0.12077973"

    namespace = "com.example.non_v2"
    compileSdk = flutter.compileSdkVersion

    // =============================
    // 3️⃣ Java & Kotlin Compatibility
    // =============================
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    // =============================
    // 4️⃣ แก้ปัญหาไฟล์ META-INF ซ้ำ
    // =============================
    packagingOptions {
    resources.excludes.addAll(
        listOf(
            "META-INF/DEPENDENCIES",
            "META-INF/LICENSE",
            "META-INF/LICENSE.txt",
            "META-INF/license.txt",
            "META-INF/NOTICE",
            "META-INF/NOTICE.txt",
            "META-INF/notice.txt",
            "META-INF/ASL2.0",
            "META-INF/*.kotlin_module"
        )
    )
}
    // =============================
    // 5️⃣ Default config ของแอป
    // =============================
    defaultConfig {
        applicationId = "com.example.non_v2"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // =============================
    // 6️⃣ Build types (debug/release)
    // =============================
    buildTypes {
        release {
            // ใช้ debug signing ชั่วคราว ถ้าไม่มี keystore จริง
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// =============================
// 7️⃣ Flutter source path
// =============================
flutter {
    source = "../.."
}
