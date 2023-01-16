import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/1_sonde_status.dart';
import 'package:data_app/presentation/widgets/images/doctor_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/time_controller.dart/sonde_range.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

class InSondeRange extends Cubit<bool> {
  InSondeRange(bool state) : super(state);
}

class SondeScreen extends StatelessWidget {
  const SondeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InSondeRange>(
      create: (context) => InSondeRange(
        SondeRange.inSondeRangeToday(DateTime.now()),
      ),
      child: NiceScreen(
        child: Column(
          children: [
            DoctorImage(),
            StreamBuilder(
              stream: secondStream(),
              builder: (context, snapshot) {
                DateTime t = DateTime.now();
                if (SondeRange.inSondeRangeToday(t)) {
                  context.read<InSondeRange>().emit(true);
                } else {
                  context.read<InSondeRange>().emit(false);
                }
                return Text(t.toString());
              },
            ),
            BlocBuilder<InSondeRange, bool>(
              builder: (context, state) {
                if (!state) {
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
