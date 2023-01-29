import '../enum/enums.dart';
import '4_regimen.dart';

class RegimenState {
 // String name;
  RegimenStatus status;
  Regimen regimen;
  RegimenState({
    required this.status,
    required this.regimen,
  });
  //clone
  RegimenState hotClone() {
    return RegimenState(
      status: status,
      regimen: regimen,
    );
  }

  //toMap
  Map<String, dynamic> toMap() {
    return {
      'status': EnumToString.enumToString(status),
      'regimen': regimen.toMap(),
    };
  }

  //from Map
  factory RegimenState.fromMap(Map<String, dynamic>? map) {
    if (map == null)
      return RegimenState(
        status: RegimenStatus.checkingGlucose,
        regimen: initialRegimen(),
      );
    return RegimenState(
      status: StringToEnum.stringToRegimenStatus(map['status']),
      regimen: Regimen.fromMap(map['regimen']),
    );
  }
  //to String
  @override
  String toString() {
    return 'RegimenState:\n {status: $status, \n regimen: $regimen} ';
  }
}

//init Regimen State
RegimenState initialRegimenState() {
  return RegimenState(
    status: RegimenStatus.checkingGlucose,
    regimen: initialRegimen(),
  );
}

RegimenState errorRegimenState() {
  return RegimenState(
    status: RegimenStatus.error,
    regimen: initialRegimen(),
  );
}
