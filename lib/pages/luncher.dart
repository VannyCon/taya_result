import 'dart:async';

import 'package:flutter/material.dart';

class Luancher extends StatefulWidget {
  @override
  State<Luancher> createState() => _LuancherState();
}

class _LuancherState extends State<Luancher> {
  Widget build(BuildContext context) {
    bool _showText = false;

    @override
    void initState() {
      super.initState();
      // After 5 seconds, set _showText to true
      Timer(const Duration(seconds: 5), () {
        setState(() {
          _showText = true;
        });
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logo_dev_sharp,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to my Appp',
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                'Wait for a few Seconds',
                style: TextStyle(fontSize: 15),
              ),
              const CircularProgressIndicator(),
              _showText
                  ? const Text(
                      'Please Check your Internet',
                      style: TextStyle(fontSize: 15),
                    )
                  : Container(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
