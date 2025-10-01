# Crypto Miner - Flutter Mobile Application

## Overview

Crypto Miner is a Flutter-based mobile application that simulates cryptocurrency mining with a gamified experience. The app features realistic hash rate simulation (20-120 H/s), real-time coin accumulation, and monetization through Google AdMob integration. Users can start/stop mining, watch rewarded ads to claim their mined coins, and customize their experience with dark mode settings.

The application is designed for mobile platforms (Android and iOS) and includes comprehensive ad integration with both banner and rewarded ad formats.

## User Preferences

Preferred communication style: Simple, everyday language.

## System Architecture

### Frontend Architecture

**Framework**: Flutter (version 3.0+)
- **UI Pattern**: Material Design with custom theming
- **State Management**: Provider pattern for reactive state updates
- **Platform Support**: Primary targets are Android and iOS, with scaffolding for web, Linux, Windows, and macOS

**Key Screens**:
1. **Home Screen**: Main mining interface with start/stop controls, hash rate display, coin counter, claim rewards button, and persistent banner ad
2. **Settings Screen**: Theme toggle (dark/light mode with dark as default), ad watch counter, and app information section

**Theming Strategy**:
- Default dark theme for better user experience and battery efficiency
- User-configurable theme toggle persisted across sessions
- Material Design 3 components for modern UI/UX

### State Management

**Provider Pattern**:
- Centralized state management for mining status, coin accumulation, theme preferences, and ad counters
- Reactive updates ensure UI reflects real-time changes in hash rates and coin balances
- Persistent storage integration for maintaining user preferences and progress

**State Persistence**:
- Uses `shared_preferences` package for local key-value storage
- Persists user settings (theme preference, total ads watched)
- Mining progress is session-based and resets on app restart

### Ad Monetization Architecture

**Google AdMob Integration**:
- SDK: `google_mobile_ads` Flutter plugin
- **Current Configuration**: Test ad units (must be replaced before production)
- **Ad Types Implemented**:
  - **Banner Ads**: Anchored at bottom of home screen for continuous visibility
  - **Rewarded Ads**: Triggered when user claims mined coins, incentivizing ad engagement

**Ad Implementation Strategy**:
- Platform detection ensures ads only load on Android/iOS (prevents crashes on unsupported platforms)
- Ad counter tracking for analytics and potential reward multipliers
- Test IDs currently active - production deployment requires AdMob account setup and ID replacement

**Revenue Model**:
- Rewarded ads create value exchange: users watch ads to claim accumulated coins
- Banner ads provide passive revenue stream during mining sessions

### Build Configuration

**Multi-Platform Setup**:
- Android: Gradle build system with AdMob manifest configuration
- iOS: Xcode project with Info.plist AdMob configuration
- Desktop platforms (Linux, Windows, macOS): CMake build system (ads disabled on these platforms)
- Web: Standard Flutter web build (ads disabled)

**Build Requirements**:
- Flutter SDK 3.0+
- Android Studio (for Android builds)
- Xcode (for iOS builds, macOS only)

## External Dependencies

### Core Flutter Packages

1. **google_mobile_ads** - AdMob SDK integration for banner and rewarded ads
2. **provider** - State management solution for reactive UI updates
3. **shared_preferences** - Local key-value storage for user settings and preferences
4. **cupertino_icons** - iOS-style icons for cross-platform consistency

### Development Dependencies

1. **flutter_lints** - Linting rules for code quality
2. **flutter_test** - Testing framework

### Third-Party Services

**Google AdMob** (Primary Monetization):
- **Test App ID (Android)**: `ca-app-pub-3940256099942544~3347511713`
- **Test Banner Ad Unit**: `ca-app-pub-3940256099942544/6300978111`
- **Test Rewarded Ad Unit**: `ca-app-pub-3940256099942544/5224354917`
- **Configuration Files**: 
  - Android: `android/app/src/main/AndroidManifest.xml`
  - iOS: `ios/Runner/Info.plist`
- **Production Requirement**: Replace test IDs with live AdMob account IDs before publishing

### Platform-Specific Dependencies

**Android**:
- Minimum SDK: Configured in `android/app/build.gradle`
- AdMob SDK integrated via manifest entries

**iOS**:
- iOS deployment target configured in Xcode project
- AdMob SDK with App Tracking Transparency framework support

**Note**: Desktop and web platforms do not support AdMob integration; ad functionality is disabled through platform detection.