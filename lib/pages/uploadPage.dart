import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_project_2022/api/api-firebase.dart';
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
  // create a upload task variable
  UploadTask? uploadTask;

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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              // sized box to space out fields
              SizedBox(
                height: 70.0,
              ),
              // create button for uploading song
              OutlinedButton.icon(
                label: Text('Upload Song'),
                onPressed: () {
                  // call UploadSong method
                  UploadSong();
                },
                icon: Icon(Icons.cloud_upload),
              ),
              // sized box to space out fields
              SizedBox(
                height: 10.0,
              ),
              // show upload status when it is not null
              uploadTask != null ? buildUploadStatus(uploadTask!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  // coded with the help of this video on selecting and uploading files
  // https://www.youtube.com/watch?v=dmZ9Tg9k13U&list=LL&index=9&t=437s&ab_channel=JohannesMilke
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

  Future UploadSong() async {
    // check if file is null and return if it is
    if (file == null) return;

    // set the songName
    final songName = basename(file!.path);
    // destination to be stored in firebase
    final destination = 'songs/$songName';

    // upload the song using the api uploadtask
    uploadTask = FirebaseApi.Upload(destination, file!);

    // call set state so that ui gets reloaded and new task is received
    setState(() {});

    // check if upload task is null
    if (uploadTask == null) return;

    // return a snapshot when the download is complete
    final snapShot = await uploadTask!.whenComplete(() => {});
    // get the download link using the snapshot reference
    final downloadLink = await snapShot.ref.getDownloadURL();
    // print out download link
    print('Download Link: $downloadLink');
  }

  // create a method to track upload status using a streambuilder
  Widget buildUploadStatus(UploadTask uploadTask) => StreamBuilder<
          TaskSnapshot>(
      // in this stream builder we can listen to the changes of the upload task
      stream: uploadTask.snapshotEvents,
      // implement builder method
      builder: (context, snapShot) {
        // check if snapshot has any data
        if (snapShot.hasData) {
          // get the data from the snapshot
          final shot = snapShot.data!;
          // set the progress to bytes uploaded / total bytes
          final uploadProgress = shot.bytesTransferred / shot.totalBytes;
          // change progress to show as a percentage and set it to string as fixed with 2 numbers after point
          final uploadPercent = (uploadProgress * 100).toStringAsFixed(2);

          // display the progress in the ui
          return Text(
            '$uploadPercent %',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          // if no data return a container
          return Container();
        }
      });
}
