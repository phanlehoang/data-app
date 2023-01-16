import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/regimen_provider.dart';
import 'package:data_app/data/models/enums.dart';

import '../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/no_insulin_sonde_cubit.dart';
import '../../models/profile.dart';
import '../../models/sonde/regimen.dart';

class NoInsulinSondeStateProvider {
  static CollectionReference noInsulinAddress(Profile profile) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .collection('NoInsulinState');
  }

  //create
  static Future<String?> createNoInsulinState({
    required Profile profile,
    required NoInsulinSondeState noInsulinSondeState,
  }) async {
    var ref = noInsulinAddress(profile);
    try {
      await ref.doc('data').set(noInsulinSondeState.toMapData());
      await SondeNoInsulinRegimenProvider.addRegimen(
        profile,
        noInsulinSondeState.regimen,
      );
    } catch (e) {
      return 'error';
    }
    return null;
  }

  //read
  static Future<NoInsulinSondeState> readNoInsulinState({
    required Profile profile,
  }) async {
    print('heeloo');
    var ref = noInsulinAddress(profile);
    try {
      var data = await ref.doc('data').get();
      var regimen = await SondeNoInsulinRegimenProvider.readRegimen(
        ref: ref.doc('regimen'),
      );
      print('hihi');
      if (regimen == null) {
        regimen = initialRegimen();
      }
      return NoInsulinSondeState(
        noInsulinSondeStatus: StringToEnum.stringToNoInsulinSondeStatus(
          data['status'],
        ),
        regimen: regimen,
      );
    } catch (e) {
      return initNoInsulinSondeState();
    }
  }

  //update
  static Future<String?> updateNoInsulinStateStatus({
    required Profile profile,
    required NoInsulinSondeStatus noInsulinSondeStatus,
  }) async {
    var ref = noInsulinAddress(profile);
    try {
      await ref.doc('data').set({
        'status': 'checkedGlucose',
      });
    } catch (e) {
      return 'error';
    }
    return null;
  }
}
