# REPORT
Cross-platform mobile development

* Student: Tulegenova Karina
* Group: SE-2419
* Date: 06.05.2026

### INTRODUCTION

This project focuses on preparing a Flutter mobile application called PetGuardian for a release-ready state. The application allows users to search pets, explore pet services, and watch training videos through a modern and user-friendly interface.
Special attention was given to platform-specific configuration, including the app icon, splash screen, versioning, and release build preparation. The project was developed using Flutter and follows a clean and structured design based on a Figma prototype.
Overall, the project demonstrates the process of preparing a mobile application for real-world deployment and testing.

### Project Overview

PetGuardian is a multi-screen application with the following main components:
•	Home (Dashboard)
•	Search screen with API integration
•	Training section with external video resources
•	Services (veterinary, grooming, etc.)
•	User profile
•	Activity tracking system (instead of static notifications)

The project structure is organized into clear folders such as: lib/screens, lib/widgets, lib/models, lib/services. This makes the project easier to maintain and extend. Before starting release preparation, the application was tested to ensure: it launches correctly, navigation works without crashes, UI elements load properly, there are no debug prints or placeholder texts.

# PLATFORM-SPECIFIC CONFIGURATION

The application name and Android package ID were configured for release preparation. App name: PetGuardian. Package ID: com.example.petguardian. Configuration files: AndroidManifest.xml and build.gradle.

### App Icon

A custom app icon was created and applied using the flutter_launcher_icons package. The default Flutter icon was replaced with a custom PetGuardian icon to match the application theme and branding. 
<img width="394" height="320" alt="image" src="https://github.com/user-attachments/assets/11994f11-3df7-4d25-abba-b259d5fc897e" />

Figure 1. Custom application icon displayed on the device.

### Splash Screen

A splash screen was configured using the flutter_native_splash package. It includes: custom background color based on the Figma theme, centered application logo, clean and simple layout. The configuration was added in pubspec.yaml, and the splash screen was generated automatically.

 <img width="408" height="258" alt="image" src="https://github.com/user-attachments/assets/1ccdddf3-e18e-41e1-beb0-a804dca0d9e0" />

Figure 2. PetGuardian splash screen displayed during application launch.

### Versioning

The application version is defined in pubspec.yaml: version: 1.0.0+1. This includes: version name: 1.0.0 and build number: 1. Versioning is important for future updates and release management.
 <img width="407" height="116" alt="image" src="https://github.com/user-attachments/assets/0c128d74-dbfe-4291-938f-ffebc6980722" />

Figure 3. Application version configuration in pubspec.yaml.

### Implementation Details

The application was developed using Flutter and Dart. Main technical decisions used in the project: Navigation: named routes (AppRoutes), UI design: Material 3, Fonts: Poppins from Google Fonts, State management: StatefulWidgets, API integration: HTTP requests using the http package. External API used in the project: TheCatAPI for dynamic pet search results.
<img width="414" height="283" alt="image" src="https://github.com/user-attachments/assets/fc76c664-e1fe-44cf-a3d7-f370af9d54d3" />
 
Figure 4. Dynamic search functionality using TheCatAPI.

## KEY FEATURES

### Search Functionality

The search functionality fetches real-time data from TheCatAPI and displays dynamic search results, including images, generated titles, and short descriptions. API requests are triggered only after user input submission to avoid unnecessary reloads and improve performance. The implementation of this feature is demonstrated in Figure 4.

### Training Section

The training section provides educational pet care content through external YouTube resources. Each training card includes a video preview, title, author information, and a button that opens the video using the url_launcher package. This makes the application more interactive and realistic for users.
 <img width="310" height="251" alt="image" src="https://github.com/user-attachments/assets/596f1e19-64a6-4c4c-bcd1-3653a1867d45" />

Figure 5. Training section with external YouTube learning resources.
Services Section

Service categories include: Vaccinations, Operations, Behavior, Dentistry. Each category opens a detailed screen with structured data instead of placeholders.
 <img width="392" height="236" alt="image" src="https://github.com/user-attachments/assets/6b7ec2e5-7de1-413c-a967-bc102ad82c1c" />

Figure 6. Services section with categorized pet care information.

### User Profile
 <img width="385" height="206" alt="image" src="https://github.com/user-attachments/assets/8c3a5049-0194-4238-9e20-b5bc32af485e" />

Figure 7. User profile interface with personalized settings.
Activity Tracking System

Instead of static notifications, the app records user actions such as: search queries, opened screens, clicked items. This simulates real application behavior.
 <img width="165" height="259" alt="image" src="https://github.com/user-attachments/assets/6638742d-e7d6-48a3-9679-926d00705900" />

Figure 8. Activity tracking system recording user interactions.

### Android Release Build

The final release APK file was generated using the Flutter command: flutter build apk --release. The generated release APK was created in the Flutter build output directory as app-release.apk and it is shown in Figure 9. 
 <img width="416" height="81" alt="image" src="https://github.com/user-attachments/assets/ebd7cd48-54ad-47a4-89cf-07d9c1b30274" />

Figure 9. Generated Android release APK file in the Flutter build output directory.

### IOS Release Build

The iOS version of the Flutter app was prepared in Xcode using “Runner.xcworkspace”. CocoaPods dependencies were installed for Firebase, Firebase Auth, Cloud Firestore, Shared Preferences, and URL Launcher.
The minimum iOS deployment target was updated to iOS 15.0 to match Firebase SDK requirements. The app was configured with a Bundle Identifier, Firebase “GoogleService-Info.plist”, and Apple signing through Xcode.
The project was checked with Flutter analysis and tests, then installed on a real iPhone. For standalone use, the run scheme was changed to “Release” and “Debug executable” was disabled, allowing the app to open without keeping the iPhone connected to the MacBook.

 <img width="306" height="283" alt="image" src="https://github.com/user-attachments/assets/162dd3df-4e8d-4ec0-8378-1d0196bba742" />

Figure 10. Generated IOS release demonstration.

# RELEASE TESTING

The release version of the PetGuardian application was tested on an Android emulator after generating the APK build. During testing, the application launched successfully, the custom app icon and splash screen were displayed correctly, and all main navigation flows worked without crashes or visual issues. User interface elements behaved as expected in release mode, and no critical problems were detected during testing.

 <img width="402" height="260" alt="image" src="https://github.com/user-attachments/assets/33bf29c2-2648-4dd6-94e6-eb1b7cb67e3e" />

Figure 11. Main screen of the PetGuardian application running successfully in release mode on an Android emulator.
 
# CONCLUSION

The PetGuardian application was successfully prepared for release and deployment using Flutter and Dart. During the development process, special attention was given not only to the user interface, but also to platform-specific configuration and release preparation.
The project includes a configured application identity, custom app icon, splash screen, versioning system, Android release build generation, release testing, API integration, and an interactive multi-screen interface. External packages such as flutter_launcher_icons, flutter_native_splash, http, and url_launcher were used to improve the overall functionality and user experience of the application.
The final release version was tested on an emulator to verify that the application launches correctly, navigation remains stable, UI elements display properly, and all main features work as expected in release mode. No critical issues were detected during testing.
Overall, the project demonstrates practical skills in Flutter mobile development, application structuring, API integration, release configuration, and deployment preparation. The PetGuardian application is stable, functional, visually consistent, and prepared as a small release-ready mobile product.
 
