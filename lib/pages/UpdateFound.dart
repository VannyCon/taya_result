import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taya_result/firebase/firebase_service.dart';
import 'package:taya_result/pages/home_page.dart';

class UpdateFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.system_update,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 20),
              const Text(
                'Update Found',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseService.updateLink(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  var data =
                      snapshot.data!.data() as Map<String, dynamic>? ?? {};
                  var updateLink = data['updateLink'];
                  return ElevatedButton(
                    onPressed: () {
                      FirebaseService.openLink(updateLink);
                    },
                    child: const Text('Update'),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(
                              title: 'TAYA RESULT',
                            )), // navigate to MyHomePage
                  );
                },
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
