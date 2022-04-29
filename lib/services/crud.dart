import 'package:cloud_firestore/cloud_firestore.dart';

// crud action method
class CrudAction {
  // add data future mthod
  Future<void> addData(songData) async {
    // get instance of the collection songs and add the data to it & catch any errors and output to console
    FirebaseFirestore.instance
        .collection("songsCollection")
        .add(songData)
        .catchError((e) {
      print(e);
    });
  }
}
