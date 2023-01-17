import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/no_insulin_sonde_cubit.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';

enum GlucoseEvaluation {
  normal,
  high,
  low,
  veryhigh,
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
    return GlucoseEvaluation.veryhigh;
  }

  static String plusInsulinNotice(num glucose) {
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (eval(glucose)) {
      case GlucoseEvaluation.high:
        return 'Bổ sung 2 UI insulin Actrapid';
      case GlucoseEvaluation.veryhigh:
        return 'Bổ sung 4 UI insulin Actrapid';
      default:
        return '';
    }
  }

  static num plusInsulinAmount(num glucose) {
    final GlucoseEvaluation evaluation = eval(glucose);
    switch (evaluation) {
      case GlucoseEvaluation.high:
        return 2;
      case GlucoseEvaluation.veryhigh:
        return 4;
      default:
        return 0;
    }
  }

  static String insulinGuideString({
    required NoInsulinSondeState noInsulinSondeState,
    required SondeState sondeState,
  }) {
    num insulin = insulinGuide(
      noInsulinSondeState: noInsulinSondeState,
      sondeState: sondeState,
    );

    return 'Tiêm ${insulin} UI Insulin Actrapid';
  }

  static num insulinGuide({
    required NoInsulinSondeState noInsulinSondeState,
    required SondeState sondeState,
  }) {
    final num glu = noInsulinSondeState.regimen.lastGlu();
    final num cho = sondeState.cho;
    final num bonus = sondeState.bonusInsulin;
    final num plusInsu = plusInsulinAmount(glu);
    return insulinGuideCalculation(
      glu: glu,
      cho: cho,
      bonus: bonus,
      plusInsu: plusInsu,
    );
  }

  static insulinGuideCalculation({
    required num glu,
    required num cho,
    required num bonus,
    required num plusInsu,
  }) {
    return bonus + plusInsu + (cho / 15).round();
  }
}
