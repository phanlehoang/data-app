import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/models/profile.dart';

class DeletePatientButton extends StatelessWidget {
  const DeletePatientButton({
    super.key,
    required this.groupId,
    required this.patients,
    required this.i,
  });

  final groupId;
  final List<QueryDocumentSnapshot<Object?>> patients;
  final int i;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //làm sao để ấn vào chính giữa icon
      //increase size of button
      style: ElevatedButton.styleFrom(
        primary: Colors.yellow.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Icon(
        //biểu tượng thùng rác
        Icons.delete,
        color: Colors.red,
        size: 30,
      ),
      onPressed: () async {
        //hiển thị make sure dialog
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Xác nhận'),
              content: Text('Bạn có chắc chắn muốn xóa bệnh nhân này?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Không'),
                ),
                TextButton(
                  onPressed: () async {
                    deletePatient(
                        groupId, Profile.fromMap(patients[i]['profile']));
                    Navigator.of(context).pop();
                  },
                  child: Text('Có'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

Future<void> deletePatient(String groupId, Profile profile) async {
  var ref = FirebaseFirestore.instance
      .collection('groups')
      .doc(groupId)
      .collection('patients')
      .doc(profile.id);
  //b1: xóa collection FastInsulin, trong Sonde
  await deleteCollection(
      ref.collection('medicalMethods').doc('Sonde').collection('FastInsulin'));
  await deleteCollection(
      ref.collection('medicalMethods').doc('Sonde').collection('HistoryOld'));
  await deleteCollection(ref.collection('medicalMethods'));
  await ref.delete();
  //xóa
}

Future<void> deleteCollection(CollectionReference ref) async {
  await ref.get().then((value) => value.docs.forEach((element) {
        element.reference.delete();
      }));
}
