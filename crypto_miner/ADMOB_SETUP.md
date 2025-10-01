# Google AdMob Integration Setup Guide

This app is configured with Google AdMob test ad units. Follow these steps to replace them with your own AdMob IDs before publishing.

## Current Configuration

### Test Ad Unit IDs (Currently Active)
- **Banner Ad**: `ca-app-pub-3940256099942544/6300978111`
- **Rewarded Ad**: `ca-app-pub-3940256099942544/5224354917`
- **App ID (Android)**: `ca-app-pub-3940256099942544~3347511713`

⚠️ **IMPORTANT**: These are Google's test ad unit IDs. They will NOT generate revenue. You MUST replace them with your own AdMob IDs before publishing to production.

## How to Get Your Own AdMob IDs

### Step 1: Create AdMob Account
1. Go to https://admob.google.com
2. Sign in with your Google account
3. Create a new AdMob account if you don't have one

### Step 2: Create App in AdMob
1. Click "Apps" in the left sidebar
2. Click "Add App"
3. Select "Android" or "iOS"
4. Enter your app name: "Crypto Miner"
5. Click "Add"
6. Copy your **App ID** (format: ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX)

### Step 3: Create Ad Units
1. In your app dashboard, click "Ad units"
2. Click "Add ad unit"
3. Create the following ad units:

#### Banner Ad Unit
- Select "Banner"
- Name: "Home Screen Banner"
- Copy the **Ad unit ID** (format: ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX)

#### Rewarded Ad Unit  
- Select "Rewarded"
- Name: "Claim Rewards"
- Copy the **Ad unit ID** (format: ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX)

## Files to Update

### 1. Android Manifest
**File**: `android/app/src/main/AndroidManifest.xml`

Find this line:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-3940256099942544~3347511713"/>
```

Replace with your App ID:
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
```

### 2. Home Screen - Banner Ad
**File**: `lib/home.dart`

Find line ~52:
```dart
adUnitId: 'ca-app-pub-3940256099942544/6300978111',
```

Replace with your Banner Ad unit ID:
```dart
adUnitId: 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX',
```

### 3. Home Screen - Rewarded Ad
**File**: `lib/home.dart`

Find line ~71:
```dart
adUnitId: 'ca-app-pub-3940256099942544/5224354917',
```

Replace with your Rewarded Ad unit ID:
```dart
adUnitId: 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX',
```

## Platform Support

### ✅ Supported Platforms
- **Android**: Full AdMob support
- **iOS**: Full AdMob support (requires Info.plist configuration)

### ❌ Not Supported
- **Web**: AdMob does not support Flutter web
- **Desktop**: AdMob does not support desktop platforms

The app automatically detects the platform and only loads ads on Android/iOS.

## iOS Setup (If Targeting iOS)

**File**: `ios/Runner/Info.plist`

Add your AdMob App ID:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
```

Also add the App Tracking Transparency message:
```xml
<key>NSUserTrackingUsageDescription</key>
<string>This app uses advertising ID to serve personalized ads</string>
```

## Testing Your Setup

### 1. Test Ads on Device
1. Build and install the app on a real Android/iOS device
2. Run the app
3. You should see test ads (with "Test Ad" label)

### 2. Verify Ad Loading
- Banner ad should appear at the bottom of the home screen
- Tap "Claim Rewards" to show a rewarded ad
- Check "Settings" → "Ads Watched" counter increments

### 3. Before Production
1. Replace ALL test ad unit IDs with your production IDs
2. Test on multiple devices
3. Verify ads load correctly
4. Check AdMob dashboard for impressions

## Build Release APK

Once you've replaced the test IDs with your production IDs:

```bash
cd crypto_miner
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

## Troubleshooting

### Ads not showing?
1. Verify all ad unit IDs are correct
2. Check internet connection
3. Test ads may take a few seconds to load
4. Check AdMob dashboard for any account issues

### "Ad failed to load" message?
1. Verify ad unit IDs match the ad format (banner/rewarded)
2. Check if your AdMob account is approved
3. Ensure app package name matches AdMob app settings

## Important Notes

⚠️ **Never use test ad unit IDs in production** - This violates AdMob policies

⚠️ **Don't click your own ads** - This can get your AdMob account banned

✅ **Test with test IDs first** - Make sure everything works before switching to production IDs

✅ **Keep test IDs for development** - Use build flavors to separate test and production

## Support

For AdMob-specific issues, visit:
- AdMob Help Center: https://support.google.com/admob
- Flutter AdMob Plugin: https://pub.dev/packages/google_mobile_ads
