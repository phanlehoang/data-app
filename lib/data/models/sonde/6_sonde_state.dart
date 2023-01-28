import '../enum/enums.dart';

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

  //to String
  @override
  String toString() {
    return 'SondeState(status: $status, cho: $cho, bonusInsulin: $bonusInsulin, weight: $weight)';
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
  factory SondeState.fromMap(Map<String, dynamic> map) {
    try {
      return SondeState(
        status: StringToEnum.stringToSondeStatus(map['status']),
        cho: map['cho'],
        bonusInsulin: map['bonusInsulin'],
        weight: map['weight'],
      );
    } catch (e) {
      var a = initSondeState();
      return a;
    }
  }
}

SondeState initSondeState() {
  return SondeState(status: SondeStatus.firstAsk);
}
