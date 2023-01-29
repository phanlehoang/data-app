import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/data_provider/sonde_provider/sonde_collections_provider.dart';
import '../../../../data/models/models_export.dart';
import '../../../../data/models/sonde/sonde_lib.dart';

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
      var fastInsulinStateRef =
          SondeCollectionsProvider.fastInsulinStateRef(profile);
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
