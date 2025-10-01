import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isMining = false;
  double _minedCoins = 0.0;
  double _hashRate = 0.0;
  Timer? _miningTimer;
  final Random _random = Random();
  
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  bool _isBannerAdLoaded = false;
  bool _isRewardedAdLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _loadBannerAd();
      _loadRewardedAd();
    }
  }

  @override
  void dispose() {
    _miningTimer?.cancel();
    _bannerAd?.dispose();
    _rewardedAd?.dispose();
    super.dispose();
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bannerAd?.load();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          setState(() {
            _isRewardedAdLoaded = true;
          });
        },
        onAdFailedToLoad: (error) {
          setState(() {
            _isRewardedAdLoaded = false;
          });
        },
      ),
    );
  }

  void _toggleMining() {
    setState(() {
      _isMining = !_isMining;
      if (_isMining) {
        _hashRate = 20 + _random.nextDouble() * 100;
        _startMining();
      } else {
        _stopMining();
        _hashRate = 0.0;
      }
    });
  }

  void _startMining() {
    _miningTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _hashRate = 20 + _random.nextDouble() * 100;
        _minedCoins += _hashRate / 1000;
      });
    });
  }

  void _stopMining() {
    _miningTimer?.cancel();
  }

  void _claimRewards() {
    if (_minedCoins <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No coins to claim!')),
      );
      return;
    }

    if (kIsWeb) {
      final appState = Provider.of<MiningAppState>(context, listen: false);
      appState.incrementAdsWatched();
      
      setState(() {
        _minedCoins = 0.0;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rewards claimed! (AdMob only works on mobile apps)')),
      );
      return;
    }

    if (!_isRewardedAdLoaded || _rewardedAd == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rewarded ad is not ready yet. Please try again.')),
      );
      _loadRewardedAd();
      return;
    }

    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadRewardedAd();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to show ad. Please try again.')),
        );
      },
    );

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        final appState = Provider.of<MiningAppState>(context, listen: false);
        appState.incrementAdsWatched();
        
        setState(() {
          _minedCoins = 0.0;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Claimed ${reward.amount} rewards!')),
        );
      },
    );

    _rewardedAd = null;
    _isRewardedAdLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Miner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.currency_bitcoin,
                      size: 100,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Hash Rate',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _isMining ? '${_hashRate.toStringAsFixed(2)} H/s' : '0.00 H/s',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: _isMining ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Mined Coins',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _minedCoins.toStringAsFixed(4),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _toggleMining,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        backgroundColor: _isMining ? Colors.red : Colors.green,
                      ),
                      child: Text(
                        _isMining ? 'Stop Mining' : 'Start Mining',
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _minedCoins > 0 ? _claimRewards : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: const Text(
                        'Claim Rewards',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!kIsWeb && _isBannerAdLoaded && _bannerAd != null)
            SizedBox(
              height: _bannerAd!.size.height.toDouble(),
              width: _bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            )
          else if (kIsWeb)
            Container(
              height: 50,
              color: Colors.grey.withOpacity(0.2),
              child: const Center(
                child: Text(
                  'Banner Ad (AdMob only works on mobile apps)',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
