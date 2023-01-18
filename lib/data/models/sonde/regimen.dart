// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../time_controller.dart/sonde_range.dart';
import 'export_sonde_models.dart';

List<dynamic> dylist = [];

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
      medicalActions: [
        for (dynamic x in map['medicalActions'])
          if (x['name'] == 'MedicalCheckGlucose')
            MedicalCheckGlucose.fromMap(x)
          else if (x['name'] == 'MedicalTakeInsulin')
            MedicalTakeInsulin.fromMap(x),
      ],
      medicalCheckGlucoses: [
        for (dynamic x in map['medicalCheckGlucoses'])
          MedicalCheckGlucose.fromMap(x)
      ],
      medicalTakeInsulins: [
        for (dynamic x in map['medicalTakeInsulins'])
          MedicalTakeInsulin.fromMap(x)
      ],
    );
  }
  // @override
  // List<Object?> get props => [
  //       this.medicalActions,
  //       this.medicalCheckGlucoses,
  //       this.medicalTakeInsulins,
  //       this.currentInsulin,
  //     ];
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
    if (medicalActions.length == 0) return false;
    DateTime t = medicalTakeInsulins.last.time;
    return SondeRange.inSondeRange(t);
  }

  bool isFull50() {
    int counter = 0;
    for (var x in medicalCheckGlucoses) {
      if (x.glucoseUI > 8.3) counter++;
    }
    return counter >= 5;
  }

  DateTime lastTime() {
    if (medicalTakeInsulins.length == 0) return DateTime(1999);
    return medicalTakeInsulins.last.time;
  }
}

Regimen initialRegimen() {
  return Regimen(
    medicalActions: [],
    medicalCheckGlucoses: [],
    medicalTakeInsulins: [],
  );
}

bool isFinishRegimen(Regimen regimen) {
  if (regimen.medicalActions.length == 0) return false;
  DateTime t = regimen.medicalTakeInsulins.last.time;
  if (SondeRange.inSondeRangeToday(t) &&
      SondeRange.rangeContain(t) == SondeRange.rangeContain(DateTime.now())) {
    return true;
  } else {
    return false;
  }
}
