// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:demo_app2/presentation/screens/1_patient_screens/sonde_screens/sonde_fast_insulin/2_1_1_check_glucose_widget.dart';

import '../../../../data/data_provider/sonde_provider/sonde_collections_provider.dart';
import '../../../../data/models/enum/enums.dart';
import '../../../../data/models/profile.dart';
import '../../../../data/models/sonde/6_sonde_state.dart';
import '../../../../data/models/sonde/sonde_lib.dart';

class SondeCubit extends Cubit<SondeState> {
  SondeCubit(SondeState initialState) : super(initialState);

  //catch state error
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

  Future<void> transfer(Profile profile) async {
    var ref = SondeCollectionsProvider.fastInsulinStateRef(profile);
    dynamic newStatus = SondeStatus.transferToYes;
    switch (state.status) {
      case SondeStatus.noInsulin:
        newStatus = SondeStatus.transferToYes;
        break;
      case SondeStatus.yesInsulin:
        newStatus = SondeStatus.transferToHigh;
        break;
      case SondeStatus.highInsulin:
        newStatus = SondeStatus.transferToFinish;
        break;
      default:
    }

    var _transfer = await FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .update({
      'status': EnumToString.enumToString(newStatus),
    });
  }

  Future<String?> transferData(Profile profile) async {
    var ref = SondeCollectionsProvider.fastInsulinStateRef(profile);
    var regimen =
        await SondeCollectionsProvider.getRegimenFastInsulinState(profile);
    var regimenSondeFast = RegimenSondeFast.fromRegimenAndCho(
      regimen,
      state.cho,
      EnumToName.sondeStatusToName(state.status),
    );
    if (regimen.medicalActions.length == 0) {
      return 'No medical actions';
    }
    var addHistory =
        await SondeCollectionsProvider.fastInsulinHistoryRef(profile)
            .doc(regimenSondeFast.lastTime().toString())
            .set(regimenSondeFast.toMap());
    var clearData = await ref.set(
      initialRegimenState().toMap(),
    );
    dynamic newState = SondeStatus.yesInsulin;
    switch (state.status) {
      case SondeStatus.transferToYes:
        newState = SondeStatus.yesInsulin;
        break;
      case SondeStatus.transferToHigh:
        newState = SondeStatus.highInsulin;

        break;
      case SondeStatus.transferToFinish:
        newState = SondeStatus.finish;
        break;
      default:
    }
    print('debug');
    var updateStatus = await FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .update({
      'status': EnumToString.enumToString(newState),
    });
    return null;
  }

  Future<void> switchStatusOnline(
      Regimen regimen, Profile profile, SondeStatus newStatus) async {
    var ref = SondeCollectionsProvider.fastInsulinStateRef(profile);

    var switchNewStatus = await FirebaseFirestore.instance
        .collection('groups')
        .doc(profile.room)
        .collection('patients')
        .doc(profile.id)
        .collection('medicalMethods')
        .doc('Sonde')
        .update({
      'status': EnumToString.enumToString(newStatus),
    });
  }
}
