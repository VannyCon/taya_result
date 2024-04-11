import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taya_result/firebase/firebase_service.dart';
import 'package:taya_result/theme/theme.dart';

class ForceUpdate extends StatelessWidget {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = _isDarkMode
        ? MyColorSchemes.darkModeScheme
        : MyColorSchemes.lightModeScheme;
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
                  'images/forceupdate-min.png',
                  height: 400,
                  width: 400,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Force Update',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF413867)),
              ),
              const SizedBox(height: 5),
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
                  var forceUpdatemessage = data['forceUpMessage'];
                  return Container(
                    height: 150,
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: Column(
                      children: [
                        Container(
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF413867),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              FirebaseService.openLink(updateLink);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Color(0xFFEAF2FD),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 350,
                          child: Center(
                            child: Text(
                              forceUpdatemessage,
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
