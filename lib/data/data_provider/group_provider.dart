import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/patient_provider.dart';
import 'package:demo_app2/data/data_provider/search_document.dart';
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
  static Future<List<String>> patients(String id) async {
    try {
      var db = FirebaseFirestore.instance;
      var ref = db.collection('groups').doc(id).collection('patients').get();
      var ans = ref.then((value) => value.docs);
      var patientIds = ans.then((value) => value.map((e) => e.id).toList());

      return patientIds;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
