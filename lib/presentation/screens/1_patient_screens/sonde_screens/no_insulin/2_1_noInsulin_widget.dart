// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/sonde_provider/no_insulin_provider.dart';
import 'package:data_app/data/models/sonde/no_insulin/no_insulin_cubit.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/no_insulin_sonde_cubit.dart';
import 'package:data_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data_app/data/data_provider/regimen_provider.dart';
import 'package:data_app/data/models/models_export.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';

import '../../../../../data/models/enums.dart';
import '../../../../../data/models/sonde/regimen.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import '2_1_1_checking_glucose_widget.dart';
import '2_1_2_checked_glucose_widget.dart';

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
  NoInsulinSondeSolve({
    Key? key,
    required this.sondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoInsulinSondeCubit noInsulinSondeCubit =
        NoInsulinSondeCubit(loadingNoInsulinSondeState());
    noInsulinSondeCubit.getFromFb(context.read<CurrentProfileCubit>().state);

    return Column(
      children: [
        Solve(noInsulinSondeCubit: noInsulinSondeCubit, sondeCubit: sondeCubit),
      ],
    );
  }
}

class Solve extends StatelessWidget {
  const Solve({
    super.key,
    required this.noInsulinSondeCubit,
    required this.sondeCubit,
  });

  final NoInsulinSondeCubit noInsulinSondeCubit;
  final SondeCubit sondeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeCheckCubit, int>(
      builder: (context, state) {
        return BlocBuilder(
            bloc: noInsulinSondeCubit,
            builder: (context, state) {
              final NoInsulinSondeState noInsulinState =
                  noInsulinSondeCubit.state;

              // lấy regimen hiện tại ra
              // final Regimen regimen = noInsulinState.regimen;
              // if (regimen.isFinishCurrentTask()) {
              //   return Text('Bạn đã hoàn thành điều trị');
              // }
              switch (noInsulinState.noInsulinSondeStatus) {
                case NoInsulinSondeStatus.loading:
                  {
                    return Column(
                      children: [
                        // Text(noInsulinSondeCubit.state.toString()),
                        Text('no ins loading'),
                      ],
                    );
                  }
                case NoInsulinSondeStatus.checkingGlucose:
                  {
                    if (noInsulinState.regimen.isFinishCurrentTask()) {
                      if (noInsulinState.regimen.isFull50()) {
                        sondeCubit.switchStatusOnline(
                            context.read<CurrentProfileCubit>().state,
                            SondeStatus.yesInsulin);
                      }
                      return Column(
                        children: [
                          Text('reg: \n' +
                              noInsulinSondeCubit.state.regimen.toString()),
                          Text('ins : \n ' +
                              noInsulinSondeCubit
                                  .state.regimen.medicalTakeInsulins
                                  .toString()),
                          Text('Bạn đã hoàn thành điều trị'),
                        ],
                      );
                    }

                    if (!noInsulinState.regimen.isFinishCurrentTask())
                      return Column(
                        children: [
                          Text('reg: \n' +
                              noInsulinSondeCubit.state.regimen.toString()),
                          Text('ins : \n ' +
                              noInsulinSondeCubit
                                  .state.regimen.medicalTakeInsulins
                                  .toString()),
                          CheckGlucoseWidget(
                            noInsulinSondeCubit: noInsulinSondeCubit,
                          ),
                        ],
                      );
                    return Text('đang kiểm tra');
                  }

                case NoInsulinSondeStatus.checkedGlucose:
                  return Column(
                    children: [
                      Text('reg: \n' +
                          noInsulinSondeCubit.state.regimen.toString()),
                      Text('ins : \n ' +
                          noInsulinSondeCubit.state.regimen.medicalTakeInsulins
                              .toString()),
                      CheckedGlucoseWidget(
                        sondeCubit: sondeCubit,
                        noInsulinSondeCubit: noInsulinSondeCubit,
                      ),
                    ],
                  );

                default:
                  return Text('default');
              }
            });
      },
    );
  }
}
