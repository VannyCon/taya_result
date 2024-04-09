import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:taya_result/firebase/firebase_options.dart';
import 'package:taya_result/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  print(DefaultFirebaseOptions.currentPlatform);
  loadAds();
  runApp(const MyApp());
}

AppOpenAd? _appOpenAd; // Declared _appOpenAd globally

void loadAds() {
  AppOpenAd.load(
    adUnitId: 'ca-app-pub-3333485175428328~3888962249',
    request: AdRequest(),
    adLoadCallback: AppOpenAdLoadCallback(
      onAdLoaded: (ad) {
        // Changed to onAdLoaded
        _appOpenAd = ad as AppOpenAd; // Cast the ad to AppOpenAd
        _appOpenAd!.show();
      },
      onAdFailedToLoad: (error) {
        // Changed to onAdFailedToLoad
        debugPrint("Error $error");
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taya Result',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Taya Result'),
    );
  }
}
