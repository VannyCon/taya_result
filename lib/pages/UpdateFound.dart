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
        backgroundColor: const Color(0xFFEAF2FD),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                widthFactor: double.infinity,
                child: Image.asset(
                  'images/update-min.png',
                  height: 400,
                  width: 400,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Time To Update',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF413867)),
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
                  var updateMessage = data['updateMessage'];

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
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                        title: 'TAYA RESULT',
                                      )), // navigate to MyHomePage
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.transparent),
                            elevation: MaterialStateProperty.all<double>(
                                0), // No shadow
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Adjust the radius as needed
                                side: const BorderSide(
                                    color: Colors.transparent), // No border
                              ),
                            ),
                          ),
                          child: const Text(
                            'Skip for Now',
                            style: TextStyle(
                              color: Color(0xFF413867), // Text color
                              fontSize: 16.0, // Font size
                              fontWeight: FontWeight.bold, // Font weight
                            ),
                          ),
                        ),
                        Container(
                          width: 250,
                          child: Center(
                            child: Text(
                              updateMessage,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 64, 222, 36),
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
