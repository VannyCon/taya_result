import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:taya_result/firebase/firebase_options.dart';
import 'package:taya_result/firebase/firebase_service.dart';
import 'package:taya_result/pages/ForceUpdate.dart';
import 'package:taya_result/pages/home_page.dart';
import 'package:taya_result/pages/404NotFound.dart';
import 'package:taya_result/pages/UpdateFound.dart';
import 'package:taya_result/pages/luncher.dart';
import 'package:taya_result/pages/nointernet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MobileAds.instance.initialize();
  print(DefaultFirebaseOptions.currentPlatform);
  loadAds();
  runApp(MyApp());
}

AppOpenAd? _appOpenAd; // Declared _appOpenAd globally

void loadAds() {
  AppOpenAd.load(
    adUnitId: 'ca-app-pub-3333485175428328/3107197761',
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taya Result',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return FutureBuilder<ConnectivityResult>(
            future: Connectivity().checkConnectivity(),
            builder: (BuildContext context,
                AsyncSnapshot<ConnectivityResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while waiting for connectivity check
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Handle error if any
                return Text('Error: ${snapshot.error}');
              } else {
                // Connectivity check is completed
                final hasInternet = snapshot.data != ConnectivityResult.none;

                // Proceed with Firebase initialization
                Firebase.initializeApp().then((_) {
                  // Initialize other services, load data, etc.
                  loadAds();
                });

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseService.appStatus(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Luancher();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      DocumentSnapshot? data = snapshot.data;
                      if (data != null && data.exists) {
                        String hasConstruction =
                            data['UnderConstruction'].toString();
                        String forceUpdate = data['ForceUpdate'].toString();
                        String hasUpdate = data['Update'].toString();
                        String _link = data['updateLink'].toString();

                        bool updateValue = hasUpdate.toLowerCase() == 'true';
                        bool constructionValue =
                            hasConstruction.toLowerCase() == 'true';
                        bool forceUpdateValue =
                            forceUpdate.toLowerCase() == 'true';

                        if (!hasInternet) {
                          return NoInternetPage();
                        } else if (updateValue) {
                          return UpdateFoundPage();
                        } else if (constructionValue) {
                          return NotFoundPage();
                        } else if (forceUpdateValue) {
                          return ForceUpdate();
                        } else {
                          return const MyHomePage(
                            title: 'Taya Result',
                          );
                        }
                      } else {
                        return const MyHomePage(
                          title: 'Taya Result',
                        );
                      }
                    }
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
