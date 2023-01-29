import 'dart:async';

import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/current_medical_method_cubit.dart';
import 'package:demo_app2/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/data_provider/patient_provider.dart';
import '../../../data/models/models_export.dart';

class ChooseMedicalMethodBloc extends FormBloc<String, String> {
  Profile profile;
  final CurrentMedicalMethodCubit currentMedicalMethodCubit;
  final medicalMethod = SelectFieldBloc(
    items: ['TPN', 'Sonde'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  //emit

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

  //add fields
  ChooseMedicalMethodBloc({
    required this.profile,
    required this.currentMedicalMethodCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        medicalMethod,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      var update = await PatientUpdate.updateProfileAttribute(
        profile: profile,
        attribute: 'medicalMethod',
        value: medicalMethod.value,
      );
    } catch (e) {
      emitFailure(failureResponse: e.toString());
      return;
    }
    currentMedicalMethodCubit.update(
      medicalMethod.value == 'TPN' ? MedicalMethod.TPN : MedicalMethod.Sonde,
    );
    emitSuccess();
  }
}
