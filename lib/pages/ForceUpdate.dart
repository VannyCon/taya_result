import 'package:flutter/material.dart';

class ForceUpdate extends StatelessWidget {
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
                Icons.system_update,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              Text(
                'This is Force Update',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Logic to continue with the update
                  // For example:
                  // Navigator.pop(context); // Remove this page from the stack
                  // Then implement logic to proceed with the update
                },
                child: Text('Update'),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
