import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/models/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import '../../models/profile.dart';

class SondeStatusUpdate {
  static Future<String?> updateSondeStatus({
    required Profile profile,
    required SondeStatus sondeStatus,
  }) async {
    var sonde = FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde');
    await sonde.update({
      'status': EnumToString.enumToString(sondeStatus),
    }).catchError((error) {
      return error.toString();
    });
    //nếu error thì return String error
    return null;
  }
}

//collection reference
class SondeStateCreate {
  static Future<String?> createSondeState({
    required Profile profile,
    required SondeState sondeState,
  }) async {
    print('create');
    try {
      var docRef = sondeReference(profile);
      docRef.set(sondeState.toMap());
      return null;
    } catch (e) {
      return e.toString();
    }
  }
}

DocumentReference<Map<String, dynamic>> sondeReference(Profile profile) {
  return FirebaseFirestore.instance
      .collection('groups')
      .doc(profile.room)
      .collection('patients')
      .doc(profile.id)
      .collection('medicalMethods')
      .doc('Sonde');
}
