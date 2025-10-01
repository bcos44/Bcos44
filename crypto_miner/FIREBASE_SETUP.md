# Firebase Setup Guide for Google Authentication

## Overview
The Crypto Miner app now includes Google Sign-In authentication, but it requires a Firebase project to function. This guide walks you through setting up Firebase.

## Quick Start (Recommended Method)

### Option 1: Use FlutterFire CLI (Automated)

1. **Install Firebase CLI and FlutterFire CLI:**
   ```bash
   npm install -g firebase-tools
   dart pub global activate flutterfire_cli
   ```

2. **Login to Firebase:**
   ```bash
   firebase login
   ```

3. **Configure Firebase for this project:**
   ```bash
   cd crypto_miner
   flutterfire configure
   ```
   
   This will:
   - Prompt you to select or create a Firebase project
   - Automatically generate `lib/firebase_options.dart` with correct values
   - Configure all platforms (Web, Android, iOS)

4. **Update main.dart to use the generated file:**
   Replace the hardcoded FirebaseOptions in `lib/main.dart` with:
   ```dart
   import 'firebase_options.dart';
   
   // In main() function:
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

5. **Enable Google Sign-In in Firebase Console:**
   - Go to https://console.firebase.google.com
   - Select your project
   - Navigate to Authentication > Sign-in method
   - Enable "Google" provider
   - Add authorized domains (your Replit domain)

### Option 2: Manual Configuration

1. **Create a Firebase Project:**
   - Go to https://console.firebase.google.com
   - Click "Add project"
   - Follow the setup wizard

2. **Register your web app:**
   - In Firebase Console, click the Web icon (</>)
   - Register app with a nickname (e.g., "Crypto Miner Web")
   - Copy the Firebase configuration

3. **Create `lib/firebase_options.dart`:**
   ```dart
   import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
   import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

   class DefaultFirebaseOptions {
     static FirebaseOptions get currentPlatform {
       if (kIsWeb) {
         return web;
       }
       switch (defaultTargetPlatform) {
         case TargetPlatform.android:
           return android;
         case TargetPlatform.iOS:
           return ios;
         default:
           throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
       }
     }

     static const FirebaseOptions web = FirebaseOptions(
       apiKey: 'YOUR_WEB_API_KEY',
       authDomain: 'your-project.firebaseapp.com',
       projectId: 'your-project-id',
       storageBucket: 'your-project.appspot.com',
       messagingSenderId: '123456789',
       appId: '1:123456789:web:abcdef123456',
     );

     static const FirebaseOptions android = FirebaseOptions(
       apiKey: 'YOUR_ANDROID_API_KEY',
       appId: '1:123456789:android:abcdef123456',
       messagingSenderId: '123456789',
       projectId: 'your-project-id',
       storageBucket: 'your-project.appspot.com',
     );

     static const FirebaseOptions ios = FirebaseOptions(
       apiKey: 'YOUR_IOS_API_KEY',
       iosClientId: 'your-ios-client-id.apps.googleusercontent.com',
       iosBundleId: 'com.example.cryptoMiner',
       appId: '1:123456789:ios:abcdef123456',
       messagingSenderId: '123456789',
       projectId: 'your-project-id',
       storageBucket: 'your-project.appspot.com',
     );
   }
   ```

4. **Enable Google Sign-In:**
   - Firebase Console > Authentication > Sign-in method
   - Enable "Google" provider
   - Add authorized domains

5. **Update main.dart:**
   Replace hardcoded FirebaseOptions with:
   ```dart
   import 'firebase_options.dart';
   
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

## Important Notes

- **Firebase Web API Keys are NOT secrets** - they can be committed to version control safely
- The placeholder credentials currently in main.dart will NOT work - you must use real values
- For web authentication to work, you must add your Replit domain to Firebase's authorized domains
- The app will show a login screen when Firebase is not properly configured

## Testing

After setup:
1. Restart the Flutter workflow
2. The app should show the Google Sign-In button
3. Click "Sign in with Google"
4. Complete authentication
5. You should see the crypto mining interface

## Troubleshooting

**Blank screen:**
- Check browser console for Firebase errors
- Verify Firebase configuration is correct
- Ensure authorized domains are configured in Firebase Console

**"auth/unauthorized-domain" error:**
- Add your Replit domain to Firebase Console > Authentication > Settings > Authorized domains

**Google Sign-In popup blocked:**
- Allow popups for this domain
- Or enable browser popup permissions

## Additional Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com)
- [Google Sign-In for Flutter](https://firebase.google.com/docs/auth/web/google-signin)
