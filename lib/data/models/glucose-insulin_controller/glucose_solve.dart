import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import 'package:demo_app2/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';

import '../sonde/sonde_lib.dart';

enum GlucoseEvaluation {
  normal,
  high,
  low,
  superHigh,
}

class GlucoseSolve {
  static GlucoseEvaluation eval(num glucose) {
    if (glucose < 3.9) {
      return GlucoseEvaluation.low;
    }
    if (glucose <= 8.3) {
      return GlucoseEvaluation.normal;
    }
    if (glucose <= 11.1) {
      return GlucoseEvaluation.high;
    }
    return GlucoseEvaluation.superHigh;
  }
   static num plusInsulinAmount(num glucose) {
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (evaluation) {
      case GlucoseEvaluation.high:
        return 2;
      case GlucoseEvaluation.superHigh:
        return 4;
      default:
        return 0;
    }
  }

  static String plusInsulinGuide(num glucose) {
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (eval(glucose)) {
      case GlucoseEvaluation.high:
        return '';
      case GlucoseEvaluation.superHigh:
        return '';
      default:
        return 'Duy trì lượng insulin như cũ';
    }
  }

 

  static String insulinGuideString({
    required Regimen regimen,
    required SondeState sondeState,
  }) {
    num insulin = insulinGuide(
      regimen: regimen,
      sondeState: sondeState,
    );
    return 'Tiêm ${insulin} UI Insulin Actrapid';
  }

  static num insulinGuide({
    required Regimen regimen,
    required SondeState sondeState,
  }) {
    final num glu = regimen.lastGlu();
    final num cho = sondeState.cho;
    final num bonus = sondeState.bonusInsulin;
    final num plus = plusInsulinAmount(glu);
    return insulinGuideCalculation(
      glu: glu,
      cho: cho,
      bonus: bonus,
      plus: plus,
    );
  }

  static insulinGuideCalculation({
    required num glu,
    required num cho,
    required num bonus,
    required num plus,
  }) {
    return bonus + plus + (cho / 15).round();
  }
}
