import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taya_result/firebase/firebase_service.dart';
import 'package:taya_result/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    _loadDarkModeStatus();
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _saveDarkModeStatus(
          _isDarkMode); // Save the dark mode status when toggled
    });
  }

  Future<void> _loadDarkModeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // If there is no stored value, use true as default (dark mode)
      _isDarkMode = prefs.getBool('darkMode') ?? true;
    });
  }

  Future<void> _saveDarkModeStatus(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = _isDarkMode
        ? MyColorSchemes.darkModeScheme
        : MyColorSchemes.lightModeScheme;

    return AnimatedTheme(
      duration: const Duration(milliseconds: 500),
      data: theme.copyWith(
        colorScheme: colorScheme,
      ),
      child: Scaffold(
        backgroundColor: colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _showCreditsDialog(context);
                          },
                          icon: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: colorScheme.onSecondary,
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust the border radius as needed
                            ),
                            child: Icon(
                              Icons.info,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleDarkMode,
                          icon: Container(
                            padding: const EdgeInsets.all(8.0),
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
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 16.0,
                    ),
                  ),
                  style: TextStyle(color: colorScheme.outline),
                  keyboardType: TextInputType.number, // Display numeric keypad
                ),
                const SizedBox(
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
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        }

                        // Assuming your Firestore documents have fields named 'Date', '10:30AM', '3PM', '7PM'
                        // Assuming your Firestore documents have fields named 'Date', '10:30AM', '3PM', '7PM'
                        var dataList = snapshot.data!.docs
                            .map((doc) => doc.data() as Map<String, dynamic>)
                            .toList();
                        // Convert search text to upper case
                        String searchText = _searchText.toUpperCase();
                        // Remove hyphens from search text
                        searchText = searchText.replaceAll('-', '');
                        // Filter the dataList based on the preprocessed search text
                        dataList = dataList.where((note) {
                          final date = note['Date'] as String? ?? '';
                          final time1 = note['10:30AM'] as String? ?? '';
                          final time2 = note['3PM'] as String? ?? '';
                          final time3 = note['7PM'] as String? ?? '';

                          return date.contains(searchText) ||
                              time1.replaceAll('-', '').contains(searchText) ||
                              time2.replaceAll('-', '').contains(searchText) ||
                              time3.replaceAll('-', '').contains(searchText);
                        }).toList();

                        return ReturnMainColumn(colorScheme, dataList);
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

  Column ReturnMainColumn(
      ColorScheme colorScheme, List<Map<String, dynamic>> dataList) {
    return Column(
      children: [
        Container(
          color: colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Date',
                  style: TextStyle(
                    color: colorScheme.secondary,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(''),
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
        const SizedBox(
            height: 10), // Adjust the spacing between header and data rows
        ...dataList
            .expand((data) => [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          data['Date'] ?? 'Unknown Date',
                          style: TextStyle(
                            color: colorScheme.primary,
                          ),
                        ),
                        Text(
                          data['10:30AM'] ?? '---------',
                          style: TextStyle(
                            color: colorScheme.primary,
                          ),
                        ),
                        Text(
                          data['3PM'] ?? '---------',
                          style: TextStyle(
                            color: colorScheme.primary,
                          ),
                        ),
                        Text(
                          data['7PM'] ?? '---------',
                          style: TextStyle(
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(height: 1, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ) // Divider after each row
                ])
            .toList(),
      ],
    );
  }
}

void _showCreditsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Credits'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your Name'),
            Text('Your Link'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
