import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taya_result/firebase/firebase_service.dart';

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
              Center(
                widthFactor: double.infinity,
                child: Image.asset(
                  'images/underconstruction-min.png',
                  height: 400,
                  width: 400,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Under Maintenance',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
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
                  var underConstruction = data['underConstruction'];
                  return Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Container(
                          width: 350,
                          child: Center(
                            child: Text(
                              underConstruction,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 222, 36, 36),
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
