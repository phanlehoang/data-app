// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:data_app/data/data_provider/sonde_provider/no_insulin_provider.dart';
import 'package:data_app/data/models/sonde/export_sonde_models.dart';
import 'package:data_app/data/models/sonde/no_insulin/no_insulin_cubit.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/no_insulin/give_insulin_logic.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:data_app/presentation/widgets/nice_widgets/2_nice_button.dart';

import '../../../../../data/data_provider/regimen_provider.dart';
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
                  num plus = GlucoseSolve.plusInsulinAmount(glu);
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
                      BlocProvider<CheckedSubmit>(
                          create: (context) => CheckedSubmit(
                                noInsulinSondeCubit: noInsulinSondeCubit,
                                profile:
                                    context.read<CurrentProfileCubit>().state,
                                insulin: insulin,
                                plus: plus,
                              ),
                          child: Builder(builder: (_) {
                            return FormBlocListener<CheckedSubmit, String,
                                String>(
                              onSuccess: (cc, state) {
                                ScaffoldMessenger.of(cc).showSnackBar(
                                  SnackBar(
                                    content: Text('Success'),
                                  ),
                                );
                                noInsulinSondeCubit
                                    .emit(loadingNoInsulinSondeState());
                              },
                              onFailure: (cc, state) {
                                ScaffoldMessenger.of(cc).showSnackBar(
                                  SnackBar(
                                    content: Text('Failure'),
                                  ),
                                );
                              },
                              child: NiceButton(
                                text: 'Submit',
                                onTap: () {
                                  _.read<CheckedSubmit>().submit();
                                },
                              ),
                            );
                          }))
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
    {required Profile profile, required num insulin}) async {}

class CheckedSubmit extends FormBloc<String, String> {
  final Profile profile;
  final num insulin;
  final num plus;
  final NoInsulinSondeCubit noInsulinSondeCubit;
  CheckedSubmit({
    required this.noInsulinSondeCubit,
    required this.profile,
    required this.insulin,
    required this.plus,
  });
  @override
  FutureOr<void> onSubmitting() async {
    MedicalTakeInsulin medicalTakeInsulin = MedicalTakeInsulin(
      insulinUI: insulin,
      time: DateTime.now(),
      insulinType: InsulinType.Actrapid,
    );
    Regimen addRegimen = initialRegimen();
    addRegimen.addMedicalAction(medicalTakeInsulin);
    try {
      var add =
          await SondeNoInsulinRegimenProvider.addRegimen(profile, addRegimen);
      //update checked
      var checkedUpdate =
          await NoInsulinSondeStateProvider.updateNoInsulinStateStatus(
              profile: profile,
              noInsulinSondeStatus: NoInsulinSondeStatus.checkingGlucose);
      //update bonus insulin
      var updateBonus = await FirebaseFirestore.instance
          .collection('groups')
          .doc(profile.room)
          .collection('patients')
          .doc(profile.id)
          .collection('medicalMethods')
          .doc('Sonde')
          .update({'bonusInsulin': FieldValue.increment(plus)});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    //   noInsulinSondeCubit.emit(loadingNoInsulinSondeState());
    emitSuccess();
  }
}
