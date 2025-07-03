pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("") version "1.0.0"
    id("") version "8.7.0" apply false
    // START: FlutterFire Configuration
    id("") version("4.3.15") apply false
    // END: FlutterFire Configuration
    id ("") version ("2.0.0") apply false
}

include(":app")
