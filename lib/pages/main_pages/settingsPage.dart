import 'package:flutter/material.dart';
import 'package:flutter_project_2022/services/authenticate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // create instance of authenticate service
  final AuthenticateService _auth = AuthenticateService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings Page"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
      ),
      body: new Center(
        // add an elevated button to log out
        child: new ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurpleAccent,
            ),
            icon: Icon(Icons.person),
            label: Text('Log Out'),
            onPressed: () async {
              // use instance of authenticate method to log out
              await _auth.logOut();
            },
          ),
      ),
    );
  }
}
