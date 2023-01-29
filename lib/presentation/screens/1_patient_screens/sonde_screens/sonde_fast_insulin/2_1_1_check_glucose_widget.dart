// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_collections_provider.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:demo_app2/data/data_provider/regimen_provider.dart';
import 'package:demo_app2/data/models/sonde/sonde_lib.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';

import '../../../../../data/models/enum/enums.dart';
import '../../../../../data/models/models_export.dart';
import '../../../../../logic/1_patient_blocs/current_profile_cubit.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/check_glucose_form_bloc.dart';

class CheckGlucoseWidget extends StatelessWidget {
  const CheckGlucoseWidget({
    super.key,
    required this.sondeFastInsulinCubit,
  });
  //query reference for state
  // doc Sonde -> col RegimenFastInsulin -> doc RegimenState

  final SondeFastInsulinCubit sondeFastInsulinCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Nhập glucose:'),
        BlocProvider<CheckGlucoseForm>(
          create: (_) => CheckGlucoseForm(
            sondeFastInsulinCubit: sondeFastInsulinCubit,
            profile: context.read<CurrentProfileCubit>().state,
          ),
          child: Builder(
            builder: (context) {
              final formBloc = context.read<CheckGlucoseForm>();
              return FormBlocListener<CheckGlucoseForm, String, String>(
                onSubmitting: (context, state) => CircularProgressIndicator(),
                onSuccess: (context, state) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Success'),
                    ),
                  );
                },
                child: Column(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFieldBlocBuilder(
                        textFieldBloc: formBloc.glucose,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    NiceButton(
                      onTap: formBloc.submit,
                      text: 'Tiếp tục',
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
