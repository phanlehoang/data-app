import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_provider/group_provider.dart';

class ListShortPatientsCubit extends Cubit<List<ShortPatient>> {
  @override
  void emit(dynamic state) {
    try {
      super.emit(state);
    } catch (e) {
      if (e == StateError('Cannot emit new states after calling close')) {
        return;
      }
    }
  }

  ListShortPatientsCubit() : super([]) {}

  void clear() => emit([]);

  Future<void> getPatientIdsFromGroupId(String groupId) async {
    //sau 2 giây sẽ kết thúc hàm
    await Future.delayed(Duration(seconds: 2));

    var patientIds;

    try {
      patientIds = await GroupRead.shortPatients(groupId);
    } catch (e) {
      print(e);
    }
    //if success
    if (patientIds != null) {
      emit(patientIds);
    }
  }

}

abstract class ListShortPatientsState {
  final List<ShortPatient> shortPatients;
  ListShortPatientsState({required this.shortPatients});
}

//init
class ListPatientIdsInitial extends ListShortPatientsState {
  ListPatientIdsInitial() : super(shortPatients: []);
}

class ShortPatient {
  final String id;
  final String name;
  final String medicalMethod;
  final String room;
  //constructer
  ShortPatient(
      {required this.id,
      required this.name,
      required this.medicalMethod,
      required this.room});
  //factory from Map
  factory ShortPatient.fromMap(Map<String, dynamic> map) {
    return ShortPatient(
        id: map['id'],
        name: map['name'],
        medicalMethod: map['medicalMethod'],
        room: map['room']);
  }
  //toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'medicalMethod': medicalMethod,
      'room': room
    };
  }

  //toString
  @override
  String toString() {
    return 'ShortPatient(id: $id, name: $name, medicalMethod: $medicalMethod, room: $room)';
  }
}
