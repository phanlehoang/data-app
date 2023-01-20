import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/profile.dart';
import '../models/sonde/sonde_lib.dart';
import '../models/sonde/3_medical_take_insulin.dart';
import '../models/sonde/4_regimen.dart';

//viết hàm chèn thêm số 0 vào để có đúng 3 chữ số
String addZero(int number) {
  if (number < 10) {
    return '00$number';
  } else if (number < 100) {
    return '0$number';
  } else {
    return '$number';
  }
}

class SondeNoInsulinRegimenProvider {
  static DocumentReference regimenAddress(Profile profile) {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .collection('NoInsulinState')
        .doc('regimen');
  }

  static Future<String?> addRegimen(Profile profile, Regimen regimen) async {
    var ref = regimenAddress(profile);
    try {
      addMedicalTakeInsulins(
        ref: ref,
        medicalTakeInsulins: regimen.medicalTakeInsulins,
      );
      addMedicalCheckGlucoses(
        ref: ref,
        medicalCheckGlucoses: regimen.medicalCheckGlucoses,
      );
      addMedicalActions(
        ref: ref,
        medicalActions: regimen.medicalActions,
      );
    } catch (e) {
      return 'error';
    }
    return null;
  }

  static Future<Regimen?> readRegimenFromProfile(Profile profile) async {
    return readRegimen(
      ref: regimenAddress(profile),
    );
  }

  static Future<Regimen?> readRegimen({
    required DocumentReference ref,
  }) async {
    try {
      var medicalTakeInsulins = await readMedicalTakeInsulins(ref: ref);
      var medicalCheckGlucoses = await readMedicalCheckGlucoses(ref: ref);
      var medicalActions = await readMedicalActions(ref: ref);
      //delay 1s
      return Regimen(
        medicalTakeInsulins: medicalTakeInsulins,
        medicalCheckGlucoses: medicalCheckGlucoses,
        medicalActions: medicalActions,
      );
    } catch (e) {
      return null;
    }
  }

  //read medicalCheckGlucoses
  static Future<List<MedicalCheckGlucose>> readMedicalCheckGlucoses({
    required DocumentReference ref,
  }) async {
    try {
      var docs = await ref.collection('medicalCheckGlucoses').get();
      var medicalCheckGlucoses = <MedicalCheckGlucose>[];
      for (var doc in docs.docs) {
        medicalCheckGlucoses.add(MedicalCheckGlucose.fromMap(doc.data()));
      }
      return medicalCheckGlucoses;
    } catch (e) {
      return [];
    }
  }

  //read medicalActions
  static Future<List<MedicalAction>> readMedicalActions({
    required DocumentReference ref,
  }) async {
    try {
      var docs = await ref.collection('medicalActions').get();
      var medicalActions = <MedicalAction>[];
      for (var doc in docs.docs) {
        switch (doc.data()['name']) {
          case 'MedicalTakeInsulin':
            medicalActions.add(MedicalTakeInsulin.fromMap(doc.data()));
            break;
          case 'MedicalCheckGlucose':
            medicalActions.add(MedicalCheckGlucose.fromMap(doc.data()));
            break;
          default:
            break;
        }
      }
      return medicalActions;
    } catch (e) {
      return [];
    }
  }

  static Future<List<MedicalTakeInsulin>> readMedicalTakeInsulins({
    required DocumentReference ref,
  }) async {
    try {
      var docs = await ref.collection('medicalTakeInsulins').get();
      var medicalTakeInsulins = <MedicalTakeInsulin>[];
      for (var doc in docs.docs) {
        medicalTakeInsulins.add(MedicalTakeInsulin.fromMap(doc.data()));
      }
      return medicalTakeInsulins;
    } catch (e) {
      return [];
    }
  }

  static Future<String?> addMedicalTakeInsulins({
    required DocumentReference ref,
    required List<MedicalTakeInsulin> medicalTakeInsulins,
  }) async {
    try {
      //length of docs in collection
      int m = (await ref.collection('medicalTakeInsulins').get()).docs.length;
      int n = medicalTakeInsulins.length;
      for (int i = m; i < m + n; i++) {
        await ref.collection('medicalTakeInsulins').doc(addZero(i)).set(
              medicalTakeInsulins[i - m].toMap(),
            );
      }
    } catch (e) {
      return 'error';
    }
    return null;
  }

  //addMedicalCheckGlucoses
  static Future<String?> addMedicalCheckGlucoses({
    required DocumentReference ref,
    required List<MedicalCheckGlucose> medicalCheckGlucoses,
  }) async {
    try {
      //length of docs in collection
      int m = (await ref.collection('medicalCheckGlucoses').get()).docs.length;
      int n = medicalCheckGlucoses.length;
      for (int i = m; i < m + n; i++) {
        await ref.collection('medicalCheckGlucoses').doc(addZero(i)).set(
              medicalCheckGlucoses[i - m].toMap(),
            );
      }
    } catch (e) {
      return 'error';
    }
    return null;
  }

  //addMedicalActions
  static Future<String?> addMedicalActions({
    required DocumentReference ref,
    required List<dynamic> medicalActions,
  }) async {
    try {
      //length of docs in collection
      int m = (await ref.collection('medicalActions').get()).docs.length;
      int n = medicalActions.length;
      for (int i = m; i < m + n; i++) {
        switch (medicalActions[i - m].runtimeType) {
          case MedicalTakeInsulin:
            await ref.collection('medicalActions').doc(addZero(i)).set(
                  medicalActions[i - m].toMap(),
                );
            break;
          case MedicalCheckGlucose:
            await ref.collection('medicalActions').doc(addZero(i)).set(
                  medicalActions[i - m].toMap(),
                );
            break;
          default:
        }
      }
    } catch (e) {
      return 'error';
    }
    return null;
  }
}
