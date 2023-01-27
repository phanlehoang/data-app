// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/sonde_provider/sonde_fast_insulin_provider.dart';
import 'package:data_app/data/models/sonde/2.5_list_medical_from_list_map.dart';
import 'package:data_app/data/models/sonde/3_medical_take_insulin.dart';
import 'package:data_app/data/models/sonde/5_regimen_state.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import 'package:data_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data_app/data/data_provider/regimen_provider.dart';
import 'package:data_app/data/models/models_export.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';

import '../../../../../data/models/enums.dart';
import '../../../../../data/models/sonde/2_medical_check_glucose.dart';
import '../../../../../data/models/sonde/4_regimen.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import '2_1_1_checking_glucose_widget.dart';
import '2_1_2_giving_insulin_widget.dart';

class FastInsulinWidget extends StatelessWidget {
  final SondeCubit sondeCubit;
  const FastInsulinWidget({
    Key? key,
    required this.sondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile profile = context.read<CurrentProfileCubit>().state;
    return NiceScreen(
      child: Column(
        children: [
          Text('FastInsulinWidget'),
          BlocBuilder(
            bloc: sondeCubit,
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
          StreamBuilder(
              stream: RefProvider.fastInsulinStateRef(profile).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  if (!snapshot.hasData) {
                    return Text('No data');
                  }
                  final map = snapshot.data!.data() as Map<String, dynamic>;
                  RegimenState regimenState = RegimenState.fromMap(map);

                  return Column(
                    children: [
                      Text(regimenState.toString()),
                      FastInsulinSolve(
                          sondeFastInsulinCubit:
                              SondeFastInsulinCubit(regimenState),
                          sondeCubit: sondeCubit),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}

class FastInsulinSolve extends StatelessWidget {
  const FastInsulinSolve({
    super.key,
    required this.sondeFastInsulinCubit,
    required this.sondeCubit,
  });

  final SondeFastInsulinCubit sondeFastInsulinCubit;
  final SondeCubit sondeCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
            bloc: sondeFastInsulinCubit,
            builder: (context, state) {
              final RegimenState regimenState = sondeFastInsulinCubit.state;
              // if (regimenState.regimen.checkGoToYesInsAgain()) {
              //   sondeCubit.goToNextStatus(
              //     sondeFastInsulinCubit.state.regimen,
              //       context.read<CurrentProfileCubit>().state,
              //     );
              // }
              switch (regimenState.status) {
                case RegimenStatus.error:
                  {
                    return Text('error');
                  }

                case RegimenStatus.checkingGlucose:
                  {
                    if (regimenState.regimen.isFinishCurrentTask()) {
                      if (regimenState.regimen.isHot()) {
                        sondeCubit.transfer(
                            context.read<CurrentProfileCubit>().state);
                      }
                      return Column(
                        children: [
                          Text(regimenState.regimen.isHot().toString()),
                          Text('Bạn đã hoàn thành điều trị'),
                        ],
                      );
                    }

                    if (!regimenState.regimen.isFinishCurrentTask())
                      return Column(
                        children: [
                          CheckGlucoseWidget(
                            sondeFastInsulinCubit: sondeFastInsulinCubit,
                          ),
                        ],
                      );
                    return Text('đang kiểm tra');
                  }

                case RegimenStatus.givingInsulin:
                  return Column(
                    children: [
                      GivingInsulinWidget(
                        sondeFastInsulinCubit: sondeFastInsulinCubit,
                        sondeCubit: sondeCubit,
                      ),
                    ],
                  );

                default:
                  return Text('default');
              }
            }),
        Text('FastInsulinSolve'),
      ],
    );
  }
}
