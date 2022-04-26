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
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Liked'),
          ),
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Pop'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Metal'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Irish Trad'),
          ),
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Dance Hits'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('2000s Hits'),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text(''),
          ),
        ],
      ),
    );
  }
}
