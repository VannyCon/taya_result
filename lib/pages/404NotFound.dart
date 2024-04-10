import 'package:flutter/material.dart';

void main() {
  runApp(NotFoundPage());
}

class NotFoundPage extends StatelessWidget {
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
                Icons.error_outline,
                size: 100,
                color: Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                'Under Maintenance',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
