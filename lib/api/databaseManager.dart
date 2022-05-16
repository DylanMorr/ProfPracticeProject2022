import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FireStoreDataBase {
  // lists to hold songs
  List songsList = [];
  List rockHits = [];

  // reference to all songs collection
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("songsCollection");

  // reference to rock hits collection
  final CollectionReference rockRefColl =
      FirebaseFirestore.instance.collection("rockHitsCollection");

  // get the data for all songs
  Future getData() async {
    try {
      // take snapshots of the collection
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          // add the results to a list
          songsList.add(result.data());
        }
      });
      print(songsList);
      // return the list
      return songsList;
    } catch (e) {
      // catch any errors and return null
      debugPrint("Error - $e");
      return null;
    }
  }

  // get the rock hits data
  Future getRockHits() async {
    try {
      // take snapshots of the collection
      await rockRefColl.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          // add the results to a list
          rockHits.add(result.data());
        }
      });
      print(rockHits);
      // return the list
      return rockHits;
    } catch (e) {
      // catch any errors and return null
      debugPrint("Error - $e");
      return null;
    }
  }
}
