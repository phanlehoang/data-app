import 'package:demo_app2/data/models/sonde/1_medical_action.dart';
import 'package:demo_app2/data/models/sonde/2_medical_check_glucose.dart';
import 'package:demo_app2/data/models/sonde/3_medical_take_insulin.dart';
export '1_enum_to_string.dart';
export '3_enum_to_name.dart';
export '2_string_to_enum.dart';
export '4_medical_action_to_name.dart';

enum Gender {
  Male,
  Female,
}

enum MedicalMethod {
  TPN,
  Sonde,
}

enum SondeStatus {
  firstAsk,
  noInsulin,
  transferToYes,
  yesInsulin,
  transferToHigh,
  highInsulin,
  transferToFinish,
  finish, 
}

enum RegimenStatus {
  error,
  checkingGlucose,
  givingInsulin,
}

enum InsulinType {
  Glargine,
  Actrapid,
  NPH,
}
