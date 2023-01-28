// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/data_provider/sonde_provider/sonde_fast_insulin_provider.dart';
import 'package:data_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:data_app/data/data_provider/regimen_provider.dart';
import 'package:data_app/data/models/sonde/sonde_lib.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/nice_export.dart';

import '../../../../../data/models/enums.dart';
import '../../../../../data/models/models_export.dart';
import '../../../../../logic/1_patient_blocs/current_profile_cubit.dart';

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

class CheckGlucoseForm extends FormBloc<String, String> {
  @override
  void emit(dynamic state) {
    try {
      super.emit(state);
    } catch (e) {
      if (e == StateError('Cannot emit new states after calling close')) {
        return;
      }
    }
  }

  final SondeFastInsulinCubit sondeFastInsulinCubit;
  final Profile profile;
  final glucose = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  CheckGlucoseForm({
    required this.sondeFastInsulinCubit,
    required this.profile,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        glucose,
      ],
    );
  }
  @override
  Future<void> onSubmitting() async {
    MedicalCheckGlucose medicalCheckGlucose = MedicalCheckGlucose(
      time: DateTime.now(),
      glucoseUI: num.parse(glucose.value),
    );

    try {
      //dia chi no insulin sonde state
      var fastInsulinStateRef = RefProvider.fastInsulinStateRef(profile);
      var updateRegimen = await fastInsulinStateRef.update({
        'regimen.medicalCheckGlucoses':
            FieldValue.arrayUnion([medicalCheckGlucose.toMap()]),
        'regimen.medicalActions':
            FieldValue.arrayUnion([medicalCheckGlucose.toMap()]),
      });

      //update checking glucose status -> giving insulin
      var updateRegimenStatus =
          await fastInsulinStateRef.update({'status': 'givingInsulin'});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    //noInsulinSondeCubit.emit(loadingNoInsulinSondeState());
    emitSuccess();
  }
}
