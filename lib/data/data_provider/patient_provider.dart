import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/profile.dart';
import '../../logic/0_home_blocs.dart/0.2.list_short_patients_cubit/group_repo.dart';

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
    try {
      var rawData = await ref.get();
      var profile = rawData['profile'];
      var shorData = {
        'id': profile['id'],
        'name': profile['name'],
        'medicalMethod': profile['medicalMethod'],
        'room': profile['room'],
      };
      var shortModel = ShortPatient.fromMap(shorData);
      return shortModel;
    } catch (e) {
      print(e);
    }
    return null;
  }

  //get patient profile
  static Future<Profile?> getPatient(String room, String id) async {
    var db = FirebaseFirestore.instance;
    var ref = db.collection('groups').doc(room).collection('patients').doc(id);
    try {
      print('try');
      var rawData = await ref.get();
      var profile = rawData['profile'];
      print('profile $profile');
      var model = Profile.fromMap(profile);
      print('model $model');
      return model;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

class PatientUpdate {
  //updaate patient profile
  static Future<String?> updateProfileAttribute(
    Profile profile,
    String attribute,
    dynamic value,
  ) async {
    var db = FirebaseFirestore.instance;
    var ref = db
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id);
    try {
      var ans = ref.update({'profile.${attribute}': value});
      return null;
    } catch (e) {
      print(e);
    }

    return 'Error updating patient';
  }
}
