// TransferWidget
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/enums.dart';

class TransferWidget extends StatelessWidget {
  final SondeCubit sondeCubit;
  final SondeStatus nextStatus;

  const TransferWidget(
      {super.key, required this.sondeCubit, required this.nextStatus});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //sonde
    print('trans');
    sondeCubit.transferData(
      context.read<CurrentProfileCubit>().state,
    );

    return Column(
      children: [
        Text('hi hi ha ha'),
      ],
    );
  }
}
