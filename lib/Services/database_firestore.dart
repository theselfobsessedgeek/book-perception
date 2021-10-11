import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  Future<void> addToFav(Map<String, dynamic> favBook);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({this.uid}) : assert(uid != null);
  final String uid;
  @override
  Future<void> addToFav(Map<String, dynamic> favBook) async {
    final path = '$uid/${favBook['title']}';
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(favBook);
  }
}
