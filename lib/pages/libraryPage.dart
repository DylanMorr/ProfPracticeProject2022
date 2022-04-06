import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/uploadPage.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Library Page"),
        actions: <Widget>[
          // add a button to upload songs
          TextButton(
            onPressed: () {
              // navigate to uploadSong page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UploadPage()));
            },
            child: const Text('Add Songs'),
          ),
        ],
      ),
      body: new Center(
        child: new Text("This is the Library page"),
      ),
    );
  }
}
