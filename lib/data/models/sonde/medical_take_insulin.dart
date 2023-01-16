// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/models/enums.dart';

import 'medical_action.dart';

class MedicalTakeInsulin extends MedicalAction {
  InsulinType insulinType;
  num insulinUI;
  MedicalTakeInsulin({
    required this.insulinType,
    required super.time,
    required this.insulinUI,
  });

  //List<Object?> get props => [this.time, this.insulinType, this.insulinUI];
  MedicalTakeInsulin clone() {
    return MedicalTakeInsulin(
      insulinType: insulinType,
      time: time,
      insulinUI: insulinUI,
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'name': 'MedicalTakeInsulin',
      'time': time,
      'insulinType': EnumToString.enumToString(insulinType),
      'insulinUI': insulinUI,
    };
  }

  //fromMap
  factory MedicalTakeInsulin.fromMap(Map<String, dynamic> map) {
    return MedicalTakeInsulin(
      insulinType: StringToEnum.stringToInsulinType(map['insulinType']),
      time: map['time'].toDate(),
      insulinUI: map['insulinUI'],
    );
  }

  @override
  String toString() {
    return '(${this.insulinUI} ${this.insulinType})';
  }
}

Timestamp a = Timestamp.now();
