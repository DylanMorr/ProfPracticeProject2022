import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  // Create a file variable
  File? file;

  @override
  Widget build(BuildContext context) {
    // variable to store the fileName with default being No File Selected
    final fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      appBar: AppBar(
        title: new Text("Upload Songs"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              // sized box to space out fields
              SizedBox(
                height: 220.0,
              ),
              // create two buttons for selecting file and uploading to firebase
              OutlinedButton.icon(
                label: Text('Select Song'),
                onPressed: () {
                  // call selectFile method
                  selectFile();
                },
                icon: Icon(Icons.attach_file),
              ),
              SizedBox(
                height: 10.0,
              ),
              // text field to show filename on screen when selected
              Text(
                fileName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              // sized box to space out fields
              SizedBox(
                height: 70.0,
              ),
              OutlinedButton.icon(
                label: Text('Upload Song'),
                onPressed: () {},
                icon: Icon(Icons.cloud_upload),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // coded with the help of this video on selecting and uploading files
  // https://www.youtube.com/watch?v=dmZ9Tg9k13U&list=LL&index=9&t=437s&ab_channel=JohannesMilke
  Future selectFile() async {
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
}
