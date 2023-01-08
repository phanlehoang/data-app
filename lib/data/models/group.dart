// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String id;
  String nameMaster;
  List<String> Patients;
  Group({
    required this.id,
    required this.nameMaster,
    required this.Patients,
  });
}
