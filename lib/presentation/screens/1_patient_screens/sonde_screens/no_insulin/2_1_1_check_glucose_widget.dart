// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_app/data/data_provider/sonde_provider/no_insulin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:data_app/data/data_provider/regimen_provider.dart';
import 'package:data_app/data/models/sonde/export_sonde_models.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/no_insulin_sonde_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/nice_export.dart';

import '../../../../../data/models/enums.dart';
import '../../../../../data/models/models_export.dart';
import '../../../../../logic/1_patient_blocs/current_profile_cubit.dart';

class CheckGlucoseWidget extends StatelessWidget {
  //add noInsulinSondeCubit
  final NoInsulinSondeCubit noInsulinSondeCubit;
  const CheckGlucoseWidget({
    Key? key,
    required this.noInsulinSondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
        child: Column(
      children: [
        Text('Nhập glucose:'),
        BlocProvider<CheckGlucoseForm>(
          create: (_) => CheckGlucoseForm(
            noInsulinSondeCubit: noInsulinSondeCubit,
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
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.glucose,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Glucose',
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: formBloc.submit,
                      child: Text('Tiếp tục'),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}

enum GlucoseEvaluation {
  normal,
  high,
  low,
  veryhigh,
}

class GlucoseSolve {
  static GlucoseEvaluation eval(num glucose) {
    if (glucose < 3.9) {
      return GlucoseEvaluation.low;
    }
    if (glucose <= 8.3) {
      return GlucoseEvaluation.normal;
    }
    if (glucose <= 11.1) {
      return GlucoseEvaluation.high;
    }
    return GlucoseEvaluation.veryhigh;
  }

  static String plusInsulinNotice(num glucose) {
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (eval(glucose)) {
      case GlucoseEvaluation.high:
        return 'Bổ sung 2 UI insulin Actrapid';
      case GlucoseEvaluation.veryhigh:
        return 'Bổ sung 4 UI insulin Actrapid';
      default:
        return '';
    }
  }

  static num plusInsulinAmount(num glucose) {
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (evaluation) {
      case GlucoseEvaluation.high:
        return 2;
      case GlucoseEvaluation.veryhigh:
        return 4;
      default:
        return 0;
    }
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

  final NoInsulinSondeCubit noInsulinSondeCubit;
  final Profile profile;
  final glucose = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  CheckGlucoseForm({
    required this.noInsulinSondeCubit,
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
    Regimen addRegimen = initialRegimen();
    addRegimen.addMedicalAction(medicalCheckGlucose);
    try {
      var add =
          await SondeNoInsulinRegimenProvider.addRegimen(profile, addRegimen);
      //update checked
      var checkedUpdate =
          await NoInsulinSondeStateProvider.updateNoInsulinStateStatus(
              profile: profile,
              noInsulinSondeStatus: NoInsulinSondeStatus.checkedGlucose);
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    emitSuccess();
    noInsulinSondeCubit.getFromFb(profile);
  }
}
