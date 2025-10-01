import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'login_screen.dart';
import 'auth_service.dart';
import 'firebase_options_placeholder.dart';

bool _firebaseInitialized = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (DefaultFirebaseOptions.hasValidConfiguration) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _firebaseInitialized = true;
    } catch (e) {
      if (kDebugMode) {
        print('Firebase initialization error: $e');
      }
      _firebaseInitialized = false;
    }
  } else {
    if (kDebugMode) {
      print('Firebase not configured. Using placeholder credentials.');
      print('Please run "flutterfire configure" to set up Firebase,');
      print('or replace firebase_options_placeholder.dart with real values.');
    }
    _firebaseInitialized = false;
  }
  
  if (!kIsWeb) {
    await MobileAds.instance.initialize();
  }
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => MiningAppState(),
      child: const CryptoMinerApp(),
    ),
  );
}

class CryptoMinerApp extends StatelessWidget {
  const CryptoMinerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MiningAppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          title: 'Crypto Miner',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: _firebaseInitialized
              ? StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const LoginScreen();
                    }
                    
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                              Text('Loading...'),
                            ],
                          ),
                        ),
                      );
                    }
                    
                    if (snapshot.hasData) {
                      return const HomeScreen();
                    }
                    
                    return const LoginScreen();
                  },
                )
              : const LoginScreen(),
        );
      },
    );
  }
}

class MiningAppState extends ChangeNotifier {
  bool _isDarkMode = true;
  int _adsWatched = 0;
  User? _currentUser;
  
  MiningAppState() {
    _loadPreferences();
    _listenToAuthChanges();
  }
  
  bool get isDarkMode => _isDarkMode;
  int get adsWatched => _adsWatched;
  User? get currentUser => _currentUser;
  
  void _listenToAuthChanges() {
    if (!_firebaseInitialized) return;
    
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        _currentUser = user;
        notifyListeners();
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error listening to auth changes: $e');
      }
    }
  }
  
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _savePreferences();
    notifyListeners();
  }
  
  void incrementAdsWatched() {
    _adsWatched++;
    _savePreferences();
    notifyListeners();
  }
  
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? true;
    _adsWatched = prefs.getInt('adsWatched') ?? 0;
    notifyListeners();
  }
  
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setInt('adsWatched', _adsWatched);
  }
}
