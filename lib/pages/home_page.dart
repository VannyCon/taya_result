import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taya_result/firebase/firebase_service.dart';
import 'package:taya_result/theme/theme.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isDarkMode = true;
  String _searchText = '';
  // ignore: unused_field
  String _version = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _getAppVersion();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Future<void> _launchURL(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Future<void> _getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        _version = packageInfo.version;
      });
    } catch (e) {
      print("Error fetching package info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = _isDarkMode
        ? MyColorSchemes.darkModeScheme
        : MyColorSchemes.lightModeScheme;

    return AnimatedTheme(
      duration: Duration(milliseconds: 500),
      data: theme.copyWith(
        colorScheme: colorScheme,
      ),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'TAYA RESULT',
                          style: TextStyle(
                            fontSize: 30,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'STL NEGROS OCCIDENTAL',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: _toggleDarkMode,
                      icon: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: colorScheme.onSecondary,
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                        child: Icon(
                          _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: colorScheme.outline),
                    prefixIcon: Icon(Icons.search, color: colorScheme.outline),
                    filled: true,
                    fillColor: colorScheme.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Set your desired border radius
                      borderSide: BorderSide.none, // Remove the border color
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 16.0), // Adjust padding as needed
                  ),
                  style: TextStyle(color: colorScheme.outline),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9.0),
                  child: Container(
                    color: colorScheme.onBackground,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseService().getNotesStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        }
                        // Assuming your Firestore documents have fields named 'Date', '10:30AM', '3PM', '7PM'
                        var dataList = snapshot.data!.docs
                            .map((doc) => doc.data() as Map<String, dynamic>)
                            .toList();
                        dataList = dataList.where((note) {
                          String datelower = note['Date'].toLowerCase();
                          String dateupper = note['Date'].toUpperCase();
                          String agalower = note['10:30AM'].toLowerCase();
                          String agaupper = note['10:30AM'].toUpperCase();
                          String udtolower = note['3PM'].toLowerCase();
                          String udtoupper = note['3PM'].toUpperCase();
                          String gabelower = note['7PM'].toLowerCase();
                          String gabeupper = note['7PM'].toUpperCase();
                          return datelower
                                  .contains(_searchText.toLowerCase()) ||
                              dateupper.contains(_searchText.toUpperCase()) ||
                              agalower.contains(_searchText.toLowerCase()) ||
                              agaupper.contains(_searchText.toUpperCase()) ||
                              udtolower.contains(_searchText.toLowerCase()) ||
                              udtoupper.contains(_searchText.toUpperCase()) ||
                              gabelower.contains(_searchText.toLowerCase()) ||
                              gabeupper.contains(_searchText.toUpperCase());
                        }).toList();
                        return Column(
                          children: [
                            Container(
                              color: colorScheme.primary,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        color: colorScheme.secondary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(''),
                                    Text(
                                      '10:30AM',
                                      style: TextStyle(
                                        color: colorScheme.secondary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      '3PM',
                                      style: TextStyle(
                                        color: colorScheme.secondary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      '7PM',
                                      style: TextStyle(
                                        color: colorScheme.secondary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    10), // Adjust the spacing between header and data rows
                            ...dataList
                                .expand((data) => [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              data['Date'] ?? 'Unknown Date',
                                              style: TextStyle(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              data['10:30AM'] ?? '',
                                              style: TextStyle(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              data['3PM'] ?? '',
                                              style: TextStyle(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                            Text(
                                              data['7PM'] ?? '',
                                              style: TextStyle(
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Divider(
                                            height: 1, color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ) // Divider after each row
                                    ])
                                .toList(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
