import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/current_medical_method_cubit.dart';
import 'package:data_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../data/models/profile.dart';
import '../../../logic/global/current_group/current_group_cubit.dart';
import '../../widgets/nice_widgets/nice_export.dart';
import '../export_screen.dart';

class ListSyncPatients extends StatelessWidget {
  const ListSyncPatients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupIdCubit, String>(
      builder: (context, groupId) {
        if (groupId == 'Unknown') {
          return NiceScreen(
            child: Center(
              child: Text('Chưa có phòng nào được chọn'),
            ),
          );
        } else
          return ListPatients(
            groupId: groupId,
          );
      },
    );
  }
}

class ListPatients extends StatelessWidget {
  final groupId;
  const ListPatients({
    Key? key,
    this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .doc(groupId)
            .collection('patients')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else {
            final patients = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Phòng ${groupId} có ${patients.length} bệnh nhân'),
                      ButtonToCreatePatient(),
                    ],
                  ),
                  for (var i = 0; i < patients.length; i++)
                    NiceItem(
                      index: i,
                      title: patients[i]['profile']['name'],
                      subtitle: patients[i]['profile']['id'],
                      trailing: Column(
                        children: [
                          //icon rubbish
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: DeleteButton(
                                      groupId: groupId,
                                      patients: patients,
                                      i: i),
                                ),
                              ],
                            ),
                          ),
                          //edit Text
                          // SizedBox(
                          //   height: 15,
                          // ),
                          Text(
                            patients[i]['profile']['medicalMethod'],
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      onTap: () {
                        //go to patient screen
                        context.read<CurrentProfileCubit>().getProfile(
                              Profile.fromMap(patients[i]['profile']),
                            );
                        context.read<CurrentMedicalMethodCubit>().update(
                              context
                                  .read<CurrentProfileCubit>()
                                  .state
                                  .medicalMethod,
                            );
                        Navigator.of(context).pushReplacementNamed('/patient');
                        context.read<PatientNavigatorBarCubit>().update(0);
                        context.read<BottomNavigatorBarCubit>().update(1);
                      },
                    )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({
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
  await deleteCollection(ref
      .collection('medicalMethods')
      .doc('Sonde')
      .collection('HistoryOldFast'));
  await deleteCollection(ref.collection('medicalMethods'));
  await ref.delete();
  //xóa
}

Future<void> deleteCollection(CollectionReference ref) async {
  await ref.get().then((value) => value.docs.forEach((element) {
        element.reference.delete();
      }));
}
