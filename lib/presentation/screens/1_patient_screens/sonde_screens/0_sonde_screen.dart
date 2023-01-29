import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/1_sonde_status.dart';
import 'package:demo_app2/presentation/widgets/images/doctor_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/time_controller/sonde_range.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

class InSondeRange extends Cubit<int?> {
  InSondeRange(int? state) : super(state);
}

class SondeScreen extends StatelessWidget {
  const SondeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InSondeRange>(
      create: (context) => InSondeRange(
        SondeRange.rangeContain(DateTime.now()),
      ),
      child: NiceScreen(
        child: Column(
          children: [
            DoctorImage(),
            StreamBuilder(
              stream: secondStream(),
              builder: (context, snapshot) {
                DateTime t = DateTime.now();
                context.read<InSondeRange>().emit(SondeRange.rangeContain(t));

                return Text(t.toString());
              },
            ),
            BlocBuilder<InSondeRange, int?>(
              builder: (context, state) {
                if (state == null) {
                  return Text(SondeRange.waitingMessage(DateTime.now()));
                } else {
                  return SondeStatusWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
