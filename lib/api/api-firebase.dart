import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  /// Video Reference - https://www.youtube.com/watch?v=dmZ9Tg9k13U&t=308s&ab_channel=JohannesMilke ///

  // create a upload Task to upload
  static UploadTask? Upload(String destination, File song) {
    // surround with try catch
    try {
      // reference to the destination
      final storageRef = FirebaseStorage.instance.ref(destination);

      // returns the upload task
      return storageRef.putFile(song);
    } on FirebaseException catch (e) {
      // catch any firebase exceptions
      // if there is an exception return null
      print(e.message);
      return null;
    }
  }

  // create a upload Task to upload bytes
  static UploadTask? UploadBytes(String destination, Uint8List bytes) {
    // surround with try catch
    try {
      // reference to the destination
      final storageRef = FirebaseStorage.instance.ref(destination);

      // returns the upload task
      return storageRef.putData(bytes);
    } on FirebaseException catch (e) {
      // catch any firebase exceptions
      // if there is an exception return null
      print(e.message);
      return null;
    }
  }
}
