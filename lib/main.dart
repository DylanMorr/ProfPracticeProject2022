import 'package:flutter/material.dart';
import 'package:flutter_project_2022/models/userModel.dart';
import 'package:flutter_project_2022/pages/main_pages/homePage.dart';
import 'package:flutter_project_2022/pages/main_pages/libraryPage.dart';
import 'package:flutter_project_2022/pages/main_pages/songsPage.dart';
import 'package:flutter_project_2022/pages/main_pages/settingsPage.dart';
import 'package:flutter_project_2022/pages/secondary_pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_project_2022/services/authenticate.dart';
import 'package:provider/provider.dart';

void main() async {
  // create an instance of widgetbinding to ensure initialisation as initializeApp needs to use platform channels to call native
  WidgetsFlutterBinding.ensureInitialized();
  // firebase must be initialized before any firebase products can be used - use await as this is important and needs to complete
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // use a stream provider to listen to a stream of type UserModel? type - stream always listening for authenticate
    return StreamProvider<UserModel?>.value(
      initialData: null,
      // value is the stream the provider is listening to
      value: AuthenticateService().user,
      // wraps the MaterialApp root widget which means everything can access data provided by provider
      child: MaterialApp(
        // title at top of app
        title: 'Music Player',
        theme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // set homepage class
        home: Wrapper(),
      ),
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
    SongsPage(),
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
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
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
            icon: Icon(Icons.album),
            label: 'All Songs',
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
