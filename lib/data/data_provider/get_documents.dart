import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getDocuments(String nameOfCollection) async {
  var db = FirebaseFirestore.instance;
  //get documents from collection
  var snapshot = await db.collection(nameOfCollection).get();
  var documents = snapshot.docs;

  if (documents.length > 0) {
    try {
      print("Active ${documents.length}");
      return documents.map((e) => e.id).toList();
    } catch (e) {
      print("Exception $e");
      return [];
    }
  }
  return [];
}
