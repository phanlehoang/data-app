

import 'dart:async';

import 'package:data_app/data/models/sonde/4_regimen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../enum/enums.dart';
import '../profile.dart';
import '5_regimen_state.dart';
import '6_sonde_state.dart';

class SondeProcedure {
  SondeState state;
  List<RegimenSondeFast> historyOld;
  RegimenState regimenState;
  SondeProcedure({
    required this.state,
    required this.historyOld,
    required this.regimenState,
  });
  //toString 
  @override
  String toString() {
    return 'SondeProcedure: {state: $state,\n historyOld: $historyOld,\n regimenState: $regimenState}';
  }
}
class SondeProcedureOnlineCubit extends Cubit<SondeProcedure> {
  late StreamSubscription _regimenStateSubscription;
  late StreamSubscription _sondeStateSubscription;
  late StreamSubscription _historyOldSubscription;

  SondeProcedureOnlineCubit({required Profile profile }) : super(SondeProcedure(
    state: SondeState(
      status: SondeStatus.firstAsk,
    ),
    historyOld: [],
    regimenState: initialRegimenState(),
  )){
    _regimenStateSubscription = profile.regimenStateStream.listen((regimenState) {
      emit(state.copyWith(regimenState: regimenState));
    });
    _sondeStateSubscription = profile.sondeStateStream.listen((sondeState) {
      emit(state.copyWith(state: sondeState));
    });
    _historyOldSubscription = profile.historyOldStream.listen((historyOld) {
      emit(state.copyWith(historyOld: historyOld));
    });
  }
}
