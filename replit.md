# Crypto Miner - Flutter Web App

## Overview
A Flutter-based cryptocurrency mining simulator web application with Google AdMob integration. The app simulates crypto mining with realistic hash rates and includes features for claiming rewards.

**Date Imported to Replit:** October 1, 2025

## Project Architecture

### Technology Stack
- **Framework:** Flutter 3.32.0
- **Language:** Dart 3.8.0
- **Platform:** Web (built for web-server device)
- **State Management:** Provider package
- **Persistence:** SharedPreferences
- **Ads:** Google Mobile Ads (AdMob) - Web display only, full functionality on Android/iOS

### Project Structure
```
crypto_miner/
├── lib/
│   ├── main.dart          # App entry point, state management, theme handling
│   ├── home.dart          # Home screen with mining simulation and AdMob
│   └── settings.dart      # Settings screen with theme toggle
├── web/                   # Web-specific assets and HTML
├── android/               # Android platform configuration
├── ios/                   # iOS platform configuration
└── pubspec.yaml           # Flutter dependencies
```

### Key Features
- Start/Stop mining simulation with dynamic hash rates (20-120 H/s)
- Real-time coin accumulation
- Dark/Light theme toggle (default: dark mode)
- Rewarded ads for claiming coins (Android/iOS)
- Banner ads on home screen
- Settings persistence using SharedPreferences
- Ads watched counter

## Development Setup

### Running the App
The app runs automatically via the configured workflow. To manually run:
```bash
cd crypto_miner
flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0 --release
```

### Installing Dependencies
```bash
cd crypto_miner
flutter pub get
```

### Building for Production
```bash
cd crypto_miner
flutter build web --release
```

## Deployment Configuration
- **Type:** Autoscale (stateless web application)
- **Build Command:** `cd crypto_miner && flutter build web --release`
- **Run Command:** `cd crypto_miner && flutter run -d web-server --web-port=5000 --web-hostname=0.0.0.0 --release`
- **Port:** 5000 (frontend only)
- **Host:** 0.0.0.0 (configured for Replit proxy compatibility)

## Platform Support
| Platform | Status | AdMob Support |
|----------|--------|---------------|
| Web      | ✅ Full | ⚠️ Display Only |
| Android  | ✅ Full | ✅ Yes |
| iOS      | ✅ Full | ✅ Yes |
| Desktop  | ❌ Not configured | ❌ No |

**Note:** The web version displays ad placeholders but does not load actual AdMob ads. Full AdMob functionality requires Android or iOS builds.

## Recent Changes
- **2025-10-01:** Initial import and Replit configuration
  - Installed Flutter 3.32.0 with Dart 3.8.0
  - Enabled Flutter web support
  - Configured workflow for web-server device on port 5000
  - Set up deployment configuration for autoscale
  - Created .gitignore with Flutter-specific entries
  - Verified app functionality: mining simulation, theme toggle, and UI working correctly

## Dependencies
- `flutter`: SDK
- `google_mobile_ads`: ^5.2.0 - AdMob integration
- `provider`: ^6.1.2 - State management
- `shared_preferences`: ^2.3.3 - Data persistence
- `cupertino_icons`: ^1.0.8 - iOS-style icons

## Important Notes
- **AdMob Configuration:** Currently uses Google's test ad unit IDs. Replace with production IDs before publishing to app stores. See `crypto_miner/ADMOB_SETUP.md` for details.
- **Web Limitations:** AdMob does not work on web, only Android and iOS apps support full ad functionality.
- **Replit Environment:** The app is configured to work with Replit's proxy by binding to 0.0.0.0:5000.

## User Preferences
None specified yet.
