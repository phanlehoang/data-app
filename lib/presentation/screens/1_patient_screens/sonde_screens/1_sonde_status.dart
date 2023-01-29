import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/data/models/sonde/sonde_lib.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/2_0_firstAsk_widget.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/2_1_3_transfer_widget.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/fast_insulin_widget.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
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
                            //  Text(sondeState.toString()),
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
                      case SondeStatus.transferToYes:
                        return Column(
                          children: [
                            Text('transfer to yes'),
                            TransferWidget(
                              sondeCubit: _sondeCubit,
                              nextStatus: SondeStatus.yesInsulin,
                            ),
                          ],
                        );
                      case SondeStatus.transferToHigh:
                        return Column(
                          children: [
                            Text('transfer to high'),
                            TransferWidget(
                              sondeCubit: _sondeCubit,
                              nextStatus: SondeStatus.highInsulin,
                            ),
                          ],
                        );
                      case SondeStatus.transferToFinish:
                        return Column(
                          children: [
                            Text('transfer to finish'),
                            TransferWidget(
                              sondeCubit: _sondeCubit,
                              nextStatus: SondeStatus.finish,
                            ),
                          ],
                        );
                      case SondeStatus.finish:
                        return Text('Bạn đã xong toàn bộ phác đồ Sonde.');
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
