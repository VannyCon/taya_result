import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:taya_result/pages/home_page.dart';

class NoInternetPage extends StatefulWidget {
  @override
  _NoInternetPageState createState() => _NoInternetPageState();
}

class _NoInternetPageState extends State<NoInternetPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              widthFactor: double.infinity,
              child: Image.asset(
                'images/nointernet-min.png',
                height: 400,
                width: 400,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Internet',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w900,
                color: Color(0xFF413867),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : Container(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF413867),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                // Show circular loading indicator
                setState(() {
                  _isLoading = true;
                });

                // Check for internet connectivity
                Connectivity().checkConnectivity().then((connectivityResult) {
                  if (connectivityResult != ConnectivityResult.none) {
                    // If internet is available, navigate to MyHomePage after 2 seconds
                    Timer(Duration(seconds: 2), () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: "TAYA RESULT",
                          ),
                        ),
                      );
                    });
                  }

                  // Hide circular loading indicator after 2 seconds
                  Timer(Duration(seconds: 2), () {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                });
              },
              child: const Text(
                'Retry',
                style: TextStyle(
                  color: Color(0xFFEAF2FD),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 350,
              child: const Center(
                child: Text(
                  'Please Check your WiFi or Data Connection',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 222, 36, 36),
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
