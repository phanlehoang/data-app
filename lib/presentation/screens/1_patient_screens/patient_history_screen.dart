import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/1_patient_blocs/current_profile_cubit.dart';
import '../../../logic/global/current_group/current_group_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';

class PatientHistoryScreen extends StatelessWidget {
  const PatientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('groups')
                .doc(context.read<CurrentProfileCubit>().state.room)
                .collection('patients')
                .doc(context.read<CurrentProfileCubit>().state.id)
                .snapshots(),
            builder: (context, snapshot) {
              return Text('history');
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
