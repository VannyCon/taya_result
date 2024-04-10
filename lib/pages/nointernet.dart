import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_off,
                size: 100,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement a function to retry connecting to the internet
                  // For example:
                  // Navigator.pop(context); // Remove this page from the stack
                  // Then implement logic to retry connecting
                },
                child: Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
