// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/models/enums.dart';
import 'package:data_app/data/models/sonde/2.5_list_medical_from_list_map.dart';

import '../time_controller/sonde_range.dart';
import 'sonde_lib.dart';

class Regimen {
  List<dynamic> medicalActions;
  List<MedicalCheckGlucose> medicalCheckGlucoses;
  List<MedicalTakeInsulin> medicalTakeInsulins;

  Regimen({
    required this.medicalActions,
    required this.medicalCheckGlucoses,
    required this.medicalTakeInsulins,
  });

  void addMedicalAction(dynamic medicalAction) {
    medicalActions.add(medicalAction.clone());
    if (medicalAction.runtimeType == MedicalCheckGlucose) {
      addMedicalCheckGlucose(medicalAction);
    } else if (medicalAction.runtimeType == MedicalTakeInsulin) {
      addMedicalTakeInsulin(medicalAction);
    }
  }

  void addMedicalCheckGlucose(MedicalCheckGlucose medicalCheckGlucose) {
    medicalCheckGlucoses.add(medicalCheckGlucose.clone());
  }

  void addMedicalTakeInsulin(MedicalTakeInsulin medicalTakeInsulin) {
    medicalTakeInsulins.add(medicalTakeInsulin.clone());
  }

  @override
  String toString() {
    dynamic medicalActions_str = medicalActions.toString();
    return 'Regimen ${medicalActions_str}';
  }
  //toMap

  Map<String, dynamic> toMap() {
    return {
      'medicalActions': [for (dynamic x in medicalActions) x.toMap()],
      'medicalCheckGlucoses': [
        for (MedicalCheckGlucose x in medicalCheckGlucoses) x.toMap()
      ],
      'medicalTakeInsulins': [
        for (MedicalTakeInsulin x in medicalTakeInsulins) x.toMap()
      ],
    };
  }

  //fromMap
  factory Regimen.fromMap(Map<String, dynamic> map) {
    return Regimen(
      medicalActions:
          ListMedicalFromListMap.medicalActions(map['medicalActions']),
      medicalCheckGlucoses: ListMedicalFromListMap.medicalCheckGlucoses(
          map['medicalCheckGlucoses']),
      medicalTakeInsulins: ListMedicalFromListMap.medicalTakeInsulins(
          map['medicalTakeInsulins']),
    );
  }
  //from snapshot
  factory Regimen.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return Regimen.fromMap(map);
  }
  Regimen clone() {
    return Regimen(
      medicalActions: [for (dynamic x in medicalActions) x.clone()],
      medicalCheckGlucoses: [
        for (MedicalCheckGlucose x in medicalCheckGlucoses) x.clone()
      ],
      medicalTakeInsulins: [
        for (MedicalTakeInsulin x in medicalTakeInsulins) x.clone()
      ],
    );
  }

  num lastGlu() {
    if (medicalCheckGlucoses.length == 0) return 0;
    return medicalCheckGlucoses.last.glucoseUI;
  }

// Kiểm tra xem medicalaction cuối ở rangetime trước
  bool isFinishCurrentTask() {
    if (medicalTakeInsulins.length == 0) return false;
    DateTime t = medicalTakeInsulins.last.time;
    if (SondeRange.inSondeRangeToday(t) &&
        SondeRange.rangeContain(t) == SondeRange.rangeContain(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  bool isInCurrentTask() {
    if (medicalTakeInsulins.length == 0) return false;
    DateTime t = medicalTakeInsulins.last.time;
    return SondeRange.inSondeRange(t);
  }

  bool isFull50() {
    int counter = 0;
    for (var x in medicalCheckGlucoses) {
      if (x.glucoseUI > 8.3) counter++;
    }
    return counter >= 1;
  }

  DateTime lastTime() {
    if (medicalTakeInsulins.length == 0) return DateTime(1999);
    return medicalTakeInsulins.last.time;
  }

  bool checkGoToYesInsAgain() {
    return isFull50() && !isInCurrentTask();
  }

  bool isHot() {
    return isFull50() && isFinishCurrentTask();
  }
}

Regimen initialRegimen() {
  return Regimen(
    medicalActions: [],
    medicalCheckGlucoses: [],
    medicalTakeInsulins: [],
  );
}
