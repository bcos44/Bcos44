# Crypto Miner App - Build Instructions

## Overview
This is a Flutter crypto mining simulator app with Google AdMob integration. The app simulates cryptocurrency mining with realistic hash rates and includes rewarded ads for claiming mined coins.

## Features Implemented

### Home Screen
- ✅ Start/Stop Mining button
- ✅ Dynamic hash rate display (20-120 H/s)
- ✅ Real-time coin accumulation
- ✅ Claim Rewards button with rewarded ads
- ✅ Banner ad at bottom of screen

### Settings Screen
- ✅ Dark theme toggle (default: dark mode)
- ✅ Ads watched counter
- ✅ About section with app info

### AdMob Integration
- ✅ Google AdMob SDK integrated
- ✅ Test ad unit IDs configured
- ✅ Banner ads on home screen
- ✅ Rewarded ads for claiming rewards
- ✅ Platform detection (Android/iOS only)
- ✅ Ad counter tracking

## Prerequisites

### Required Software
1. **Flutter SDK** (3.0+)
   - Download: https://docs.flutter.dev/get-started/install
   
2. **Android Studio** (for Android builds)
   - Download: https://developer.android.com/studio
   - Include Android SDK and command-line tools
   
3. **Xcode** (for iOS builds - Mac only)
   - Download from Mac App Store

### Setup Steps
```bash
# Verify Flutter installation
flutter doctor

# Install dependencies
cd crypto_miner
flutter pub get
```

## Building the App

### Android APK (Release)
```bash
cd crypto_miner
flutter build apk --release
```

Output location: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Google Play)
```bash
cd crypto_miner
flutter build appbundle --release
```

Output location: `build/app/outputs/bundle/release/app-release.aab`

### iOS (Mac only)
```bash
cd crypto_miner
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode to archive and export.

## Testing

### Run on Emulator/Simulator
```bash
# Android emulator
flutter run

# iOS simulator (Mac only)
flutter run -d "iPhone 15"
```

### Run on Physical Device
```bash
# List connected devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

## AdMob Configuration

**IMPORTANT**: The app currently uses Google's test ad unit IDs. You MUST replace these with your own AdMob IDs before publishing.

See `ADMOB_SETUP.md` for detailed instructions on:
- Creating an AdMob account
- Generating your own ad unit IDs
- Replacing test IDs in the code
- Platform-specific configuration

### Quick Reference - Files to Update

1. `android/app/src/main/AndroidManifest.xml` - Replace App ID
2. `lib/home.dart` (line ~52) - Replace Banner Ad ID
3. `lib/home.dart` (line ~71) - Replace Rewarded Ad ID

## Project Structure

```
crypto_miner/
├── lib/
│   ├── main.dart          # App entry point, state management
│   ├── home.dart          # Home screen with mining simulation
│   └── settings.dart      # Settings screen
├── android/               # Android-specific configuration
├── ios/                   # iOS-specific configuration
├── web/                   # Web files (AdMob not supported)
├── pubspec.yaml           # Dependencies
├── ADMOB_SETUP.md         # AdMob integration guide
└── BUILD_INSTRUCTIONS.md  # This file
```

## Dependencies

The app uses these Flutter packages:
- `google_mobile_ads` (^5.2.0) - AdMob integration
- `provider` (^6.1.2) - State management
- `shared_preferences` (^2.3.3) - Data persistence

## Platform Support

| Platform | Status | AdMob Support |
|----------|--------|---------------|
| Android  | ✅ Full | ✅ Yes        |
| iOS      | ✅ Full | ✅ Yes        |
| Web      | ⚠️ Limited | ❌ No      |
| Desktop  | ❌ Not supported | ❌ No |

**Note**: The app detects the platform and gracefully handles AdMob on unsupported platforms.

## Troubleshooting

### Common Issues

**1. "No Android SDK found"**
- Install Android Studio
- Set ANDROID_HOME environment variable
- Run `flutter doctor` to verify

**2. "Ads not showing on device"**
- You're using test ad IDs (this is normal for testing)
- Check internet connection
- Verify AdMob IDs are correct

**3. "Build failed - plugin not found"**
```bash
flutter clean
flutter pub get
flutter run
```

**4. "iOS build fails"**
- Ensure Xcode is installed (Mac only)
- Run `pod install` in ios/ directory
- Check signing certificates in Xcode

## Production Checklist

Before publishing to Google Play or App Store:

- [ ] Replace ALL test AdMob IDs with production IDs
- [ ] Test on multiple physical devices
- [ ] Verify ads load correctly
- [ ] Update app icons and splash screen
- [ ] Set proper app version in pubspec.yaml
- [ ] Configure signing keys for release
- [ ] Test dark/light theme switching
- [ ] Verify settings persistence works
- [ ] Check ad counter increments correctly
- [ ] Review and accept AdMob policies

## Support & Resources

- Flutter Documentation: https://docs.flutter.dev
- AdMob Flutter Plugin: https://pub.dev/packages/google_mobile_ads
- AdMob Help Center: https://support.google.com/admob

## License

This project is created for demonstration purposes.
