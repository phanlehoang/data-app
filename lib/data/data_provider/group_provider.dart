import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/search_document.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GroupValidator {
  static Future<String?> idExist(String id) async {
    var ans = await searchGroupId('groups', id);
    if (ans) {
      return null;
    }
    return 'Group ID does not exist';
  }

  static Future<String?> idCreateValid(String id) async {
    var ans = await searchGroupId('groups', id);
    if (ans) {
      return 'Group ID already exists';
    }
    return null;
  }
}

class GroupCreate {
  static Future<String?> createGroup(
      String id, Map<String, dynamic> map) async {
    var db = FirebaseFirestore.instance;
    var ref = db.collection('groups').doc(id);
    try {
      var ans = ref.set(map);
      return null;
    } catch (e) {
      print(e);
    }

    return 'Error creating group';
  }
}

class GroupRead {
  static Future<List<dynamic>?> patients(String id) async {
    try {
      var db = FirebaseFirestore.instance;
      var ref = db.collection('groups').doc(id).collection('patients').get();
      var ans = ref.then((value) => value.docs);
      var documents = await ans;
      if (documents.length > 0) {
        return documents.map((e) => e.data()).toList();
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
