import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  List songsList = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("songsCollection");

  Future getData() async {
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          songsList.add(result.data());
        }
      });
      print(songsList);
      return songsList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
