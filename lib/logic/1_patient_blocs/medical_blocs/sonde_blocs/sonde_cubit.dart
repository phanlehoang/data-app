// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import '../../../../data/models/enums.dart';

class SondeCubit extends Cubit<SondeState> {
  SondeCubit(SondeState initialState) : super(initialState);
  void update(SondeState newState) {
    emit(newState);
  }
}

class SondeState {
  final SondeStatus status;
  num cho;
  num bonusInsulin;
  num weight;
  SondeState({
    required this.status,
    this.cho = 0,
    this.bonusInsulin = 0,
    this.weight = 0,
  });
  //clone
  SondeState clone() {
    return SondeState(
      status: status,
      cho: cho,
      bonusInsulin: bonusInsulin,
      weight: weight,
    );
  }

  //to Map
  Map<String, dynamic> toMap() {
    return {
      'status': EnumToString.enumToString(status),
      'cho': cho,
      'bonusInsulin': bonusInsulin,
      'weight': weight,
    };
  }

  //from Map

}

SondeState initSondeState() {
  return SondeState(status: SondeStatus.firstAsk);
}
