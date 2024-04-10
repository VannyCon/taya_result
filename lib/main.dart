import 'package:cloud_firestore/cloud_firestore.dart';
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

void _showDeleteDialog(BuildContext context, String link) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: AlertDialog(
          title: const Text(
            'Delete Data',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Are you Sure you want to Delete this?',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  color: Color(0xFF413867),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                print(link);
              },
              child: const Text('YES'),
            ),
          ],
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  bool hasInternet = true;

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
          return FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseService.appStatus(), // Call the appStatus function here
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Luancher(); // Show a loading indicator while waiting for data
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Handle the snapshot data as per your requirement
                DocumentSnapshot? data = snapshot.data;
                if (data != null && data.exists) {
                  // Document exists, handle the data
                  String hasConstruction = data['UnderConstruction'].toString();
                  String forceUpdate = data['ForceUpdate'].toString();
                  String hasUpdate = data['Update'].toString();
                  String _link = data['updateLink'].toString();
                  print('link: $_link');

                  // Update the values of hasUpdate and hasConstruction
                  bool updateValue = hasUpdate.toLowerCase() == 'true';
                  bool constructionValue =
                      hasConstruction.toLowerCase() == 'true';
                  bool forceUpdateValue = forceUpdate.toLowerCase() == 'true';

                  // You can return widgets based on the data here if needed
                  if (!hasInternet) {
                    return NoInternetPage();
                  } else {
                    if (updateValue) {
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
                  }
                } else {
                  // Document does not exist or is empty
                  print('Document does not exist');
                  // You can return appropriate widgets here if needed
                  if (!hasInternet) {
                    return NoInternetPage();
                  } else {
                    return const MyHomePage(
                      title: 'Taya Result',
                    );
                  }
                }
              }
            },
          );
        },
      ),
    );
  }
}
