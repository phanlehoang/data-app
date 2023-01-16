import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/models/models_export.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';

CollectionReference<Map<String, dynamic>> noInsulinAddress(Profile profile) {
  return FirebaseFirestore.instance
      .collection('groups')
      .doc(profile.room)
      .collection('patients')
      .doc(profile.id)
      .collection('medicalMethods')
      .doc('Sonde')
      .collection('NoInsulinState');
}

class NoInsulinWidget extends StatelessWidget {
  final Profile profile;
  final SondeCubit sondeStatusCubit;
  const NoInsulinWidget({
    required this.profile,
    Key? key,
    required this.sondeStatusCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
      child: Column(
        children: [
          Text('NoInsulinWidget'),
          BlocBuilder(
            bloc: sondeStatusCubit,
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
          StreamBuilder(
              stream: noInsulinAddress(profile).snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  if (!snapshot.hasData) {
                    return Text('No data');
                  }
                  return Text(snapshot.data!.docs.length.toString());
                }
              }),
        ],
      ),
    );
  }
}
