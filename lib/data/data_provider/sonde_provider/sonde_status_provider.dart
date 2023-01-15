import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/models/enums.dart';

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
      'sondeStatus': sondeStatus.toString(),
    }).catchError((error) {
      return error.toString();
    });
    //nếu error thì return String error
    return null;
  }
}
