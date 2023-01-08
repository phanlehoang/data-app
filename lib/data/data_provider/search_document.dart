//search a document
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/group.dart';

Future<bool> searchGroupId(String nameOfCollection, String id) async {
  var db = FirebaseFirestore.instance;
  print("Active Users");
  //check if id in collection
  var snapshot = await db.collection(nameOfCollection).doc(id).get();
  if (snapshot.exists) {
    return true;
  } else {
    return false;
  }
}

Future<Group?> searchGroup(String nameOfCollection, String id) async {
  var db = FirebaseFirestore.instance;
  print("Active Users");
  //check if id in collection
  var snapshot = await db.collection(nameOfCollection).doc(id).get();
  if (snapshot.exists) {
    print("User exists");
    return Group(
      id: snapshot.id,
      Patients: [],
      nameMaster: snapshot.data()!['nameMaster'],
    );
  } else {
    print("User does not exist");
    return null;
  }
}
