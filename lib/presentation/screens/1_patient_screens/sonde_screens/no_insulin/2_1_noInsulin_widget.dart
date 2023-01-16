// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/sonde_provider/no_insulin_provider.dart';
import 'package:data_app/data/models/sonde/no_insulin/no_insulin_cubit.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/no_insulin_sonde_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data_app/data/data_provider/regimen_provider.dart';
import 'package:data_app/data/models/models_export.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';

import '../../../../../data/models/enums.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import '2_1_1_check_glucose_widget.dart';

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
  final SondeCubit sondeCubit;
  const NoInsulinWidget({
    Key? key,
    required this.sondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
      child: Column(
        children: [
          Text('NoInsulinWidget'),
          BlocBuilder(
            bloc: sondeCubit,
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
          StreamBuilder(
              stream:
                  noInsulinAddress(context.read<CurrentProfileCubit>().state)
                      .snapshots(),
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
                  final List<QueryDocumentSnapshot<Map<String, dynamic>>>
                      documents = snapshot.data!.docs;

                  return Column(
                    children: [
                      // Text(status),
                      NoInsulinSondeSolve(
                        sondeCubit: sondeCubit,
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}

class NoInsulinSondeSolve extends StatelessWidget {
  final SondeCubit sondeCubit;
  const NoInsulinSondeSolve({
    Key? key,
    required this.sondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoInsulinSondeCubit noInsulinSondeCubit =
        NoInsulinSondeCubit(initNoInsulinSondeState());
    noInsulinSondeCubit.getFromFb(context.read<CurrentProfileCubit>().state);

    return BlocBuilder<NoInsulinSondeCubit, NoInsulinSondeState>(
        bloc: noInsulinSondeCubit,
        builder: (context, state) {
          final NoInsulinSondeState noInsulinState = noInsulinSondeCubit.state;
          switch (noInsulinState.noInsulinSondeStatus) {
            case NoInsulinSondeStatus.checkingGlucose:
              return Column(
                children: [
                  Text(noInsulinSondeCubit.state.noInsulinSondeStatus
                      .toString()),
                  CheckGlucoseWidget(
                    noInsulinSondeCubit: noInsulinSondeCubit,
                  ),
                ],
              );
            case NoInsulinSondeStatus.checkedGlucose:
              return Text('checkedGlucose');

            default:
              return Text('default');
          }
        });
  }
}
