// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

import 'enum/enums.dart';

class Profile {
  String id = '';
  String name = 'Unknown';
  num weight = 0;
  //height
  num height = 0;
  DateTime birthday;
  String address = '';
  String phone = '';
  Gender gender;
  MedicalMethod medicalMethod;
  String room;

  Profile({
    this.id = 'Unknown',
    this.name = 'Unknown',
    this.weight = 0,
    required this.height,
    required this.birthday,
    required this.address,
    required this.phone,
    required this.gender,
    required this.medicalMethod,
    required this.room,
  });
  //toMap
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'birthday':
          //TimeStamp to DateTime
          birthday,
      'address': address,
      'phone': phone,
      'gender': EnumToString.genderToString(gender),
      'medicalMethod': EnumToString.enumToString(medicalMethod),
    };
  }

  //fromMap
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
        id: map['id'],
        name: map['name'],
        weight: map['weight'],
        height: map['height'],
        birthday: map['birthday'].toDate(),
        address: map['address'],
        phone: map['phone'],
        gender: StringToEnum.stringToGender(map['gender']),
        medicalMethod: StringToEnum.stringToMedicalMethod(map['medicalMethod']),
        room: map['room']);
  }
  Profile clone() {
    return Profile(
      id: id,
      name: name,
      weight: weight,
      height: height,
      birthday: birthday,
      address: address,
      phone: phone,
      gender: gender,
      medicalMethod: medicalMethod,
      room: room,
    );
  }
  DocumentReference ref(){
    return FirebaseFirestore.instance.collection('groups').doc(room)
    .collection('patients').doc(id);
  }


  DocumentReference regimenStateStream() {
    return ref().collection('medicalMethods').doc('Sonde')
    .collection('regimen').doc('state');
  }
}

Profile unknownProfile() {
  return Profile(
    height: 170,
    birthday: DateTime(1999),
    address: 'VN',
    phone: '123',
    gender: Gender.Female,
    medicalMethod: MedicalMethod.Sonde,
    room: 'Unknown',
  );
}
