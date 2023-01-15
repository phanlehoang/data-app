import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final groupId = context.read<CurrentGroupIdCubit>().state;
    if (groupId == 'Unknown' || groupId == null) {
      return NiceScreen(child: Text('Chưa có nhóm nào được chọn'));
    }
    return StreamBuilder(
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
          return Column(
            children: [
              for (var i = 0; i < patients.length; i++)
                NiceItem(
                  index: i,
                  title: patients[i]['profile']['name'],
                  subtitle: patients[i]['profile']['id'],
                  trailing: Text(patients[i]['profile']['medicalMethod']),
                  onTap: () {
                    //go to patient screen
                    context.read<CurrentProfileCubit>().getProfile(
                          Profile.fromMap(patients[i]['profile']),
                        );
                    Navigator.of(context).pushReplacementNamed('/patient');
                    context.read<PatientNavigatorBarCubit>().update(0);
                    context.read<BottomNavigatorBarCubit>().update(1);
                  },
                )
            ],
          );
        }
      },
    );
  }
}
