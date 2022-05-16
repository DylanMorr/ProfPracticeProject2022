import 'package:flutter/material.dart';
import 'package:flutter_project_2022/pages/main_pages/songsPage.dart';
import 'package:flutter_project_2022/pages/secondary_pages/rockHitsPage.dart';
import 'package:flutter_project_2022/pages/secondary_pages/uploadPage.dart';

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
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          // add a button to upload songs
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
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
        children: <Widget>[
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
            title: Text('Rock Hits'),
            onTap: () { // navigate to Songs page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => RockPage()));},
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
            title: Text('All Songs'),
            onTap: () { // navigate to Songs page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SongsPage()));},
          ),
        ],
      ),
    );
  }
}
