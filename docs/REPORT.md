# Academic Report: PetGuardian

## 1. Project Title

PetGuardian: Release-Ready Flutter Application for Pet Care Services

## 2. Project Description

PetGuardian is a production-style Flutter mobile application designed for pet owners who need access to veterinary care, grooming services, pet shopping, training courses, and notifications. The application is based on the PetGuardian Figma UI Kit and follows a clean, scalable Flutter architecture. It uses Material 3, Google Fonts, reusable UI components, local assets, and release-oriented Android configuration.

The application includes the required screens: Splash Screen, Login Screen, Dashboard, Veterinary Screen, Doctor Detail Screen, Grooming Screen, Shop Screen, Training Screen, and Notifications Screen. Navigation is implemented through named routes and a BottomNavigationBar-style custom navigation widget.

## 3. Screenshots Placeholders

### Main Screen

[Insert screenshot of the Dashboard screen here.]

### Splash Screen

[Insert screenshot of the PetGuardian splash screen here.]

### App Icon

[Insert screenshot of the generated PetGuardian launcher icon here.]

### Release Build

[Insert screenshot showing successful APK or App Bundle build output here.]

## 4. App Identity

The application identity is configured to match a release-ready mobile app. The app display name is PetGuardian. The Android package name is `com.example.petguardian`, which is configured in `android/app/build.gradle.kts` as both the namespace and applicationId. The Android manifest uses the visible label PetGuardian, and the iOS display name is also set to PetGuardian in `ios/Runner/Info.plist`.

This identity setup ensures that the installed application appears to users as PetGuardian and that the Android build has a consistent package identifier.

## 5. Icon Setup

The app icon is configured using the `flutter_launcher_icons` package. The source icon is stored locally at `assets/icons/petguardian_icon.png`. The icon uses the PetGuardian orange color and a pet-themed logo mark, matching the product identity and splash screen.

The configuration is included in `pubspec.yaml`, enabling Android and iOS icon generation. Android adaptive icon settings use `#F59245` as the background color. Launcher icon files have been generated into the platform-specific Android and iOS folders.

## 6. Splash Setup

The splash screen uses the PetGuardian primary orange color `#F59245` and the local logo asset `assets/splash/petguardian_logo.png`. The `flutter_native_splash` configuration is present in `pubspec.yaml`, including Android, iOS, and Android 12 settings.

Because generator execution can be blocked in restricted environments, the in-app Flutter splash screen is also implemented manually. It uses the same background color and same visual logo, ensuring visual continuity between the native loading state and the first Flutter-rendered screen.

## 7. Versioning

The project version is set in `pubspec.yaml` as:

```yaml
version: 1.0.0+1
```

The value before the plus sign, `1.0.0`, is the version name. The value after the plus sign, `1`, is the build number. Android maps these values to `versionName` and `versionCode`. iOS maps them to `CFBundleShortVersionString` and `CFBundleVersion`.

Version constants are also documented in the app constants file to make the release values clear in the source code.

## 8. Build Process

The Android release build can be produced with:

```bash
flutter build apk
```

The generated APK is located at:

```text
build/app/outputs/flutter-apk/app-release.apk
```

The Android App Bundle can be produced with:

```bash
flutter build appbundle
```

The generated AAB is located at:

```text
build/app/outputs/bundle/release/app-release.aab
```

A debug build is intended for development and includes debugging support, assertions, and tooling. A release build is optimized for installation, distribution, and store submission. Release builds use bundled assets, compiled Dart code, and production-oriented platform configuration.

## 9. Release Testing

The release testing checklist covers the following areas:

- The application launches successfully without crashes.
- The splash screen displays the orange PetGuardian background and logo.
- The login button navigates to the dashboard.
- Bottom navigation works between the main sections.
- Veterinary doctor cards navigate to the doctor detail screen.
- Grooming, shop, training, and notifications screens scroll correctly.
- Local assets load correctly without network access.
- The interface matches the Figma design language, including orange accents, Poppins typography, rounded cards, white surfaces, and a light gray background.
- No debug prints or temporary prototype code remains.

## 10. iOS Preparation

iOS release builds require macOS and Xcode. The bundle identifier is managed in the Xcode Runner target settings and should be set to a unique identifier for App Store deployment. Signing requires an Apple Developer account, a selected development team, and valid certificates/provisioning profiles.

The iOS build command is:

```bash
flutter build ios
```

After the build, the app can be archived in Xcode and distributed through App Store Connect when signing is correctly configured.

## 11. Architecture Summary

The project follows a clean Flutter structure:

```text
lib/
  core/
    constants/
    theme/
  models/
  screens/
    splash/
    login/
    dashboard/
    veterinary/
    grooming/
    shop/
    training/
    notifications/
  services/
  widgets/
```

Reusable widgets include CustomButton, CustomCard, PetCard, CategoryItem, SearchBox, SectionHeader, and AppBottomNavBar. Data is separated into models and a local data service. Theme values are centralized through color, spacing, radius, and Material 3 ThemeData definitions.

## 12. Final Summary

PetGuardian satisfies the academic requirements for a release-ready Flutter application. It implements all required screens from the Figma-based PetGuardian design, uses a clean architecture, includes local platform-specific assets, configures app identity, prepares launcher icons, configures native splash settings, sets correct versioning, and documents the Android and iOS release process.

The final result is a self-contained Flutter project that can be built manually on a local machine and submitted as a complete academic mobile application project.
