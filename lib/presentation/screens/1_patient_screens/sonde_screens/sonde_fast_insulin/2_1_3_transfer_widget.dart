// TransferWidget
import 'package:demo_app2/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/enum/enums.dart';

class TransferWidget extends StatelessWidget {
  final SondeCubit sondeCubit;
  final SondeStatus nextStatus;

  const TransferWidget(
      {super.key, required this.sondeCubit, required this.nextStatus});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //sonde
    sondeCubit.transferData(
      context.read<CurrentProfileCubit>().state,
    );

    return Column(
      children: [
        Text('Đang chuyển phác đồ'),
      ],
    );
  }
}
