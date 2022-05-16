import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_2022/services/crud.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as Path;

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  // Helped work out uploading with this playlist of videos - https://www.youtube.com/playlist?list=PLBxWkM8PLHcpNxRIq2SZBt1WoJCUBCIiX

  // strings to hold
  late String artistName, songName, imgLink;

  // file variable
  File? file;
  // boolean to check if the upload button has been pressed to start loading the page
  bool _isLoading = false;
  // crudMethods object reference
  CrudAction crudMethods = new CrudAction();

  // method to select a song
  Future SelectSong() async {
    // set the filePicker result to only allow one file
    final fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    // if null return
    if (fileResult == null) return;
    // set the file path
    final filePath = fileResult.files.single.path!;

    // set the state of the file to the file path
    setState(() => file = File(filePath));
  }

  // method to upload everything to firebase
  finalUpload(BuildContext context) async {
    // check if file is not equal to null
    if (file != null) {
      // set the state of is loading to true
      setState(() {
        _isLoading = true;
      });

      // set the songTitle to the basename of the path / files actual name
      final songTitle = Path.basename(file!.path);
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      final uid = user?.uid;

      // create a reference instance to the storage system on firebase
      FirebaseStorage storage = FirebaseStorage.instance;
      // set the reference to a folder called songs and have the songs called their title
      Reference ref = storage.ref().child("songs").child(uid!).child("$songTitle");

      // create an upload task to put the file into the reference location
      final UploadTask uploadTask = ref.putFile(file!);

      // get the download url of the file back
      var downloadUrl = await (await uploadTask).ref.getDownloadURL();
      // output the url
      print("this is url $downloadUrl");

      // create a Map of strings to hold all the songs data
      Map<String, String> songMap = {
        "song_url": downloadUrl,
        "artist_name": artistName,
        "song_name": songName,
        "img_link": imgLink,
      };

      // call the crudMethods object and add the map data
      crudMethods.addData(songMap).then((result) {
        // once added navigate to library page
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    // variable to store the fileName with default being No File Selected
    final fileName =
        file != null ? Path.basename(file!.path) : 'No Song Selected';

    return Scaffold(
      appBar: AppBar(
        title: new Text("Upload Songs"),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0.0,
      ),
      // check if the body is loading
      body: _isLoading
          // if true return a containter with a circular progress indicator in the center
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          // if false return main form container
          : Container(
              child: Center(
                child: Column(
                  children: [
                    // sized box to space out fields
                    SizedBox(
                      height: 40.0,
                    ),

                    // text fields container
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          // Artist name field
                          TextField(
                            // add hint text
                            decoration:
                                InputDecoration(hintText: "Artist Name"),
                            // on changed set the artistName = value of the field
                            onChanged: (val) {
                              artistName = val;
                            },
                          ),
                          // song name field
                          TextField(
                            // add hint text
                            decoration: InputDecoration(hintText: "Song Name"),
                            // on changed set the songName = value of the field
                            onChanged: (val) {
                              songName = val;
                            },
                          ),
                          // Image link field
                          TextField(
                            // add hint text
                            decoration:
                                InputDecoration(hintText: "Link to Image"),
                            // on changed set the imgLink = value of the field
                            onChanged: (val) {
                              imgLink = val;
                            },
                          ),
                        ],
                      ),
                    ),

                    // sized box to space out fields
                    SizedBox(
                      height: 40.0,
                    ),

                    // create button for selecting song
                    OutlinedButton.icon(
                      label: Text('Select Song'),
                      onPressed: () {
                        // call Selectsong method
                        SelectSong();
                      },
                      icon: Icon(Icons.attach_file),
                    ),
                    // sized box to space out fields
                    SizedBox(
                      height: 10.0,
                    ),
                    // text field to show filename on screen when selected
                    Text(
                      fileName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),

                    // sized box to space out fields
                    SizedBox(
                      height: 70.0,
                    ),

                    // create button for uploading song
                    OutlinedButton.icon(
                      label: Text('Upload Song'),
                      // when pressed call the finalUpload method
                      onPressed: () => finalUpload(context),
                      icon: Icon(Icons.cloud_upload),
                    ),
                    // sized box to space out fields
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
