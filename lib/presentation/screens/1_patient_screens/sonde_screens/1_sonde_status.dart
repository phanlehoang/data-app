import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:data_app/data/models/enums.dart';
import 'package:data_app/data/models/sonde/sonde_lib.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/2_0_firstAsk_widget.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/fast_insulin_widget.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/models_export.dart';
import '../../../../logic/1_patient_blocs/current_profile_cubit.dart';
import '../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';

class SondeStatusWidget extends StatelessWidget {
  const SondeStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Profile profile = context.read<CurrentProfileCubit>().state;

    return NiceInternetScreen(
      child: Column(
        children: [
          StreamBuilder(
              stream: sondeReference(profile).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  if (snapshot.data!.exists) {
                    final Map<String, dynamic> sondeMap =
                        snapshot.data!.data() as Map<String, dynamic>;
                    final SondeState sondeState = SondeState.fromMap(sondeMap);
                    final SondeCubit _sondeCubit = SondeCubit(sondeState);
                    switch (sondeState.status) {
                      case SondeStatus.firstAsk:
                        return Column(
                          children: [
                            Text(sondeState.toString()),
                            FirstAskWidget(
                              sondeCubit: _sondeCubit,
                            ),
                          ],
                        );
                      case SondeStatus.noInsulin:
                        return Column(
                          children: [
                            Text('noInsulin'),
                            FastInsulinWidget(
                              sondeCubit: _sondeCubit,
                            ),
                          ],
                        );
                      case SondeStatus.yesInsulin:
                        return Column(
                          children: [
                            Text('yesInsulin'),
                            FastInsulinWidget(
                              sondeCubit: _sondeCubit,
                            ),
                          ],
                        );
                      case SondeStatus.highInsulin:
                        return Column(
                          children: [
                            Text('highInsulin'),
                            FastInsulinWidget(
                              sondeCubit: _sondeCubit,
                            ),
                          ],
                        );
                      case SondeStatus.transfer:
                        return Column(
                          children: [
                            Text('transfer'),
                            
                          ],
                        );  
                      default:
                        return Text('default');
                    }
                  }
                }
                return Text('no data');
              }),
        ],
      ),
    );
  }
}


