import 'package:data_app/data/data_provider/sonde_provider/no_insulin_provider.dart';
import 'package:data_app/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:data_app/data/models/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/profile.dart';
import '../../../../data/models/sonde/regimen.dart';

class NoInsulinSondeCubit extends Cubit<NoInsulinSondeState> {
  NoInsulinSondeCubit(NoInsulinSondeState initialState) : super(initialState);

  Future<void> getFromFb(Profile profile) async {
    print('hi1');
    var newState =
        await NoInsulinSondeStateProvider.readNoInsulinState(profile: profile);
    emit(newState);
  }

  void update(NoInsulinSondeState newState) {
    emit(newState);
  }

  void switchToCheckingGlucose(Profile profile) {
    var newState = state.hotClone();
    //update state
    NoInsulinSondeStateProvider.updateNoInsulinStateStatus(
        profile: profile,
        noInsulinSondeStatus: NoInsulinSondeStatus.checkingGlucose);
    // newState.noInsulinSondeStatus = NoInsulinSondeStatus.checkingGlucose;
    // emit(newState);
  }
}

class NoInsulinSondeState {
  Regimen regimen;
  NoInsulinSondeStatus noInsulinSondeStatus;
  NoInsulinSondeState({
    required this.regimen,
    required this.noInsulinSondeStatus,
  });
  //clone
  NoInsulinSondeState hotClone() {
    return NoInsulinSondeState(
      regimen: regimen,
      noInsulinSondeStatus: noInsulinSondeStatus,
    );
  }

  //toMap
  Map<String, dynamic> toMapData() {
    return {
      'status': EnumToString.enumToString(noInsulinSondeStatus),
    };
  }

  //to String
  @override
  String toString() {
    return '''
      NoInsulinSondeState\(regimen: $regimen,
      noInsulinSondeStatus: $noInsulinSondeStatus)
 ''';
  }
}

//loading
NoInsulinSondeState loadingNoInsulinSondeState() {
  return NoInsulinSondeState(
    regimen: initialRegimen(),
    noInsulinSondeStatus: NoInsulinSondeStatus.loading,
  );
}

//init
NoInsulinSondeState initNoInsulinSondeState() {
  return NoInsulinSondeState(
    regimen: initialRegimen(),
    noInsulinSondeStatus: NoInsulinSondeStatus.checkingGlucose,
  );
}
