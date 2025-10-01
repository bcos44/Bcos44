import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
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
          home: const HomeScreen(),
        );
      },
    );
  }
}

class MiningAppState extends ChangeNotifier {
  bool _isDarkMode = true;
  int _adsWatched = 0;
  
  MiningAppState() {
    _loadPreferences();
  }
  
  bool get isDarkMode => _isDarkMode;
  int get adsWatched => _adsWatched;
  
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
