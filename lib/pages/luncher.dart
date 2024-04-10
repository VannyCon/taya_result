import 'package:flutter/material.dart';

class Luancher extends StatelessWidget {
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
                Icons.logo_dev_sharp,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to my Appp',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                'Wait for a few Seconds',
                style: TextStyle(fontSize: 15),
              ),
              CircularProgressIndicator(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
