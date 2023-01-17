// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_app/data/data_provider/sonde_provider/no_insulin_provider.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/no_insulin/give_insulin_logic.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:data_app/presentation/widgets/nice_widgets/2_nice_button.dart';
import 'package:flutter/material.dart';

import 'package:data_app/data/models/sonde/export_sonde_models.dart';
import 'package:data_app/data/models/sonde/no_insulin/no_insulin_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/enums.dart';
import '../../../../../data/models/models_export.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/no_insulin_sonde_cubit.dart';

class CheckedGlucoseWidget extends StatelessWidget {
  //sonde cubit
  final SondeCubit sondeCubit;
  final NoInsulinSondeCubit noInsulinSondeCubit;
  const CheckedGlucoseWidget({
    Key? key,
    required this.sondeCubit,
    required this.noInsulinSondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
        child: Column(
      children: [
        Text(noInsulinSondeCubit.state.toString()),
        BlocBuilder(
          bloc: noInsulinSondeCubit,
          builder: (context, state) {
            final NoInsulinSondeState value = noInsulinSondeCubit.state;
            switch (value.noInsulinSondeStatus) {
              case NoInsulinSondeStatus.checkedGlucose:
                {
                  num glu = value.regimen.lastGlu();
                  GlucoseEvaluation eval = GlucoseSolve.eval(glu);
                  String plusInsu = GlucoseSolve.plusInsulinNotice(glu);
                  String guide = GlucoseSolve.insulinGuideString(
                    noInsulinSondeState: value,
                    sondeState: sondeCubit.state,
                  );
                  num insulin = GlucoseSolve.insulinGuide(
                    noInsulinSondeState: value,
                    sondeState: sondeCubit.state,
                  );
                  return Column(
                    children: [
                      Text('CheckedGlucoseWidget'),
                      Text('Glucose: $glu'),
                      Text('Evaluation: $eval'),
                      Text('PlusInsu: $plusInsu'),
                      Text(guide),
                      NiceButton(
                          text: 'Tiếp tục',
                          onTap: () async {
                            await addInsulin(
                              noInsulinSondeCubit: noInsulinSondeCubit,
                              profile:
                                  context.read<CurrentProfileCubit>().state,
                              insulin: insulin,
                            );
                          }),
                    ],
                  );
                }

              default:
                {
                  return Text('default');
                }
            }
          },
        )
      ],
    ));
  }
}

Future<void> addInsulin(
    {required NoInsulinSondeCubit noInsulinSondeCubit,
    required Profile profile,
    required num insulin}) async {
  try {
    var trial = await NoInsulinSondeStateProvider.addInsulin(
      profile: profile,
      insulin: insulin,
    );
  } catch (e) {
    print(e);
  }
}
