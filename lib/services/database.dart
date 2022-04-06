import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // reference to collection in firestore database - automatically create songs collection
  final CollectionReference songsCollection =
      FirebaseFirestore.instance.collection('songs');
  
}
