import '../sonde/sonde_lib.dart';

class MedicalActionToName {
  static String name(dynamic action) {
    switch (action.runtimeType) {
      case MedicalCheckGlucose:
        return 'Kiểm tra glucose';
      case MedicalTakeInsulin:
        return 'Tiêm insulin';

      default:
        return 'Unknown';
    }
  }
}
