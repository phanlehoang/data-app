import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_collections_provider.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/profile.dart';

import '../../../../data/models/sonde/sonde_lib.dart';

class SondeFastInsulinCubit extends Cubit<RegimenState> {
  SondeFastInsulinCubit(RegimenState initialState) : super(initialState);

  Future<void> getFromFb(Profile profile) async {
    var ref = SondeCollectionsProvider.fastInsulinStateRef(profile);
    var doc = await ref.get();
    if (doc.exists) {
      var _state = RegimenState.fromMap(doc.data() as Map<String, dynamic>);
      emit(_state);
    } else {
      emit(errorRegimenState());
    }
  }

  void update(dynamic newState) {
    emit(newState);
  }

  void switchToCheckingGlucose(
    Profile profile,
    Regimen oldRegimen,
  ) async {
    var ref = SondeCollectionsProvider.fastInsulinStateRef(profile);

    var update = await ref.set({
      'status': EnumToString.enumToString(RegimenStatus.checkingGlucose),
    });
  }
}
