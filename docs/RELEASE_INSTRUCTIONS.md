# PetGuardian Release Instructions

## Project Identity

- App name: PetGuardian
- Android package name: `com.example.petguardian`
- iOS display name: PetGuardian
- Project folder: `release_ready_flutter_app`
- Version: `1.0.0+1`

In `pubspec.yaml`, `1.0.0` is the version name and `1` is the build number. Android uses these values as `versionName` and `versionCode`. iOS uses them as `CFBundleShortVersionString` and `CFBundleVersion`.

## Assets

All visual assets are local and included in the app bundle:

- `assets/images/`
- `assets/icons/`
- `assets/splash/`

The app does not rely on remote Figma URLs or external runtime image downloads.

## Splash Screen

The app uses the PetGuardian orange background `#F59245` and the local logo `assets/splash/petguardian_logo.png`.

`flutter_native_splash` is fully configured in `pubspec.yaml`. If the generator is allowed in the local environment, run:

```bash
dart run flutter_native_splash:create
```

The in-app splash screen already uses the same color and logo so the first Flutter screen visually matches the native splash.

## App Icon

`flutter_launcher_icons` is configured in `pubspec.yaml`:

- Source icon: `assets/icons/petguardian_icon.png`
- Android adaptive icon background: `#F59245`
- Android and iOS icon generation enabled

Launcher icons have been generated for Android and iOS.

## Android Release Build

Before building, confirm dependencies are available:

```bash
flutter pub get
```

Build APK:

```bash
flutter build apk
```

Build Android App Bundle:

```bash
flutter build appbundle
```

Output locations:

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

Debug builds include development tooling, assertions, and debugging metadata. Release builds are optimized, tree-shaken, minified where applicable, and intended for installation or store submission.

## Android Signing

For academic/local release builds, the project can build with the fallback debug signing configuration. For store submission, create a release keystore and copy:

```text
android/key.properties.example
```

to:

```text
android/key.properties
```

Then fill in the keystore path, alias, and passwords. The Gradle file automatically uses the release signing config when `android/key.properties` exists.

## iOS Preparation

iOS builds require macOS with Xcode installed. The iOS bundle identifier is configured in Xcode under Runner target settings. For store deployment, set a unique bundle identifier, select an Apple Developer Team, and configure signing certificates/provisioning profiles.

Build command:

```bash
flutter build ios
```

For App Store distribution, archive and upload through Xcode or Transporter after signing is configured.

## Release Testing Checklist

- App launch opens without crash.
- Native/in-app splash uses orange `#F59245` and PetGuardian logo.
- Login button navigates to the dashboard.
- Bottom navigation opens dashboard, service, shop, notifications/history, and profile/training flows.
- Veterinary screen opens doctor details.
- Grooming, shop, training, and notifications lists scroll correctly.
- UI follows the Figma visual system: orange theme, Poppins typography, white rounded cards, light gray background, and local pet imagery.
- No debug prints or development-only UI remains in app code.
