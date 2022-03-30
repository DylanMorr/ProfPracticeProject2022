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
        // set up signout text button on appBar
        actions: <Widget>[
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              // use instance of authenticate method to log out
              await _auth.logOut();
            },
          )
        ],
      ),
      body: new Center(
        child: new Text("This is the Settings page"),
      ),
    );
  }
}
