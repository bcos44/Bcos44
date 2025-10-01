import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  bool get isFirebaseInitialized {
    try {
      Firebase.app();
      return true;
    } catch (e) {
      return false;
    }
  }

  User? get currentUser => isFirebaseInitialized ? _auth.currentUser : null;
  Stream<User?> get authStateChanges => isFirebaseInitialized 
      ? _auth.authStateChanges() 
      : Stream.value(null);

  Future<UserCredential?> signInWithGoogle() async {
    if (!isFirebaseInitialized) {
      throw Exception('Firebase is not initialized. Please configure Firebase first.');
    }
    
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        return await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        
        if (googleUser == null) {
          return null;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in with Google: $e');
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    if (!isFirebaseInitialized) {
      throw Exception('Firebase is not initialized.');
    }
    
    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out: $e');
      }
      rethrow;
    }
  }

  String? getUserDisplayName() {
    return currentUser?.displayName;
  }

  String? getUserEmail() {
    return currentUser?.email;
  }

  String? getUserPhotoUrl() {
    return currentUser?.photoURL;
  }
}
