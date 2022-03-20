import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/homePage.dart';
import 'package:flutter_project_2022/pages/libraryPage.dart';
import 'package:flutter_project_2022/pages/searchPage.dart';
import 'package:flutter_project_2022/pages/settingsPage.dart';

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
      home: BotNavBar(),
    );
  }
}

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int _selectedIndex = 0;
  final List<Widget> index = [
    HomePage(),
    SearchPage(),
    LibraryPage(),
    SettingsPage(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: index[_selectedIndex],
      //add a bottom nav bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _selectedIndex,
        // create a items section
        items: [
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

          // music library itemR
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
      ),
    );
  }
}












































// class _HomePageState extends State<HomePage> {
//   

//   // set the text style
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   // create a list of widgets for each page
//   static const List<Widget> _widgetOptions = <Widget>[
//     // home page widget
//     Text(
//       'Home Page',
//       style: optionStyle,
//     ),
//     // search page widget
//     Text(
//       'Search Songs',
//       style: optionStyle,
//     ),
//     // library page widget
//     Text(
//       'Music Library',
//       style: optionStyle,
//     ),
//     // settings page widget
//     Text(
//       'App Settings',
//       style: optionStyle,
//     ),
//   ];

//   // set the state when item is tapped on navbar
//   void _onItemTapped(int index) {
//     setState(() {
//       // set the selected index to the index
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // add a appbar
//       appBar: AppBar(
//         // add a title and a background color
//         title: const Text('Music Player'),
//         backgroundColor: Colors.deepPurpleAccent,
//       ),

//       // in the body display the widget under _widgetoptions list at selected index
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),

//       // add a bottom nav bar
//       bottomNavigationBar: BottomNavigationBar(
//         // create a items section
//         items: const <BottomNavigationBarItem>[
//           // home page item
//           BottomNavigationBarItem(
//             // add the icon a label and change the color
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: Colors.deepPurpleAccent,
//           ),

//           // seach bar item
//           BottomNavigationBarItem(
//             // add the icon a label and change the color
//             icon: Icon(Icons.search),
//             label: 'Search',
//             backgroundColor: Colors.deepPurpleAccent,
//           ),

//           // music library item
//           BottomNavigationBarItem(
//             // add the icon a label and change the color
//             icon: Icon(Icons.my_library_music),
//             label: 'Library',
//             backgroundColor: Colors.deepPurpleAccent,
//           ),

//           // settings item
//           BottomNavigationBarItem(
//             // add the icon a label and change the color
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//             backgroundColor: Colors.deepPurpleAccent,
//           ),
//         ],

//         // set current index to the selected one
//         currentIndex: _selectedIndex,
//         // set the selected item in nav bar color to amber
//         selectedItemColor: Colors.amber[800],
//         // call on tap method
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
