import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/group_provider.dart';

class ListShortPatientsCubit extends Cubit<ListShortPatientsState> {
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

  ListShortPatientsCubit() : super(ListShortPatientsInitial());

  void clear() => emit([]);

  Future<void> getPatientIdsFromGroupId(String groupId) async {
    emit(ListShortPatientsLoading(shortPatients: state.shortPatients));

    var shortPatients;

    try {
      shortPatients = await GroupRead.shortPatients(groupId);
    } catch (e) {
      print(e);
      emit(ListShortPatientsError(shortPatients: state.shortPatients));
    }
    //if success
    if (shortPatients != null) {
      emit(ListShortPatientsLoaded(shortPatients: shortPatients));
    }
  }
}

abstract class ListShortPatientsState {
  final List<ShortPatient> shortPatients;
  ListShortPatientsState({required this.shortPatients});
}

//init
class ListShortPatientsInitial extends ListShortPatientsState {
  ListShortPatientsInitial() : super(shortPatients: []);
}

class ListShortPatientsLoading extends ListShortPatientsState {
  ListShortPatientsLoading({required List<ShortPatient> shortPatients})
      : super(shortPatients: shortPatients);
}

class ListShortPatientsLoaded extends ListShortPatientsState {
  ListShortPatientsLoaded({required List<ShortPatient> shortPatients})
      : super(shortPatients: shortPatients);
}

class ListShortPatientsError extends ListShortPatientsState {
  ListShortPatientsError({required List<ShortPatient> shortPatients})
      : super(shortPatients: shortPatients);
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
