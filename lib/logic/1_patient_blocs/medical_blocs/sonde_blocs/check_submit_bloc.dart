import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/data_provider/sonde_provider/sonde_collections_provider.dart';
import '../../../../data/models/enum/enums.dart';
import '../../../../data/models/models_export.dart';
import '../../../../data/models/sonde/sonde_lib.dart';

class CheckedSubmit extends FormBloc<String, String> {
  final Profile profile;
  final num insulin;
  final num plus;
  final SondeFastInsulinCubit sondeFastInsulinCubit;
  CheckedSubmit({
    required this.sondeFastInsulinCubit,
    required this.profile,
    required this.insulin,
    required this.plus,
  });
  @override
  Future<void> onSubmitting() async {
    MedicalTakeInsulin medicalTakeInsulin = MedicalTakeInsulin(
      insulinUI: insulin,
      time: DateTime.now(),
      insulinType: InsulinType.Actrapid,
    );

    try {
      var fastInsulinStateRef =
          SondeCollectionsProvider.fastInsulinStateRef(profile);
      //update take insulin
      var add = await fastInsulinStateRef.update(
        {
          'regimen.medicalTakeInsulins': FieldValue.arrayUnion(
            [medicalTakeInsulin.toMap()],
          ),
          'regimen.medicalActions': FieldValue.arrayUnion(
            [medicalTakeInsulin.toMap()],
          ),
        },
      );

      //update status to checkingGlucose
      var updateStatus =
          await fastInsulinStateRef.update({'status': 'checkingGlucose'});
      var updateBonus = await FirebaseFirestore.instance
          .collection('groups')
          .doc(profile.room)
          .collection('patients')
          .doc(profile.id)
          .collection('medicalMethods')
          .doc('Sonde')
          .update({'bonusInsulin': FieldValue.increment(plus)});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    //   sondeFastInsulinCubit.emit(loadingNoInsulinSondeState());
    emitSuccess();
  }
}
