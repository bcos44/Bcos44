import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          Consumer<MiningAppState>(
            builder: (context, appState, child) {
              return SwitchListTile(
                title: const Text('Dark Theme'),
                subtitle: const Text('Toggle between dark and light mode'),
                value: appState.isDarkMode,
                onChanged: (value) {
                  appState.toggleTheme();
                },
                secondary: Icon(
                  appState.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
              );
            },
          ),
          const Divider(),
          Consumer<MiningAppState>(
            builder: (context, appState, child) {
              return ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('Ads Watched'),
                subtitle: Text('You have watched ${appState.adsWatched} rewarded ads'),
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${appState.adsWatched}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Crypto Miner Simulator',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                const Text('Version 1.0.0'),
                const SizedBox(height: 15),
                const Text(
                  'A fun simulation app that lets you experience crypto mining with realistic hash rates and coin accumulation.',
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.info, color: Colors.orange),
                          const SizedBox(width: 8),
                          Text(
                            'AdMob Configuration',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Currently using Google AdMob test ad unit IDs:',
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Banner: ca-app-pub-3940256099942544/6300978111',
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                      ),
                      const Text(
                        'Rewarded: ca-app-pub-3940256099942544/5224354917',
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Replace these with your own AdMob IDs in home.dart before publishing.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
