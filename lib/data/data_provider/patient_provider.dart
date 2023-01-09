import 'package:cloud_firestore/cloud_firestore.dart';

import '../repositories/group_repo.dart';

class PatientCreate {
  //create a group in firebase
  static Future<String?> createPatient(Map<String, dynamic> map) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('groups')
        .doc(map['room'])
        .collection('patients')
        .doc(map['id']);
    try {
      var ans = ref.set({'profile': map});
      return null;
    } catch (e) {
      print(e);
    }

    return 'Error creating patient';
  }
}

class PatientRead {
  static Future<ShortPatient?> getShortPatient(String room, String id) async {
    var db = FirebaseFirestore.instance;
    var ref = db.collection('groups').doc(room).collection('patients').doc(id);
    print('read');
    try {
      var rawData = await ref.get();
      var profile = rawData['profile'];
      var shorData = {
        'id': profile['id'],
        'name': profile['name'],
        'medicalMethod': profile['medicalMethod'],
        'room': profile['room'],
      };
      print(shorData);
      var shortModel = ShortPatient.fromMap(shorData);
      print(shortModel);
      return shortModel;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
