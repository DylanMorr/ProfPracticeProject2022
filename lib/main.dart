import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title at top of app
      title: 'Music Player',
      theme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // set homepage class
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // create a homepage state
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // set the text style
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // create a list of widgets for each page
  static const List<Widget> _widgetOptions = <Widget>[
    // home page widget
    Text(
      'Home Page',
      style: optionStyle,
    ),
    // search page widget
    Text(
      'Search Songs',
      style: optionStyle,
    ),
    // library page widget
    Text(
      'Music Library',
      style: optionStyle,
    ),
    // settings page widget
    Text(
      'App Settings',
      style: optionStyle,
    ),
  ];

  // set the state when item is tapped on navbar
  void _onItemTapped(int index) {
    setState(() {
      // set the selected index to the index
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add a appbar
      appBar: AppBar(
        // add a title and a background color
        title: const Text('Music Player'),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      // in the body display the widget under _widgetoptions list at selected index
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // add a bottom nav bar
      bottomNavigationBar: BottomNavigationBar(
        // create a items section
        items: const <BottomNavigationBarItem>[
          // home page item
          BottomNavigationBarItem(
            // add the icon a label and change the color
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.deepPurpleAccent,
          ),

          // seach bar item
          BottomNavigationBarItem(
            // add the icon a label and change the color
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.deepPurpleAccent,
          ),

          // music library item
          BottomNavigationBarItem(
            // add the icon a label and change the color
            icon: Icon(Icons.my_library_music),
            label: 'Library',
            backgroundColor: Colors.deepPurpleAccent,
          ),

          // settings item
          BottomNavigationBarItem(
            // add the icon a label and change the color
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.deepPurpleAccent,
          ),
        ],

        // set current index to the selected one
        currentIndex: _selectedIndex,
        // set the selected item in nav bar color to amber
        selectedItemColor: Colors.amber[800],
        // call on tap method
        onTap: _onItemTapped,
      ),
    );
  }
}
