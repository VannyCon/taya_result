import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:taya_result/pages/home_page.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.signal_wifi_off,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Check for internet connectivity
                Connectivity().checkConnectivity().then((connectivityResult) {
                  if (connectivityResult != ConnectivityResult.none) {
                    // If internet is available, navigate to MyHomePage
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                        title: "TAYA RESULT",
                      ),
                    ));
                  }
                });
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
