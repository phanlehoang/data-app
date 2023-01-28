import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/profile.dart';
import '../../models/sonde/sonde_lib.dart';

class SondeCollectionsProvider {
  static DocumentReference fastInsulinStateRef(Profile profile) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .collection('FastInsulin')
        .doc('regimenState');
  }

  static Future<Regimen> getRegimenFastInsulinState(Profile profile) async {
    var ref = fastInsulinStateRef(profile);
    var doc = await ref.get();
    if (doc.exists) {
      var _state = RegimenState.fromMap(doc.data() as Map<String, dynamic>);

      return _state.regimen;
    } else {
      return initialRegimen();
    }
  }

// ref to history old fast
  static CollectionReference fastInsulinHistoryRef(Profile profile) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .collection('HistoryOld');
  }
}
