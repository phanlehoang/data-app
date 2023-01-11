import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/data_provider/patient_provider.dart';
import '../../../data/models/models_export.dart';

class ChooseMedicalMethodBloc extends FormBloc {
  Profile profile;
  final medicalMethod = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
  );
  //add fields
  ChooseMedicalMethodBloc({
    required this.profile,
  }) : super(isLoading: true) {
    addFieldBlocs(
      fieldBlocs: [
        medicalMethod,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() async {
    var ans = await PatientUpdate.updateProfileAttribute(
        profile, 'medicalMethod', medicalMethod.value);
    if (ans == null) {
      emitFailure(failureResponse: 'Error');
    } else {
      emitSuccess();
    }
  }
}
